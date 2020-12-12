import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_section1/widgets/chart_bar.dart';
import '../models/transaction.dart';
class Chart extends StatelessWidget {
  
  final List<Transaction> recenttransactions ;
  Chart(this.recenttransactions);

  List<Map<String,Object>> get groupedTransaction{
    return List.generate(7, (index) {
      final weekday=DateTime.now().subtract(Duration(days: index));
      var totalSum=0.0;

      for (int i=0;i<recenttransactions.length;i++){
        if(recenttransactions[i].date.day==weekday.day &&
        recenttransactions[i].date.month==weekday.month &&
        recenttransactions[i].date.year==weekday.year
        ){
          totalSum+=recenttransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekday));
      // print(totalSum);
      return {
        'date':DateFormat.E().format(weekday),
        'amount':totalSum
      };
    }).reversed.toList();

  }

  double get _totalSpending{
    return groupedTransaction.fold(0.0, (sum, item) {
        return sum+item["amount"];
    });
  }
  
  @override
  Widget build(BuildContext context) {
   
   print(groupedTransaction);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(10),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransaction.map((data) {

          return Flexible(
            fit: FlexFit.tight,
                    child: ChartBar(data["date"], 
            data["amount"], 
         _totalSpending==0 ? 0.0 : (data["amount"] as double)/_totalSpending ),
          );
        }).toList(),),
      ),
    );
  }
}