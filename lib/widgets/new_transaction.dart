import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addT;

  NewTransaction(this.addT);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();

  final _amountController=TextEditingController();
  DateTime _seledtedDate;
 void _submitData(){ 
   final enteredTitle=_titleController.text;
   final enteredAmount=double.parse(_amountController.text) ;
   
   if(enteredTitle.isEmpty || enteredAmount<=0 || _seledtedDate==null){
     return;
   }
   widget.addT(enteredTitle,enteredAmount,_seledtedDate);
   Navigator.of(context).pop();
 }

 void _chooseDate(){
   showDatePicker(context:context,
    initialDate: DateTime.now(), 
    firstDate: DateTime(2020),
     lastDate: DateTime.now()).then((pickedDate){
       if(pickedDate==null){
         return;
       }
       setState(() {
         _seledtedDate=pickedDate;
       });
     } );
 }

  @override
  Widget build(BuildContext context) {
    return Card(
           elevation: 5,
           child: Container(
             padding: EdgeInsets.all(10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
              TextField(
                onSubmitted: (_)=>_submitData(),
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title")),
                
              TextField(
                controller: _amountController,
                onSubmitted: (_)=>_submitData(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount")),

                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(child: Text( _seledtedDate==null ? "No date choosen!" : "Picked date : ${DateFormat.yMd().format(_seledtedDate)}")),
                      FlatButton( textColor: Theme.of(context).primaryColor,onPressed: _chooseDate,
                      child: Text("Choose date",style: TextStyle(fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              RaisedButton(onPressed:_submitData
              , child: Text("Add a transiction",style: TextStyle(fontWeight: FontWeight.bold),),color: Theme.of(context).primaryColor,
              
              textColor: Theme.of(context).textTheme.button.color,
              
              )
         ],),
           ),);
  }
}