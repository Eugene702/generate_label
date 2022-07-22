import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'function/generate_excel.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final part_no = TextEditingController();
    final qty_pack = TextEditingController();
    final qty_dlv = TextEditingController();
    final dlv_date = TextEditingController();
    final pic = TextEditingController();
    final lot_no = TextEditingController();
    final location = TextEditingController();
    final supplier = TextEditingController();
    final number_labels = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Labels And Save In Excel Format"),
        icon: const Icon(Icons.save_rounded),
        backgroundColor: Colors.red.shade400,
        onPressed: () async{
          if(part_no.text.isEmpty || qty_pack.text.isEmpty || qty_dlv.text.isEmpty || dlv_date.text.isEmpty || pic.text.isEmpty || lot_no.text.isEmpty || supplier.text.isEmpty || number_labels.text.isEmpty || location.text.isEmpty){
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
          }else{
            final controller = ScreenshotController();
            final bytes = await controller.captureFromWidget(qrImage('${part_no.text},${qty_pack.text},${qty_dlv.text},${dlv_date.text},${lot_no.text},${supplier.text},${pic.text}'));
            generateExcel(bytes, part_no.text, qty_pack.text, qty_dlv.text, dlv_date.text, lot_no.text, location.text, supplier.text, pic.text, int.parse(number_labels.text));
          }
        }
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: textField(controller: part_no, labelText: "PART NO", hintText: "Input Part No")),
                const SizedBox(width: 10.0),
                Expanded(child: textField(controller: qty_pack, labelText: "QTY PACK", hintText: "Input Qty Pack", keyboardType: TextInputType.number)),
                const SizedBox(width: 10.0),
                Expanded(child: textField(controller: qty_dlv, labelText: "QTY DLV", hintText: "Input Qty Dlv", keyboardType: TextInputType.number)),
              ]
            ),

            const SizedBox(height: 30.0),

            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: textField(controller: dlv_date, labelText: "DLV DATE", hintText: "Input Dlv Date", keyboardType: TextInputType.datetime)),
                const SizedBox(width: 10.0),
                Expanded(child: textField(controller: lot_no, labelText: "LOT NO", hintText: "Input Lot No", keyboardType: TextInputType.number)),
              ]
            ),

            const SizedBox(height: 30.0),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 1, child: textField(labelText: "LOCATION", hintText: "Input Location", controller: location),),
                const SizedBox(width: 10.0),
                Flexible(flex: 2, child: textField(controller: supplier, labelText: "SUPPLIER", hintText: "Input Supplier"))
              ]
            ),
            const SizedBox(height: 30.0),

            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(child: textField(hintText: "Input Pic", labelText: "PIC", controller: pic)),
                const SizedBox(width: 10.0),
                Flexible(child: textField(controller: number_labels, labelText: "NUMBER OF LABELS", hintText: "Input Number Labels", keyboardType: TextInputType.number),)
              ],
            )
          ]
        ),
      )
    );
  }

  TextFormField textField({
    TextEditingController? controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }

  QrImage qrImage(String text) {
    return QrImage(
      data: text,
      version: QrVersions.auto,
      size: 94.488188976,
    );
  }
}