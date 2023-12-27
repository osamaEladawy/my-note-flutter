import 'package:flutter/material.dart';
import 'package:my_noty/routes/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xff1B1464),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home:const Home(),
    );
  }
}
