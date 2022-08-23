import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

// Variable XLSX
Workbook workbook = Workbook();
Worksheet sheet = workbook.worksheets[0];

// Increment
int col = 1;
int row = 1;

// Load Image Logo
Future<List<int>> _readImageData(String name) async{
  final ByteData data = await rootBundle.load('assets/image/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

// Generate Label
void generateLabel({
  required List<String> rangeName,
  required List<String> data,
  required String logo,
  required List<int> barcode
}){
  // Font Bold
  sheet.getRangeByName("${rangeName[0]}${row + 2}:${rangeName[5]}${row + 4}").cellStyle.bold = true;

  // Sparate
  sheet.getRangeByName("${rangeName[1]}${row + 2}:${rangeName[1]}${row + 7}").text = ":";
  sheet.getRangeByName("${rangeName[4]}${row + 7}").text = ":";

  // Merge Cell And Add For Logo Image
  sheet.getRangeByName("${rangeName[0]}$row:${rangeName[5]}${row + 1}").merge();
  final Picture cellLogo = sheet.pictures.addBase64(row, col == 1 ? 1 : col == 2 ? 8 : 15, logo);
  cellLogo.width = 195;
  cellLogo.height = 35;
  
  // Cell for Part No
  sheet.getRangeByName("${rangeName[0]}${row + 2}").text = "Part No";
  final cellValuePartNo = sheet.getRangeByName("${rangeName[2]}${row + 2}");
  cellValuePartNo.cellStyle.fontSize = 14;
  cellValuePartNo.text = data[0];

  // Cell Style For Value Qty Pack and Qty Dlv
  sheet.getRangeByName("${rangeName[2]}${row + 3}:${rangeName[2]}${row + 4}").cellStyle.fontSize = 11;

  // Cell For Qty Pack
  sheet.getRangeByName("${rangeName[0]}${row + 3}").text = "Qty Pack";
  sheet.getRangeByName("${rangeName[2]}${row + 3}").text = data[1];

  // Cell For Qty Dlv
  sheet.getRangeByName("${rangeName[0]}${row + 4}").text = "Qty Dlv";
  sheet.getRangeByName("${rangeName[2]}${row + 4}").text = data[2];

  // Cell For Dlv Date
  sheet.getRangeByName("${rangeName[0]}${row + 5}").text = "Dlv Date";
  sheet.getRangeByName("${rangeName[2]}${row + 5}").text = data[3];

  // Cell For Lot No
  sheet.getRangeByName("${rangeName[0]}${row + 6}").text = "Lot No";
  sheet.getRangeByName("${rangeName[2]}${row + 6}").text = data[4];

  // Cell For Location
  sheet.getRangeByName("${rangeName[0]}${row + 7}").text = "Location";
  sheet.getRangeByName("${rangeName[2]}${row + 7}").text = data[5];

  // Cell For PIC
  final cellKeyPIC = sheet.getRangeByName("${rangeName[3]}${row + 7}");
  cellKeyPIC.cellStyle.bold = true;
  cellKeyPIC.text = "PIC";
  sheet.getRangeByName("${rangeName[5]}${row + 7}").text = data[6];

  // Cell For Barcode
  sheet.getRangeByName("${rangeName[3]}${row + 3}:${rangeName[5]}${row + 6}").merge();
  final Picture qr = sheet.pictures.addStream(row + 3, col == 1 ? 4 : col == 2 ? 11 : 18, barcode);
  qr.height = 83;
  qr.width = 86;
}

Future<void> generateExcel2V1(
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
  workbook = Workbook();
  sheet = workbook.worksheets[0];

  col = 1;
  row = 1;
  final String logo = base64.encode(await _readImageData('label_logo.png'));

  // Cell Style
  sheet.getRangeByName("A1:T53").cellStyle.fontSize = 8;

  // Separate
  sheet.getRangeByName("G1").columnWidth = 3.14;
  sheet.getRangeByName("N1").columnWidth = 2.14;
  sheet.getRangeByName("A9:T9").rowHeight = 15.00;
  sheet.getRangeByName("A18:T18").rowHeight = 15.00;
  sheet.getRangeByName("A27:T27").rowHeight = 15.00;
  sheet.getRangeByName("A36:T36").rowHeight = 22.50;
  sheet.getRangeByName("A45:T45").rowHeight = 17.25;


  // Column 1
  sheet.getRangeByName('A1').columnWidth = 6.86;
  sheet.getRangeByName('B1').columnWidth = .83;
  sheet.getRangeByName('C1').columnWidth = 8.29;
  sheet.getRangeByName('D1').columnWidth = 2.57;
  sheet.getRangeByName('E1').columnWidth = .83;
  sheet.getRangeByName('F1').columnWidth = 6.29;

  // Column 2
  sheet.getRangeByName('H1').columnWidth = 6.86;
  sheet.getRangeByName('I1').columnWidth = .83;
  sheet.getRangeByName('J1').columnWidth = 8.29;
  sheet.getRangeByName('K1').columnWidth = 2.57;
  sheet.getRangeByName('L1').columnWidth = .83;
  sheet.getRangeByName('M1').columnWidth = 6.29;

  // Column 3
  sheet.getRangeByName('O1').columnWidth = 6.86;
  sheet.getRangeByName('P1').columnWidth = .83;
  sheet.getRangeByName('Q1').columnWidth = 8.29;
  sheet.getRangeByName('R1').columnWidth = 2.57;
  sheet.getRangeByName('S1').columnWidth = .83;
  sheet.getRangeByName('T1').columnWidth = 6.29;


  // Generate Labels
  for(int i = 0; i < numberLabels; i++){
    switch(col){
      case 1 :
        generateLabel(
          rangeName: ["A", "B", "C", "D", "E", "F"],
          data: [partNo, qtyPack, qtyDlv, dlvDate, lotNo, location, pic],
          logo: logo,
          barcode: bytes
        );

        // Increment
        col = 2;
      
        break;

      case 2 :
        generateLabel(
          rangeName: ["H", "I", "J", "K", "L", "M"],
          data: [partNo, qtyPack, qtyDlv, dlvDate, lotNo, location, pic],
          logo: logo,
          barcode: bytes
        );
        
        // Increment
        col = 3;
      
        break;

      case 3 :
        generateLabel(
          rangeName: ["O", "P", "Q", "R", "S", "T"],
          data: [partNo, qtyPack, qtyDlv, dlvDate, lotNo, location, pic],
          logo: logo,
          barcode: bytes
        );
        
        // Increment
        row += 9;
        col = 1;
      
        break;
    }
  }

  workbook = Workbook();
  sheet = workbook.worksheets[0];

  col = 1;
  row = 1;
  final List<int> files = workbook.saveAsStream();
  final Directory path = await getApplicationDocumentsDirectory();
  await Directory("${path.path}/Generate Label").create(recursive: true);
  await File("${path.path}/Generate Label/$partNo.xlsx").writeAsBytes(files);
  workbook.dispose();
}