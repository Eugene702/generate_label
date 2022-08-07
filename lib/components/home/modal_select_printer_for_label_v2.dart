import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:generate_label/function/v2/generate_excel2_v2.dart';
import '../../function/v2/generate_excel2_v1.dart';
import '../dialog_messages.dart';

modalSelectPrinterForLabelV2(
  BuildContext context, 
  Uint8List bytes, 
  TextEditingController partNo, 
  TextEditingController qtyPack, 
  TextEditingController qtyDlv, 
  TextEditingController dlvDate, 
  TextEditingController lotNo, 
  TextEditingController supplier, 
  TextEditingController location, 
  TextEditingController pic, 
  TextEditingController numberLabels
) async {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) => Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Please select the printer version",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async{ 
                  if(int.parse(numberLabels.text) <= 18){
                    await generateExcel2V1(
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                    dialogMessages(context, "Success", "Excel file has been generated");
                  }else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    dialogMessages(context, "Warning", "The number of labels must not exceed 18!");
                  }
                },

                borderRadius: BorderRadius.circular(20.0),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "EPSON L3110",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.0,
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () async {
                  if(int.parse(numberLabels.text) <= 15){
                    await generateExcel2Kyocera(
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
                    Navigator.pop(context);
                    dialogMessages(context, "Success", "Excel file has been generated");
                  }else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                    dialogMessages(context, "Warning", "The number of labels must not exceed 15!");
                  }
                },
                borderRadius: BorderRadius.circular(20.0),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "KYOCERA",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

          MaterialButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pop(context)
            },
            child: const Text("Cancel"),
          )
        ],
      ),
    ),
  );
}