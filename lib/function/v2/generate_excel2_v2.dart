import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<List<int>> _readImageData(String name) async{
  final ByteData data = await rootBundle.load('assets/image/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<void> generateExcel2Kyocera(
  {
    required List<int> bytes,
    required String partNo,
    required String qtyPack,
    required String qtyDlv,
    required String dlvDate,
    required String lotNo,
    required String location,
    required String supplier,
    required String pic,
    required int numberLabels,
  }
) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  final String logo = base64.encode(await _readImageData('label_logo.png'));

  // Index of the row to start the printing.
  int col = 1;
  int row = 3;

  // Margin
  sheet.getRangeByName("A1").columnWidth = 0.1;
  sheet.getRangeByName("A1:V2").rowHeight = 0.1;
  sheet.getRangeByName("B1").columnWidth = 2.43;
  sheet.getRangeByName("I1").columnWidth = 1.43;
  sheet.getRangeByName("P1").columnWidth = .75;
  sheet.getRangeByName("B3:V3").rowHeight = 8.25;
  sheet.getRangeByName("B11:V11").rowHeight = 23.25;
  sheet.getRangeByName("B19:V19").rowHeight = 24.75;
  sheet.getRangeByName("B27:V27").rowHeight = 18.75;
  sheet.getRangeByName("B35:V35").rowHeight = 21.00;

  // Global Font Settings
  sheet.getRangeByName("C1:V42").cellStyle.fontSize = 8;

  // Layout Label
  // Column 1
  sheet.getRangeByName("C1").columnWidth = 6.86;
  sheet.getRangeByName("D1").columnWidth = .75;
  sheet.getRangeByName("E1").columnWidth = 7.86;
  sheet.getRangeByName("F1").columnWidth = 3.29;
  sheet.getRangeByName("G1").columnWidth = .83;
  sheet.getRangeByName("H1").columnWidth = 8.00;

  // Column 2
  sheet.getRangeByName("J1").columnWidth = 6.86;
  sheet.getRangeByName("K1").columnWidth = .75;
  sheet.getRangeByName("L1").columnWidth = 7.86;
  sheet.getRangeByName("M1").columnWidth = 3.29;
  sheet.getRangeByName("N1").columnWidth = .83;
  sheet.getRangeByName("O1").columnWidth = 8.00;

  // Column 3
  sheet.getRangeByName("Q1").columnWidth = 6.86;
  sheet.getRangeByName("R1").columnWidth = .75;
  sheet.getRangeByName("S1").columnWidth = 7.86;
  sheet.getRangeByName("T1").columnWidth = 3.29;
  sheet.getRangeByName("U1").columnWidth = .83;
  sheet.getRangeByName("V1").columnWidth = 8.00;

  // Generate Label
  for(int i = 0; i < numberLabels; i++){
    switch(col) {
      case 1 :
        // :
        sheet.getRangeByName("D${row + 2}:D${row + 7}").text = ":";
        sheet.getRangeByName("G${row + 7}").text = ":";

        // Cell Style For Value Qty Pack And Qty Dlv
        final cellStyleForQtyDlvAndQtyPack = sheet.getRangeByName("E${row + 3}:E${row + 4}");
        cellStyleForQtyDlvAndQtyPack.cellStyle.fontSize = 11;

        // Merge Cell For Logo Image
        final cellLogo = sheet.getRangeByName("C${row + 1}:H${row + 1}");
        cellLogo.merge();
        cellLogo.rowHeight = 27.00;

        // Merge Cell For Barcode Image
        sheet.getRangeByName("F${row + 3}:H${row + 6}").merge();

        // Cell Bold
        final cellBold = sheet.getRangeByName("C${row + 2}:H${row + 4}");
        cellBold.cellStyle.bold = true;

        // Cell For Part No
        sheet.getRangeByName("C${row + 2}").value = "PART NO";
        final cellValuePartNo = sheet.getRangeByName("E${row + 2}:H${row + 2}");
        cellValuePartNo.merge();
        cellValuePartNo.cellStyle.fontSize = 14;
        cellValuePartNo.text = partNo;

        // Cell For Qty Pack
        sheet.getRangeByName("C${row + 3}").value = "QTY PACK";
        sheet.getRangeByName("E${row + 3}").text = qtyPack;

        // Cell For Qty Dlv
        final cellKeyQtyDlv = sheet.getRangeByName("C${row + 4}");
        cellKeyQtyDlv.cellStyle.bold = false;
        cellKeyQtyDlv.value = "QTY DLV";

        final cellValueQtyDlv = sheet.getRangeByName("E${row + 4}");
        cellValueQtyDlv.numberFormat = "0.0";
        cellValueQtyDlv.text = qtyDlv;

        // Cell For Dlv Date
        sheet.getRangeByName("C${row + 5}").value = "DLV DATE";
        sheet.getRangeByName("E${row + 5}").text = dlvDate;

        // Cell For Lot No
        sheet.getRangeByName("C${row + 6}").value = "LOT NO";
        sheet.getRangeByName("E${row + 6}").text = lotNo;

        // Cell For Location
        sheet.getRangeByName("C${row + 7}").value = "LOCATION";
        sheet.getRangeByName("E${row + 7}").text = location;

        // Cell For PIC
        final cellKeyPIC = sheet.getRangeByName("F${row + 7}");
        cellKeyPIC.cellStyle.bold = true;
        cellKeyPIC.cellStyle.hAlign = HAlignType.right;
        cellKeyPIC.value = "PIC";
        sheet.getRangeByName("H${row + 7}").text = pic;

        // Set Image To Cell
        final Picture logoImage = sheet.pictures.addBase64(row + 1, 3, logo);
        logoImage.height = 35;
        logoImage.width = 221;

        final Picture barcodeImage = sheet.pictures.addStream(row + 3, 6, bytes);
        barcodeImage.height = 89;
        barcodeImage.width = 105;

        col++;
        break;

      case 2 :
        // :
        sheet.getRangeByName("K${row + 2}:K${row + 7}").text = ":";
        sheet.getRangeByName("N${row + 7}").text = ":";

        // Cell Style For Value Qty Pack And Qty Dlv
        final cellStyleForQtyDlvAndQtyPack = sheet.getRangeByName("L${row + 3}:L${row + 4}");
        cellStyleForQtyDlvAndQtyPack.cellStyle.fontSize = 11;

        // Merge Cell For Logo Image
        final cellLogo = sheet.getRangeByName("J${row + 1}:O${row + 1}");
        cellLogo.merge();
        cellLogo.rowHeight = 27.00;

        // Merge Cell For Barcode Image
        sheet.getRangeByName("M${row + 3}:O${row + 6}").merge();

        // Cell Bold
        final cellBold = sheet.getRangeByName("J${row + 2}:O${row + 4}");
        cellBold.cellStyle.bold = true;

        // Cell For Part No
        sheet.getRangeByName("J${row + 2}").value = "PART NO";
        final cellValuePartNo = sheet.getRangeByName("L${row + 2}:O${row + 2}");
        cellValuePartNo.merge();
        cellValuePartNo.cellStyle.fontSize = 14;
        cellValuePartNo.text = partNo;

        // Cell For Qty Pack
        sheet.getRangeByName("J${row + 3}").value = "QTY PACK";
        sheet.getRangeByName("L${row + 3}").text = qtyPack;

        // Cell For Qty Dlv
        final cellKeyQtyDlv = sheet.getRangeByName("J${row + 4}");
        cellKeyQtyDlv.cellStyle.bold = false;
        cellKeyQtyDlv.value = "QTY DLV";

        final cellValueQtyDlv = sheet.getRangeByName("L${row + 4}");
        cellValueQtyDlv.numberFormat = "0.0";
        cellValueQtyDlv.text = qtyDlv;

        // Cell For Dlv Date
        sheet.getRangeByName("J${row + 5}").value = "DLV DATE";
        sheet.getRangeByName("L${row + 5}").text = dlvDate;

        // Cell For Lot No
        sheet.getRangeByName("J${row + 6}").value = "LOT NO";
        sheet.getRangeByName("L${row + 6}").text = lotNo;

        // Cell For Location
        sheet.getRangeByName("J${row + 7}").value = "LOCATION";
        sheet.getRangeByName("L${row + 7}").text = location;

        // Cell For PIC
        final cellKeyPIC = sheet.getRangeByName("M${row + 7}");
        cellKeyPIC.cellStyle.bold = true;
        cellKeyPIC.cellStyle.hAlign = HAlignType.right;
        cellKeyPIC.value = "PIC";
        sheet.getRangeByName("O${row + 7}").text = pic;

        // Set Image To Cell
        final Picture logoImage = sheet.pictures.addBase64(row + 1, 10, logo);
        logoImage.height = 35;
        logoImage.width = 221;

        final Picture barcodeImage = sheet.pictures.addStream(row + 3, 13, bytes);
        barcodeImage.height = 89;
        barcodeImage.width = 105;

        col++;
        break;

      case 3 :
        // :
        sheet.getRangeByName("R${row + 2}:R${row + 7}").text = ":";
        sheet.getRangeByName("U${row + 7}").text = ":";

        // Cell Style For Value Qty Pack And Qty Dlv
        final cellStyleForQtyDlvAndQtyPack = sheet.getRangeByName("S${row + 3}:S${row + 4}");
        cellStyleForQtyDlvAndQtyPack.cellStyle.fontSize = 11;

        // Merge Cell For Logo Image
        final cellLogo = sheet.getRangeByName("Q${row + 1}:V${row + 1}");
        cellLogo.merge();
        cellLogo.rowHeight = 27.00;

        // Merge Cell For Barcode Image
        sheet.getRangeByName("T${row + 3}:V${row + 6}").merge();

        // Cell Bold
        final cellBold = sheet.getRangeByName("Q${row + 2}:V${row + 4}");
        cellBold.cellStyle.bold = true;

        // Cell For Part No
        sheet.getRangeByName("Q${row + 2}").value = "PART NO";
        final cellValuePartNo = sheet.getRangeByName("S${row + 2}:V${row + 2}");
        cellValuePartNo.merge();
        cellValuePartNo.cellStyle.fontSize = 14;
        cellValuePartNo.text = partNo;

        // Cell For Qty Pack
        sheet.getRangeByName("Q${row + 3}").value = "QTY PACK";
        sheet.getRangeByName("S${row + 3}").text = qtyPack;

        // Cell For Qty Dlv
        final cellKeyQtyDlv = sheet.getRangeByName("Q${row + 4}");
        cellKeyQtyDlv.cellStyle.bold = false;
        cellKeyQtyDlv.value = "QTY DLV";

        final cellValueQtyDlv = sheet.getRangeByName("S${row + 4}");
        cellValueQtyDlv.numberFormat = "0.0";
        cellValueQtyDlv.text = qtyDlv;

        // Cell For Dlv Date
        sheet.getRangeByName("Q${row + 5}").value = "DLV DATE";
        sheet.getRangeByName("S${row + 5}").text = dlvDate;

        // Cell For Lot No
        sheet.getRangeByName("Q${row + 6}").value = "LOT NO";
        sheet.getRangeByName("S${row + 6}").text = lotNo;

        // Cell For Location
        sheet.getRangeByName("Q${row + 7}").value = "LOCATION";
        sheet.getRangeByName("S${row + 7}").text = location;

        // Cell For PIC
        final cellKeyPIC = sheet.getRangeByName("T${row + 7}");
        cellKeyPIC.cellStyle.bold = true;
        cellKeyPIC.cellStyle.hAlign = HAlignType.right;
        cellKeyPIC.value = "PIC";
        sheet.getRangeByName("V${row + 7}").text = pic;

        // Set Image To Cell
        final Picture logoImage = sheet.pictures.addBase64(row + 1, 17, logo);
        logoImage.height = 35;
        logoImage.width = 221;

        final Picture barcodeImage = sheet.pictures.addStream(row + 3, 20, bytes);
        barcodeImage.height = 89;
        barcodeImage.width = 105;

        row += 8;
        col = 1;
        break;
    }
  }

  // Save File
  final List<int> files = workbook.saveAsStream();
  final Directory path = await getApplicationDocumentsDirectory();
  await Directory("${path.path}/Generate Label").create(recursive: true);
  await File("${path.path}/Generate Label/$partNo.xlsx").writeAsBytes(files);
  workbook.dispose();
}