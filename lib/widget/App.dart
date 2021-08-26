import 'package:flutter/material.dart';
import 'package:flutter_app_calories/widget/Home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calories Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Calories Calculator'),
        debugShowCheckedModeBanner: false
    );
  }
}