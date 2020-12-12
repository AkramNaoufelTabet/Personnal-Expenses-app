import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transactionItem.dart';
class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTr;

  TransactionList(this.transactions,this.deleteTr);
  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    return Container(
      child: transactions.isEmpty ? LayoutBuilder(builder: (ctx,constraints){
        return Column(children: [
        Text("No transaction added yet !",
        style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20,),
        Image.asset("assets/images/waiting.png",height: isLandscape ? constraints.maxHeight*0.8 : constraints.maxHeight*0.5,fit:BoxFit.cover ),

      ],);

      }) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx,index){
        return TransactionItem(transaction: transactions[index], deleteTr: deleteTr);
        },
       ),
    );
  }
}

