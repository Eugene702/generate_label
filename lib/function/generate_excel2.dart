import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<List<int>> _readImageData(String name) async{
  final ByteData data = await rootBundle.load('assets/image/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<void> generateExcel2(
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
) async{
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final String logo = base64.encode(await _readImageData('label_logo.png'));
    // final List<int> file = bytes;
    int col = 1;
    int row = 1;
    int colImage = 1;

    // Separate
    sheet.getRangeByName("G1").columnWidth = 8.71;
    sheet.getRangeByName("N1").columnWidth = 8.71;


    // Column 1
    sheet.getRangeByName('A1').columnWidth = 7.71;
    sheet.getRangeByName('B1').columnWidth = .83;
    sheet.getRangeByName('C1').columnWidth = 10.57;
    sheet.getRangeByName('D1').columnWidth = 6.00;
    sheet.getRangeByName('E1').columnWidth = .83;
    sheet.getRangeByName('F1').columnWidth = 4.0;

    // Column 2
    sheet.getRangeByName('H1').columnWidth = 7.71;
    sheet.getRangeByName('I1').columnWidth = .83;
    sheet.getRangeByName('J1').columnWidth = 10.57;
    sheet.getRangeByName('K1').columnWidth = 6.00;
    sheet.getRangeByName('L1').columnWidth = .83;
    sheet.getRangeByName('M1').columnWidth = 4.0;

    // Column 3
    sheet.getRangeByName('O1').columnWidth = 7.71;
    sheet.getRangeByName('P1').columnWidth = .83;
    sheet.getRangeByName('Q1').columnWidth = 10.57;
    sheet.getRangeByName('R1').columnWidth = 6.00;
    sheet.getRangeByName('S1').columnWidth = .83;
    sheet.getRangeByName('T1').columnWidth = 4.0;



    // Value
    for(int i = 0; i < numberLabels; i++){
      // Use Global Style
      sheet.getRangeByName("A${row + 2}:F${row + 7}").cellStyle.fontSize = 9;
      sheet.getRangeByName("A${row + 2}:F${row + 3}").cellStyle.bold = true;

      sheet.getRangeByName("H${row + 2}:M${row + 7}").cellStyle.fontSize = 9;
      sheet.getRangeByName("H${row + 2}:M${row + 3}").cellStyle.bold = true;

      sheet.getRangeByName("O${row + 2}:T${row + 7}").cellStyle.fontSize = 9;
      sheet.getRangeByName("O${row + 2}:T${row + 3}").cellStyle.bold = true;

      switch(col) {
        case 1:
          sheet.getRangeByName('A$row:F${row + 1}').merge();
          sheet.getRangeByName('D${row + 3}:F${row + 7}').merge();

          sheet.getRangeByName('A${row + 2}').text = 'QTY PACK';
          sheet.getRangeByName('A${row + 3}').text = 'PART NO';
          sheet.getRangeByName('A${row + 4}').text = 'DLV DATE';
          sheet.getRangeByName('A${row + 5}').text = 'LOT NO';
          sheet.getRangeByName('A${row + 6}').text = 'LOCATION';
          sheet.getRangeByName('A${row + 7}').text = 'PIC';
          sheet.getRangeByName('D${row + 2}').text = 'QTY DLV';

          sheet.getRangeByName('B${row + 2}:B${row + 7}').text = ':';
          sheet.getRangeByName('E${row + 2}').text = ':';

          sheet.getRangeByName('C${row + 2}').text = qtyPack;
          sheet.getRangeByName('C${row + 3}').text = partNo;
          sheet.getRangeByName('C${row + 4}').text = dlvDate;
          sheet.getRangeByName('C${row + 5}').text = lotNo;
          sheet.getRangeByName('C${row + 6}').text = location;
          sheet.getRangeByName('C${row + 7}').text = pic;
          sheet.getRangeByName('F${row + 2}').text = qtyDlv;

          final Picture logoImage = sheet.pictures.addBase64(row, colImage, logo);
          logoImage.width = 233;
          logoImage.height = 40;
          sheet.pictures.addStream(row + 3, colImage + 3, bytes);

          col += 1;
          colImage += 7;
          break;
        
        case 2:
          sheet.getRangeByName('H$row:M${row + 1}').merge();
          sheet.getRangeByName('K${row + 3}:M${row + 7}').merge();

          sheet.getRangeByName('H${row + 2}').text = 'QTY PACK';
          sheet.getRangeByName('H${row + 3}').text = 'PART NO';
          sheet.getRangeByName('H${row + 4}').text = 'DLV DATE';
          sheet.getRangeByName('H${row + 5}').text = 'LOT NO';
          sheet.getRangeByName('H${row + 6}').text = 'LOCATION';
          sheet.getRangeByName('H${row + 7}').text = 'PIC';
          sheet.getRangeByName('K${row + 2}').text = 'QTY DLV';
          
          sheet.getRangeByName('I${row + 2}:I${row + 7}').text = ':';
          sheet.getRangeByName('L${row + 2}').text = ':';
          
          sheet.getRangeByName('J${row + 2}').text = qtyPack;
          sheet.getRangeByName('J${row + 3}').text = partNo;
          sheet.getRangeByName('J${row + 4}').text = dlvDate;
          sheet.getRangeByName('J${row + 5}').text = lotNo;
          sheet.getRangeByName('J${row + 6}').text = location;
          sheet.getRangeByName('J${row + 7}').text = pic;
          sheet.getRangeByName('M${row + 2}').text = qtyDlv;

          final Picture logoImage = sheet.pictures.addBase64(row, colImage, logo);
          logoImage.width = 233;
          logoImage.height = 40;
          sheet.pictures.addStream(row + 3, colImage + 3, bytes);

          col += 1;
          colImage += 7;
          break;

        case 3:
          sheet.getRangeByName('O$row:T${row + 1}').merge();
          sheet.getRangeByName('R${row + 3}:T${row + 7}').merge();

          sheet.getRangeByName('O${row + 2}').text = 'QTY PACK';
          sheet.getRangeByName('O${row + 3}').text = 'PART NO';
          sheet.getRangeByName('O${row + 4}').text = 'DLV DATE';
          sheet.getRangeByName('O${row + 5}').text = 'LOT NO';
          sheet.getRangeByName('O${row + 6}').text = 'LOCATION';
          sheet.getRangeByName('O${row + 7}').text = 'PIC';
          sheet.getRangeByName('R${row + 2}').text = 'QTY DLV';
          
          sheet.getRangeByName('P${row + 2}:P${row + 7}').text = ':';
          sheet.getRangeByName('S${row + 2}').text = ':';
          
          sheet.getRangeByName('Q${row + 2}').text = qtyPack;
          sheet.getRangeByName('Q${row + 3}').text = partNo;
          sheet.getRangeByName('Q${row + 4}').text = dlvDate;
          sheet.getRangeByName('Q${row + 5}').text = lotNo;
          sheet.getRangeByName('Q${row + 6}').text = location;
          sheet.getRangeByName('Q${row + 7}').text = pic;
          sheet.getRangeByName('T${row + 2}').text = qtyDlv;

          final Picture logoImage = sheet.pictures.addBase64(row, colImage, logo);
          logoImage.width = 233;
          logoImage.height = 40;
          sheet.pictures.addStream(row + 3, colImage + 3, bytes);

          col += 1;
          colImage += 7;
          break;

        default:
          row += 9;
          col = 1;
          colImage = 1;
          i -= 1;
          break;
      }
    }

    final List<int> files = workbook.saveAsStream();
    // File("C:/Users/eugen/Documents/Generate Labels/$partNo Labels.xlsx").writeAsfiles(files);
    AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(files)}")..setAttribute("download", "$partNo Labels.xlsx")..click();
    workbook.dispose();
  }