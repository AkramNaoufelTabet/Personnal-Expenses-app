import 'package:flutter/material.dart';
import 'package:project_section1/widgets/chart.dart';
import './models/transaction.dart';
import 'package:intl/intl.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personnal Expenses',
      theme: ThemeData(
       
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "QuickSand",
        textTheme: Theme.of(context).textTheme.copyWith(
          headline6: TextStyle(fontFamily: "QuickSand",fontSize: 18,fontWeight: FontWeight.bold),
          button: TextStyle(color: Colors.white)
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(fontFamily: "OpenSans",fontSize: 20,fontWeight: FontWeight.bold),
          
        ),
        )
        ,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
 class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransctions=[
    // Transaction(id: "t1", title: "New shoes" , amount: 69.90, date: DateTime.now()),
    // Transaction(id: "t2", title: "weekly Groceries" , amount: 16.53, date: DateTime.now())
  
  ];

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
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(_addNewTransaction);
    });
  }

List<Transaction> get _recentTransaction{
  return _userTransctions.where((tr) {
   return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();
}
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Personnal Expenses "),
         actions: [
            IconButton(icon: Icon(Icons.add), onPressed:()=>_startAddNewTransaction(context))
         ],
       ),
       body: SingleChildScrollView(
                child: Column
    
         (crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
           Chart(_recentTransaction),
            TransactionList(_userTransctions,_deleteTransaction)
           
         ],),
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add, color: Colors.white,),
         
         onPressed: ()=>_startAddNewTransaction(context)
         ),
     );
   }
}
