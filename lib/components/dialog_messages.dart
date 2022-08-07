import 'package:flutter/material.dart';

Future<dynamic> dialogMessages(BuildContext context, String title, String message) async {
  return showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
      content: Text(message),
    )
  );
}