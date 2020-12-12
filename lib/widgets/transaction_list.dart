import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTr;

  TransactionList(this.transactions,this.deleteTr);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560,
      child: transactions.isEmpty ? Column(children: [
        Text("No transaction added yet !",
        style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20,),
        Image.asset("assets/images/waiting.png",height: 200,fit:BoxFit.cover ),

      ],) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx,index){
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),

                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 3),
                    child: ListTile(
            leading: CircleAvatar(radius: 30,
            child: Padding(
              padding:  EdgeInsets.all(6.0),
              child: FittedBox(child: Text("\$${transactions[index].amount.toStringAsFixed(2)}")),
            ),
            ),
            title: Text("${transactions[index].title}",
            style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text("${DateFormat.yMMMEd().format(transactions[index].date)}"),
            trailing: IconButton(icon:Icon(Icons.delete),color: Theme.of(context).errorColor,
            onPressed: ()=> deleteTr(transactions[index].id),
            ),
            
),
                  ),
        );
        },
       ),
    );
  }
}