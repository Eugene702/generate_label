import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> generateExcel(
  List<int> byets,
  String partNo,
  String qtyPack,
  String qtyDlv,
  String dlvDate,
  String lotNo,
  String location,
  String supplier,
  String pic,
  int numberLabels,
) async{
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final List<int> file = byets;
    int col = 1;

    sheet.getRangeByName('A1').columnWidth = 10.86;
    sheet.getRangeByName('B1').columnWidth = 1.00;
    sheet.getRangeByName('C1').columnWidth = 16.86;
    sheet.getRangeByName('D1').columnWidth = 16.86;

    sheet.getRangeByName('F1').columnWidth = 10.86;
    sheet.getRangeByName('G1').columnWidth = 1.00;
    sheet.getRangeByName('H1').columnWidth = 16.86;
    sheet.getRangeByName('I1').columnWidth = 16.86;

    for(int i = 0; i < numberLabels; i++){
      if( i % 2 == 0){
        sheet.getRangeByName('A$col:C${col + 2}').cellStyle.bold = true;
        sheet.getRangeByName('D$col:D${col + 5}').merge();
        sheet.getRangeByName('C${col + 6}:D${col + 6}').merge();

        sheet.getRangeByName('B$col:B${col + 6}').setText(":");
        sheet.getRangeByName('A$col').setText("PART NO");
        sheet.getRangeByName('A${col + 1}').setText("QTY PACK");
        sheet.getRangeByName('A${col + 2}').setText("QTY DLV");
        sheet.getRangeByName('A${col + 3}').setText("DLV DATE");
        sheet.getRangeByName('A${col + 4}').setText("LOT NO");
        sheet.getRangeByName('A${col + 5}').setText("LOCATION");
        sheet.getRangeByName('A${col + 6}').setText("SUPPLIER");
        sheet.getRangeByName('A${col + 7}').setText("PIC");

        sheet.getRangeByName('C$col').setText(partNo);
        sheet.getRangeByName('C${col + 1}').setText(qtyPack);
        sheet.getRangeByName('C${col + 2}').setText(qtyDlv);
        sheet.getRangeByName('C${col + 3}').setText(dlvDate);
        sheet.getRangeByName('C${col + 4}').setText(lotNo);
        sheet.getRangeByName('C${col + 5}').setText(location);
        sheet.getRangeByName('C${col + 6}').setText(supplier);
        sheet.getRangeByName('C${col + 7}').setText(pic);

        sheet.pictures.addStream(1 + col, 4, file);
      }else{
        sheet.getRangeByName('F$col:H${col + 2}').cellStyle.bold = true;
        sheet.getRangeByName('I$col:I${col + 5}').merge();
        sheet.getRangeByName('H${col + 6}:I${col + 6}').merge();

        sheet.getRangeByName('G$col:G${col + 6}').setText(":");
        sheet.getRangeByName('F$col').setText("PART NO");
        sheet.getRangeByName('F${col + 1}').setText("QTY PACK");
        sheet.getRangeByName('F${col + 2}').setText("QTY DLV");
        sheet.getRangeByName('F${col + 3}').setText("DLV DATE");
        sheet.getRangeByName('F${col + 4}').setText("LOT NO");
        sheet.getRangeByName('F${col + 5}').setText("LOCATION");
        sheet.getRangeByName('F${col + 6}').setText("SUPPLIER");
        sheet.getRangeByName('F${col + 7}').setText("PIC");

        sheet.getRangeByName('H$col').setText(partNo);
        sheet.getRangeByName('H${col + 1}').setText(qtyPack);
        sheet.getRangeByName('H${col + 2}').setText(qtyDlv);
        sheet.getRangeByName('H${col + 3}').setText(dlvDate);
        sheet.getRangeByName('H${col + 4}').setText(lotNo);
        sheet.getRangeByName('H${col + 5}').setText(location);
        sheet.getRangeByName('H${col + 6}').setText(supplier);
        sheet.getRangeByName('H${col + 7}').setText(pic);

        sheet.pictures.addStream(1 + col, 9, file);
        col += 9;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    // File("C:/Users/eugen/Documents/Generate Labels/$partNo Labels.xlsx").writeAsBytes(bytes);
    AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")..setAttribute("download", "$partNo Labels.xlsx")..click();
    workbook.dispose();
  }