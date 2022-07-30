import 'package:flutter/material.dart';
import 'package:generate_label/home.dart';
import 'package:generate_label/login.dart';
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Generate Label",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.red.shade200,
          primary: Colors.red.shade400
        )
      ),
      home: Home()
    );
  }
}