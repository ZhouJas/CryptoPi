const express = require('express')
const router = express.Router()
const User = require('../models/User')
const Web3 = require('web3')
var web3 = new Web3('https://rinkeby.infura.io/sampleaddress'); //API provider here
const Transaction = require('../models/Transaction')



// USE THE WEB3.JS library --> connect to ethereum
// Azure cognitive api
//Azure stuff that may need to be kept here
'use strict';

const axios = require('axios').default;

// Add a valid subscription key and endpoint to your environment variables.
let subscriptionKey = '073d80b4a8f748aa8632acafc333959a'
let endpoint = ['https://crypto-pi.cognitiveservices.azure.com/face/v1.0/detect', 'https://crypto-pi.cognitiveservices.azure.com/face/v1.0/findsimilars']

router.post('/createTransaction', function (req, res) { // http://localhost:8080/transactions/createTransaction
    //Transfer funds via ethereum. Additional funds will be exhausted from senderfor gas (trasnaction fee)
    //All units are in Wei (10^-18 eth)
    const tag = req.body.tag; //sender
    const reader = req.body.reader; //receiver
    const amount = req.body.money;
    const note = req.body.note;
    const facePicture = req.body.file;


    User.findOne({ piTag: tag }).then((user) => {
        User.findOne({ piTag: reader }).then((counter) => { //this will be the code to use when we integrate the pis

            if (user == null) res.status(404).send('Error fetching User details')

            //AZURE STUFF
            var ID, faceId


            axios({
                method: 'post',
                url: endpoint[0],
                params: {
                    detectionModel: 'detection_02',
                    returnFaceId: true,
                    recognitionModel: 'recognition_03'
                },
                data: {
                    url: facePicture,
                },
                headers: { 'Ocp-Apim-Subscription-Key': subscriptionKey }
            }).then(function (response) {

                console.log(response.data)
                ID = response.data[0].faceId

                axios({
                    method: 'post',
                    url: endpoint[1],
                    data: {
                        faceId: ID,
                        faceListId: "crypto-pi",
                        maxNumOfCandidatesReturned: 1
                    },
                    headers: { 'Ocp-Apim-Subscription-Key': subscriptionKey }
                }).then(function (response) {

                    console.log(response.data)
                    if (response.data.length == 0 || response.data[0].persistedFaceId != user.azureId || response.data[0].confidence < 0.7) {
                        res.status(401).send(`Facial recognition failed`)
                        return
                    }

                    web3.eth.getBalance(user.ethAccount.address).then((ethBalance) => {
                        if (amount <= Number(ethBalance)) {
                            //Configuring transactionObject to send to rinkeby test chain
                            var transactionObject = { to: counter.ethAccount.address, value: amount, gas: 100000 }
                            web3.eth.accounts.signTransaction(transactionObject, user.ethAccount.privateKey).then((signedContract) => {
                                web3.eth.sendSignedTransaction(signedContract.rawTransaction).on('receipt', receipt => {
                                    //upon retrival of receipt, log transaction and update balance for users involved.
                                    var today = new Date();

                                    var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();

                                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                                    var dateTime = date + ' ' + time;

                                    var transaction = Transaction({ uid: receipt.transactionHash, incoming: false, counterparty: counter.username, date: dateTime.toString(), amount: amount })

                                    user.transactions.unshift(transaction);

                                    transaction.incoming = true;
                                    transaction.counterparty = user.username;

                                    counter.transactions.unshift(transaction);
                                    transaction.incoming = null;
                                    transaction.user = user.username;
                                    transaction.counterparty = counter.username;
                                    transaction.save()
                                        .catch(err => {
                                            res.send(err);
                                        })

                                    web3.eth.getBalance(user.ethAccount.address).then(balance => {
                                        user.balance = balance;
                                        user.save(function (err) {
                                            if (err) {
                                                res.send(err);
                                                return;
                                            };
                                        });
                                    });
                                    web3.eth.getBalance(counter.ethAccount.address).then(balance => {
                                        counter.balance = balance;
                                        counter.save(function (err) {
                                            if (err) {
                                                res.send(err);
                                                return;
                                            };
                                        });
                                    });
                                    res.send(receipt);
                                })

                            })


                        } else {
                            res.send('Too little money')
                        }
                    }).catch((err) => {
                        res.send(err);
                        return;
                    })
                }).catch(function (error) {
                    console.log(error)
                })


            }).catch(function (error) {
                console.log(error)
            })
        }).catch((err) => {
            res.status(500).send('Error fetching details:' + err)
        })
    }).catch((err) => {
        res.status(500).send('Error fetching details:' + err)
    })

})
module.exports = router
