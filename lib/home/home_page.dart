
import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';


class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransctions=[
    // Transaction(id: "t1", title: "New shoes" , amount: 69.90, date: DateTime.now()),
    // Transaction(id: "t2", title: "weekly Groceries" , amount: 16.53, date: DateTime.now())
  
  ];
  bool _selectSwicth=false;
  void _addNewTransaction(String title,double amount,DateTime choosenDate){
    final newT=Transaction(amount: amount,title: title,date: choosenDate,id:DateTime.now().toString() );
    setState(() {
      _userTransctions.add(newT);

    });
  }
  void _deleteTransaction(String id){
      setState(() {
        _userTransctions.removeWhere((tr) =>tr.id==id );
      });
  }
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx, builder: (_){
      return NewTransaction(_addNewTransaction);
    });
  }

List<Transaction> get _recentTransaction{
  return _userTransctions.where((tr) {
   return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();
}
   List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,AppBar appBar ,Widget trListWidget ){
     return [
       Container(
             height: (mediaQuery.size.height
             -appBar.preferredSize.height
             - mediaQuery.padding.top
              )*0.25,
             child: Chart(_recentTransaction)),trListWidget
     ];
   } 
   List<Widget> _buildLandScapeContent(MediaQueryData mediaQuery,AppBar appBar ,Widget trListWidget){
    return  [Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Text("Show chart"),
                Switch.adaptive(activeColor: Theme.of(context).accentColor,
                  
                  value: _selectSwicth, onChanged: (val){
                  
                  setState(() {
                    _selectSwicth=val;
                  });
                })
             ],),
               _selectSwicth ? Container(
             height: (mediaQuery.size.height
             -appBar.preferredSize.height
             - MediaQuery.of(context).padding.top
              )*0.6,
             child: Chart(_recentTransaction))
            : trListWidget
             
             ]; 
   }

   @override
   Widget build(BuildContext context) {
     final mediaQuery=MediaQuery.of(context);
     final isLandscape=mediaQuery.orientation==Orientation.landscape;
    final appBar= AppBar(
         title: Text("Personnal Expenses "),
         actions: [
            IconButton(icon: Icon(Icons.add), onPressed:()=>_startAddNewTransaction(context))
         ],
       );


     final trListWidget=Container(
              height: (mediaQuery.size.height
             -appBar.preferredSize.height
             - mediaQuery.padding.top
              )*0.75,
              child: TransactionList(_userTransctions,_deleteTransaction));  
      final pagebody=Scaffold(
       appBar:appBar,
       body: SingleChildScrollView(
                child: Column
    
         (crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             if(isLandscape)
             ..._buildLandScapeContent(mediaQuery,appBar,trListWidget),
            
            if (!isLandscape)
            ..._buildPortraitContent(mediaQuery, appBar, trListWidget),
          
           

          
           
         ],),
       ),
       
       floatingActionButtonLocation:
       
       Platform.isIOS ? Container() : FloatingActionButtonLocation.centerFloat,


       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add, color: Colors.white,),
         
         onPressed: ()=>_startAddNewTransaction(context)
         ),
     );
     return pagebody;
   }
}
