import 'dart:io';

import 'package:crypto_pi/AuthScreen.dart';
import 'package:crypto_pi/SendMoney.dart';
import 'package:crypto_pi/TransactionDetails.dart';
import 'package:crypto_pi/Transactions.dart';
import 'package:crypto_pi/Trends.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



var username = "receiver";
var password = "password";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {

  

  Future<int> getBalance() async {
    // Need to configure headers too
      var data = await http.get('http://35.222.222.69:8080/userDetails/balance?username=$username&password=$password');
      print(data.body);
      var jsonData = jsonDecode(data.body);

      print(jsonData);



      var num = jsonData['balance'] as int;
      return num;
  }

  Future<String> getTransactions() async {
    var data = await http.get('http://35.222.222.69:8080/userDetails/getTransactions?username=$username&password=$password');
    print(data.body);
    return data.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoPi'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Launch account pane
          //    showAccountPopup(context);

             Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage(login: false,)),
                    );

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
              color: Colors.blue
            ),
            child: Row(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Hello there Yash!", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                  Container(child: Text("Thursday, October 8", style: TextStyle(color: Colors.white, fontSize: 18),), padding: EdgeInsets.only(top: 10),),
                  Container(child: Text("What would you like to do today?", style: TextStyle(color: Colors.white, fontSize: 18),), padding: EdgeInsets.only(top: 10),)
                ],),
                Spacer(),
                
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue
            ),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  FutureBuilder(
                    future: getBalance(),
                    
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                         return Text("${snapshot.data} ETH", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),);
                      } else {
                        return Text('Balance Loading');
                      }
                    }
                  ),
                  Container(child: Text("Your Account Balance", style: TextStyle(color: Colors.white, fontSize: 18),), padding: EdgeInsets.only(top: 10),),
                  GestureDetector(
                    child: Container(child: Text("View Trends", style: TextStyle(color: Colors.white, fontSize: 18),), padding: EdgeInsets.only(top: 10),),
                    onTap: () {
                      // Go to trends page
                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Trends()),
                    );
                    },
                  )
                ],),),

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
                  Text("Recent Transactions", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Spacer(),
                  
                ],),
                GestureDetector(
                    child: Text("View all transactions", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Transactions()));
                    },
                  ),
                FutureBuilder(
                  future: getTransactions(),
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


showAccountPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Log Out"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirm Logout"),
              onPressed: () {
                // Log out
              },
            ),
          ],
        );
      },
    );
  }
