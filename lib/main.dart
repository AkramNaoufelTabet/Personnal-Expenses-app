import 'package:flutter/material.dart';

import 'home/home_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
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
 