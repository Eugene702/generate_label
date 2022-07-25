import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../function/generate_excel.dart';
import 'qr_image.dart';

ElevatedButton generateExcelButton({
  required BuildContext context,
  required TextEditingController partNo,
  required TextEditingController qtyPack,
  required TextEditingController qtyDlv,
  required TextEditingController dlvDate,
  required TextEditingController pic,
  required TextEditingController lotNo,
  required TextEditingController supplier,
  required TextEditingController location,
  required TextEditingController numberLabels,
}) {
  return ElevatedButton(
    child: Row(
      children: const [
        Icon(Icons.save_rounded),
        SizedBox(width: 10),
        Text("Generate Labels And Save In Excel Format"),
      ],
    ),
    onPressed: () async {
      if (
        partNo.text.isEmpty ||
        qtyPack.text.isEmpty ||
        qtyDlv.text.isEmpty ||
        dlvDate.text.isEmpty ||
        pic.text.isEmpty ||
        lotNo.text.isEmpty ||
        supplier.text.isEmpty ||
        numberLabels.text.isEmpty ||
        location.text.isEmpty
      ) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Please fill all the fields"),
            actions: [
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context)
              )
            ]
          )
        );
      } else {
        final controller = ScreenshotController();
        final qrText = '${partNo.text},${qtyPack.text},${qtyDlv.text},${dlvDate.text},${lotNo.text},${supplier.text},${pic.text}';
        final bytes = await controller.captureFromWidget(qrImage(qrText));
        generateExcel(
          bytes: bytes,
          partNo: partNo.text,
          qtyPack: qtyPack.text,
          qtyDlv: qtyDlv.text,
          dlvDate: dlvDate.text,
          pic: pic.text,
          lotNo: lotNo.text,
          supplier: supplier.text,
          location: location.text,
          numberLabels: int.parse(numberLabels.text),
        );
      }
    },
  );
}