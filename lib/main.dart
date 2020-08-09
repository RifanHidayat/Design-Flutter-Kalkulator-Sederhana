import 'package:calculator/ui/Kalkulator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: "Kalkulator",
     debugShowCheckedModeBanner: false,
     home: Kalkulator(),
   );
  }

}


