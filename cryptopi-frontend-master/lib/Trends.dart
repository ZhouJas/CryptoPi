import 'package:flutter/material.dart';
import 'SendMoney.dart';
import 'HomeScreen.dart';
import 'dart:convert';

class TransactionEntry {
  final String date;
  final int amount;
  final String counterparty;

  TransactionEntry(this.date, this.amount, this.counterparty);
}

class Trends extends StatelessWidget {

 

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
      body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(6, (index) {
            return Container(
              margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
              child: Center(
              child: Text(
                'Account Balance Over Time',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            );
          }),
        ),
    );
  }

}



// calculateTransactionsPerDay(String response) {
//     var jsonData = jsonDecode(response);
//     var transactions = jsonData['transactions'] as List;
//     var days = new Map();
//     for (var transaction in transactions) {
//       var date = transaction['date'].toString().substring(0,11);
//       if (days.containsKey(date)) {
//         days[date] += 1;
//       } else {
//         days[date] = 1;
//       }
//     }
//     return days;
//   }

//   calculateFrequentSenders(String response) {
//     var jsonData = jsonDecode(response);
//     var transactions = jsonData['transactions'] as List;
//     var people = new Map();
//     for (var transaction in transactions) {
//       var counterparty = transaction['counterparty'];
//       if (counterparty.containsKey(counterparty)) {
//         people[counterparty] += 1;
//       } else {
//         people[counterparty] = 1;
//       }
//     }
//     return people;
//   }