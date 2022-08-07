import 'package:flutter/material.dart';

FloatingActionButton floatingGenerateButton(BuildContext context, Size mediaQuery, Function()? onPressed) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      isExtended: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      label: const Text("Generate Label"),
      icon: const Icon(Icons.save),
      backgroundColor: Colors.red.shade400,
    );
  }