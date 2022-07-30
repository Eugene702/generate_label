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
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
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
      
              MaterialButton(
                onPressed: () => modalSelectDesignLabel(context),
                padding: const EdgeInsets.all(20.0),
                elevation: 0,
                highlightElevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: Colors.red.shade400,
                child: Text(
                  "Generate Label", 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (mediaQuery.width + mediaQuery.height) / 80,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> modalSelectDesignLabel(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) => Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Please select a label design",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),

            Expanded(
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Image.asset("assets/image/label_v1.png"),
                  Image.asset("assets/image/label_v2.png")
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}