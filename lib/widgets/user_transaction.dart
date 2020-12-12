import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

import './new_transaction.dart';
import './transaction_list.dart';
class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
   final List<Transaction> _userTransctions=[
    Transaction(id: "t1", title: "New shoes" , amount: 69.90, date: DateTime.now()),
    Transaction(id: "t2", title: "weekly Groceries" , amount: 16.53, date: DateTime.now())
  
  ];

  void _addNewTransaction(String title,double amount){
    final newT=Transaction(amount: amount,title: title,date: DateTime.now(),id:DateTime.now().toString() );
    setState(() {
      _userTransctions.add(newT);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              // NewTransaction(_addNewTransaction), 
              // TransactionList(_userTransctions),
            ],
    );
  }
}