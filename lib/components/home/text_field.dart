import 'package:flutter/material.dart';

TextFormField textFormField({
    required TextEditingController controller,
    required String label,
  }) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: "Enter $label",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );