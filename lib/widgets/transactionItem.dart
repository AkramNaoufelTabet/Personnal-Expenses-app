import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTr,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTr;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),

              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
        leading: CircleAvatar(radius: 30,
        child: Padding(
          padding:  EdgeInsets.all(6.0),
          child: FittedBox(child: Text("\$${transaction.amount.toStringAsFixed(2)}")),
        ),
        ),
        title: Text("${transaction.title}",
        style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text("${DateFormat.yMMMEd().format(transaction.date)}"),
        trailing:MediaQuery.of(context).size.width>360 ?  
        FlatButton.icon(onPressed: ()=> deleteTr(transaction.id),
         icon: Icon(Icons.delete),
         textColor:Theme.of(context).errorColor ,
          label: Text("Delete"))
        
         : IconButton(icon:Icon(Icons.delete),color: Theme.of(context).errorColor,
        onPressed: ()=> deleteTr(transaction.id),
        ),
        
),
              ),
    );
  }
}