import 'package:flutter/material.dart';

Future<dynamic> dialogWating(BuildContext context) async{
  return showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          Text("Please Wait..."),
        ],
      ),
    )
  );
}