import 'package:flutter/material.dart';
import 'SendMoney.dart';
import 'HomeScreen.dart';
import 'TransactionDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Widget createTransactionBlocks(String response, BuildContext context) {
var createdBlocks = <Widget>[];
createdBlocks.add(Container());

  var jsonData = jsonDecode(response);
  var transactions = jsonData['transactions'] as List;
  for (var transaction in transactions) {
    var incoming = transaction['incoming'] as bool;
    var counterparty = transaction['counterparty'];
    var date = transaction['date'];
    var amount = transaction['amount'] as int;

var block = GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TransactionDetails(sending: incoming, counterparty: counterparty, dateTime: date, amount: amount,)),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: Row(children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(children: [
                      Icon(incoming ? Icons.arrow_back : Icons.send_rounded, color: Colors.blue,),
                      Padding(padding: EdgeInsets.only(left: 10), child: Text(counterparty, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),)
                    ],),
                    Padding(padding: EdgeInsets.only(top: 10), child: Text(date),),
                    Padding(padding: EdgeInsets.only(top: 10), child: Text("No Note Added"),)
                  ],),
                  Spacer(),
                  Text("$amount ETH", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  ],),
                ),
                );

      createdBlocks.add(block);
  }
  return Column(
    children: createdBlocks,
  );
}

class Transactions extends StatelessWidget {

Future<String> getAllTransactions() async {
  var response = await http.get('http://35.222.222.69:8080/userDetails/getTransactions?username=$username&password=$password');
  return response.body;
}


Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoPi'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Launch account pane
              showAccountPopup(context);

            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Launch transaction pane
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendMoney()),
                    );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text("All Transactions", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ],),
                FutureBuilder(
                  future: getAllTransactions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return createTransactionBlocks(snapshot.data, context);
                    } else {
                      return Text('Loading transactions');
                    }
                })
            ],),
          )
        ]
      ),
    );
  }

}