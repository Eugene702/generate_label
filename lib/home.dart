import 'package:flutter/material.dart';
import 'package:generate_label/components/home/button_generate_excel.dart';
import 'package:generate_label/components/home/text_field.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partNo = TextEditingController();
    final qtyPack = TextEditingController();
    final qtyDlv = TextEditingController();
    final dlvDate = TextEditingController();
    final lotNo = TextEditingController();
    final supplier = TextEditingController();
    final location = TextEditingController();
    final pic = TextEditingController();
    final numberLabels = TextEditingController();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 1, child: textFormField(controller: partNo, label: "Part No")),
                const SizedBox(width: 10.0),
                Flexible(flex: 1, child: textFormField(controller: qtyPack, label: "Qty Pack")),
              ],
            ),
            const SizedBox(height: 20.0),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 1, child: textFormField(controller: qtyDlv, label: "QTY Dlv")),
                const SizedBox(width: 10.0),
                Flexible(flex: 1, child: textFormField(controller: dlvDate, label: "Dlv Date")),
              ],
            ),
            const SizedBox(height: 20.0),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 1, child: textFormField(controller: lotNo, label: "Lot No")),
                const SizedBox(width: 10.0),
                Flexible(flex: 2, child: textFormField(controller: supplier, label: "Supplier")),
              ],
            ),
            const SizedBox(height: 20.0),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 1, child: textFormField(controller: location, label: "Location")),
                const SizedBox(width: 10.0),
                Flexible(flex: 1, child: textFormField(controller: pic, label: "PIC")),
                const SizedBox(width: 10.0),
                Flexible(flex: 1, child: textFormField(controller: numberLabels, label: "Number Labels")),
              ],
            ),

            const SizedBox(height: 20.0),

            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: generateExcelButton(
                    context: context,
                    partNo: partNo,
                    qtyPack: qtyPack,
                    qtyDlv: qtyDlv,
                    dlvDate: dlvDate,
                    pic: pic,
                    lotNo: lotNo,
                    supplier: supplier,
                    location: location,
                    numberLabels: numberLabels,
                  ),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}