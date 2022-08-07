import 'package:flutter/material.dart';
import 'package:generate_label/components/home/modal_select_printer_for_label_v2.dart';
import 'package:screenshot/screenshot.dart';
import '../../function/generate_excel1.dart';
import '../dialog_messages.dart';
import '../dialog_waiting.dart';
import 'qr_image.dart';

InkWell buttonGenerateExcel({
  required BuildContext context,
  required Size mediaQuery,
  required String versionLabel,
  required TextEditingController partNo,
  required TextEditingController qtyPack,
  required TextEditingController qtyDlv,
  required TextEditingController dlvDate,
  required TextEditingController lotNo,
  required TextEditingController supplier,
  required TextEditingController location,
  required TextEditingController pic,
  required TextEditingController numberLabels,
}) {
    return InkWell(
      onTap: () async {
        dialogWating(context);
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
          Navigator.pop(context);
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
          
          switch(versionLabel) {
            case "1":
              await generateExcel1(
                bytes: bytes,
                partNo: partNo.text,
                qtyPack: qtyPack.text,
                qtyDlv: qtyDlv.text,
                dlvDate: dlvDate.text,
                lotNo: lotNo.text,
                supplier: supplier.text,
                location: location.text,
                pic: pic.text,
                numberLabels: int.parse(numberLabels.text),
              );

              Navigator.pop(context);
              dialogMessages(context, "Success", "Excel file has been generated");
              break;
            case "2":
              await modalSelectPrinterForLabelV2(context, bytes, partNo, qtyPack, qtyDlv, dlvDate, lotNo, supplier, location, pic, numberLabels);
              break;
          }
        }
      },
      child: Image.asset("assets/image/label_v$versionLabel.png"),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

