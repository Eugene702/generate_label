import 'package:flutter/material.dart';
import 'package:generate_label/components/home/floating_generate_button.dart';
import 'package:generate_label/components/home/text_field.dart';
import 'components/home/modal_select_design_label.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final partNo = TextEditingController();
  final qtyPack = TextEditingController();
  final qtyDlv = TextEditingController();
  final dlvDate = TextEditingController();
  final lotNo = TextEditingController();
  final supplier = TextEditingController();
  final location = TextEditingController();
  final pic = TextEditingController();
  final numberLabels = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: floatingGenerateButton(
        context, 
        mediaQuery, 
        () => modalSelectDesignLabel(
          context: context,
          mediaQuery: mediaQuery,
          partNo: partNo,
          qtyPack: qtyPack,
          qtyDlv: qtyDlv,
          dlvDate: dlvDate,
          lotNo: lotNo,
          supplier: supplier,
          location: location,
          pic: pic,
          numberLabels: numberLabels,
        )
      ),
      body: Container(
        margin: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      
            const SizedBox(height: 20.0)
          ],
        ),
      ),
    );
  }
}