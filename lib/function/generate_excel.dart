import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> generateExcel(
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
    // final List<int> file = bytes;
    // int col = 1;
    Style globalStyle = workbook.styles.add("style");
    globalStyle.fontSize = 9;

    // Column 1
    sheet.getRangeByName('A1').columnWidth = 7.71;
    sheet.getRangeByName('B1').columnWidth = .83;
    sheet.getRangeByName('C1').columnWidth = 10.14;
    sheet.getRangeByName('D1').columnWidth = 6.43;
    sheet.getRangeByName('E1').columnWidth = .43;
    sheet.getRangeByName('F1').columnWidth = 4.0;

    sheet.getRangeByName('A1:F2').merge();
    sheet.getRangeByName('D4:F8').merge();

    sheet.getRangeByName('A3').text = 'QTY PACK';
    sheet.getRangeByName('A4').text = 'PART NO';
    sheet.getRangeByName('A5').text = 'DLV DATE';
    sheet.getRangeByName('A6').text = 'LOT NO';
    sheet.getRangeByName('A7').text = 'LOCATION';
    sheet.getRangeByName('A8').text = 'PIC';
    sheet.getRangeByName('D3').text = 'QTY DLV';

    sheet.getRangeByName('B3:B8').text = ':';
    sheet.getRangeByName('E3').text = ':';

    sheet.getRangeByName('C3').text = qtyPack;
    sheet.getRangeByName('C4').text = partNo;
    sheet.getRangeByName('C5').text = dlvDate;
    sheet.getRangeByName('C6').text = lotNo;
    sheet.getRangeByName('C7').text = location;
    sheet.getRangeByName('C8').text = pic;
    sheet.getRangeByName('F4').text = qtyDlv;

    // Use Global Style
    sheet.getRangeByName("A1:F1").cellStyle = globalStyle;
    sheet.getRangeByName("A3:F4").cellStyle.bold = true;

    final List<int> files = workbook.saveAsStream();
    // File("C:/Users/eugen/Documents/Generate Labels/$partNo Labels.xlsx").writeAsfiles(files);
    AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(files)}")..setAttribute("download", "$partNo Labels.xlsx")..click();
    workbook.dispose();
  }