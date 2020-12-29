import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class TransactionDetails extends StatelessWidget {
  final bool sending;
  final String counterparty;
  final String dateTime;
  final int amount;

  TransactionDetails({this.sending, this.counterparty, this.dateTime, this.amount});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
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
      body: Column(
        children: [
          Container(
                    margin: EdgeInsets.all(10),
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
                      Icon(Icons.send_rounded, color: Colors.blue,),
                      Padding(padding: EdgeInsets.only(left: 10), child: Text(counterparty, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),)
                    ],),
                    Padding(padding: EdgeInsets.only(top: 10), child: Text(dateTime),),
                  ],),
                  Spacer(),
                  Text("$amount ETH", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  ],),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: MaterialButton(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  child: Row(children: [
                    Spacer(),
                    Text("Send more money to $counterparty"),
                    Spacer()
                  ],),
                  onPressed: () {
                    // Send money to same peprson

                }),),

                Container(
                   margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Modify Note'),
                      TextField(),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: MaterialButton(
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        child: Text("Save"),
                        onPressed: () {
                          // Send money to same peprson

                      }),),

                    ],)
                )
        ],
      ),
    );
  }

   
}