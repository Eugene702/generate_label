import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> generateExcel1({
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
})async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  int col = 1;
  int row = 1;

  // // Column 1
  sheet.getRangeByName("A1").columnWidth = 7.71;
  sheet.getRangeByName("B1").columnWidth = .83;
  sheet.getRangeByName("C1").columnWidth = 8.57;
  sheet.getRangeByName("D1").columnWidth = 16.86;

  // Sparate
  sheet.getRangeByName("E1").columnWidth = 16.0;

  // Column 2
  sheet.getRangeByName("F1").columnWidth = 7.71;
  sheet.getRangeByName("G1").columnWidth = .83;
  sheet.getRangeByName("H1").columnWidth = 8.57;
  sheet.getRangeByName("I1").columnWidth = 16.86;


  for(int i = 0; i < numberLabels; i++){
    // Set Style For Column 1
    sheet.getRangeByName("A$col:D${col + 7}").cellStyle.fontSize = 9.0;
    sheet.getRangeByName("A$col:C${col + 2}").cellStyle.bold = true;

    // Set Style For Column 2
    sheet.getRangeByName("F$col:I${col + 7}").cellStyle.fontSize = 9.0;
    sheet.getRangeByName("F$col:H${col + 2}").cellStyle.bold = true;

    if(row == 1){
      // Set Layout
      sheet.getRangeByName("C${col + 6}:D${col + 6}").merge();
      sheet.getRangeByName("D$col:D${col + 5}").merge();

      // Set Key Layout
      sheet.getRangeByName("A$col").value = "PART NO";
      sheet.getRangeByName("A${col + 1}").value = "QTY PACK";
      sheet.getRangeByName("A${col + 2}").value = "QTY DLV";
      sheet.getRangeByName("A${col + 3}").value = "DLV DATE";
      sheet.getRangeByName("A${col + 4}").value = "LOT NO";
      sheet.getRangeByName("A${col + 5}").value = "LOCATION";
      sheet.getRangeByName("A${col + 6}").value = "SUPPLIER";
      sheet.getRangeByName("A${col + 7}").value = "PIC";
      sheet.getRangeByName("B$col:B${col + 7}").value = ":";

      // Set Value Layout
      sheet.getRangeByName("C$col").value = partNo;
      sheet.getRangeByName("C${col + 1}").value = qtyPack;
      sheet.getRangeByName("C${col + 2}").value = qtyDlv;
      sheet.getRangeByName("C${col + 3}").value = dlvDate;
      sheet.getRangeByName("C${col + 4}").value = lotNo;
      sheet.getRangeByName("C${col + 5}").value = location;
      sheet.getRangeByName("C${col + 6}").value = supplier;
      sheet.getRangeByName("C${col + 7}").value = pic;

      // Add Barcode
      final Picture barcode = sheet.pictures.addStream(col, 4, bytes);
      barcode.width = 122;
      barcode.height = 120;

      row++;
    }else{
      // Set Layout
      sheet.getRangeByName("H${col + 6}:I${col + 6}").merge();
      sheet.getRangeByName("I$col:I${col + 5}").merge();

      // Set Key Layout
      sheet.getRangeByName("F$col").value = "PART NO";
      sheet.getRangeByName("F${col + 1}").value = "QTY PACK";
      sheet.getRangeByName("F${col + 2}").value = "QTY DLV";
      sheet.getRangeByName("F${col + 3}").value = "DLV DATE";
      sheet.getRangeByName("F${col + 4}").value = "LOT NO";
      sheet.getRangeByName("F${col + 5}").value = "LOCATION";
      sheet.getRangeByName("F${col + 6}").value = "SUPPLIER";
      sheet.getRangeByName("F${col + 7}").value = "PIC";
      sheet.getRangeByName("G$col:G${col + 7}").value = ":";
      
      // Set Value Layout
      sheet.getRangeByName("H$col").value = partNo;
      sheet.getRangeByName("H${col + 1}").value = qtyPack;
      sheet.getRangeByName("H${col + 2}").value = qtyDlv;
      sheet.getRangeByName("H${col + 3}").value = dlvDate;
      sheet.getRangeByName("H${col + 4}").value = lotNo;
      sheet.getRangeByName("H${col + 5}").value = location;
      sheet.getRangeByName("H${col + 6}").value = supplier;
      sheet.getRangeByName("H${col + 7}").value = pic;
      
      // Add Barcode
      final Picture barcode = sheet.pictures.addStream(col, 9, bytes);
      barcode.width = 122;
      barcode.height = 120;

      row = 1;
      col += 9;
    }
  }

  // Save File
  final List<int> files = workbook.saveAsStream();
  final Directory path = await getApplicationDocumentsDirectory();
  await Directory("${path.path}/Generate Label").create(recursive: true);
  await File("${path.path}/Generate Label/$partNo.xlsx").writeAsBytes(files);
  workbook.dispose();
}