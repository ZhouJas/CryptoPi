import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeScreen.dart';
import 'package:http/http.dart' as http;

class SendMoney extends StatelessWidget {

  sendCash() {
    http.post('');
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
            },
          )
        ],
      ),
      body: Container(
         margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200]
            ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Send Money", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Recipient Ethereum Address',
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(padding: EdgeInsets.only(bottom: 10), child: Text('Recent People'),),
                    Row(

                        children: [
                          Container(margin: EdgeInsets.only(right: 10), child: Text('0x89205A3A3bB2108B2c43e7', style: TextStyle(color: Colors.white),), padding: EdgeInsets.all(10), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),), color: Colors.blue),),
                        ],
                      ),
                  ],)
                )
              ),

              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                 FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Amount (ETH)',
                ),
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Note',
                ),
              ),

               Container(
                  margin: EdgeInsets.all(20),
                  child: MaterialButton(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  child: Row(children: [
                    Spacer(),
                    Text("Send Money"),
                    Spacer()
                  ],),
                  onPressed: () {
                    // Send money to same peprson

                }),),

            ]
          ),
      ),
    );
  }
}