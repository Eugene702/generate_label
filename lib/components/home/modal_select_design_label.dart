import 'package:flutter/material.dart';
import 'button_generate_excel.dart';

Future<dynamic> modalSelectDesignLabel({
  required BuildContext context,
  required Size mediaQuery,
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
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) => Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please a select design label",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),

            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: mediaQuery.width / (mediaQuery.height / 1.2),
                crossAxisSpacing: 10.0,
                children: List.generate(2, (index) => buttonGenerateExcel(
                    context: context,
                    mediaQuery: mediaQuery,
                    versionLabel: "${index + 1}",
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
              ),
            )
          ],
        )
      )
    );
  }