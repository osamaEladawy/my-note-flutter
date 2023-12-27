import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static Color bkColor = const Color(0xffe2e2fe);
  static Color mainColor = const Color(0xff000633);
  static Color accentColor = const Color(0xff0065ff);


  static List<Color> cardsColor=[
    Colors.white,
    Colors.red.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
    Colors.purple.shade100,
    Colors.amber.shade200,
    Colors.grey.shade300,
    Colors.brown.shade200,
    Colors.yellow.shade100,
    Colors.yellow.shade100,
    Colors.cyan.shade200,
    Colors.indigo.shade200,
    Colors.pink.shade100,
    Colors.lime.shade300,
    Colors.teal.shade300,
  ];

  static TextStyle mainTitle = GoogleFonts.roboto(
      fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.red);

  static TextStyle mainContent = GoogleFonts.nunito(
      fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black);

  static TextStyle dataTile = GoogleFonts.roboto(
      fontSize: 15.0,fontWeight: FontWeight.w500);

}