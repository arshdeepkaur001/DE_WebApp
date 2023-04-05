// import 'dart:io';
// // import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:detest/timeseries.dart';
// //=============================================================
// // ===================== download csv for web =================
// //=============================================================
// // UnComment when Platform is web & also uncomment  ***(downloadCsvForWeb Method) it's only for csv;
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'dart:html' as html;
// //=============================================================
// //=============================================================
// //=============================================================

// class Logic with ChangeNotifier {
//   lfinal String deviceId;
//   final String startdate;
//   final String enddate;
//   final String temperature;
//   final String lightintensity;
//   final String mean;
//   final String sd;
//   final String timestamp;
//   final String relhumidity;

//   List<Map<String, dynamic>> data = [];

//   // getter of _dataOneDay
//   List<Map<String, dynamic>> get datalist {
//     return [...data];
//   }

//   Map<String, dynamic> datamap = {};

//   String url =
//       "https://8h19xk09w6.execute-api.us-west-2.amazonaws.com/default/web_mob_test?sensor_id=WQ101&period=last_year";

//   void clearAllList() {
//     data = [];
//     // csvDownloadSuccessfull = '';/
//     notifyListeners();
//   }

//   //get device id
//   void getDeviceId(String id) {
//     deviceId = id;

//     notifyListeners();
//   }

//   int refreshToken = 0;
//   // get token
//   void getToken(String t) {
//     startdate = t;
//     // int oneHour=3600000;
//     refreshToken = DateTime.now().millisecondsSinceEpoch + 3600000;
//     // refreshToken = DateTime.now().millisecondsSinceEpoch;

//     notifyListeners();
//   }

//   // Configuration data of device
//   // Haw many device are Rigester
//   Future<List<Map<String, dynamic>>> totalDeviceRegister() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://8h19xk09w6.execute-api.us-west-2.amazonaws.com/default/config'),
//       // headers: {
//       //   HttpHeaders.authorizationHeader: 'Bearer $_token',
//       // },
//       // Uri.parse(
//       //     'https://housyod6u3.execute-api.us-west-2.amazonaws.com/config'),
//       // Send authorization headers to the backend.
//       // headers: {
//       //   HttpHeaders.authorizationHeader: 'Bearer $_token',
//       // },
//     );
//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       // print(jsonDecode(response.body));
//       final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
//       // print(parsed);

//       notifyListeners();

//       return parsed;
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load api');
//     }
//   }

//   // Return list of GrapHModel
//   List<Graph>? graphData(String filds, String period) {
//     List<Graph> data1 = [];
//     List<String> dateTimeStr = [];
//     DateTime dateTime;
//     // Last Day
//     // if (period == 'last_day') {
//     for (int i = 0; i < datalist.length; i++) {
//       dateTimeStr = datalist[i]['time_stamp'].split(' ');
//       dateTime = DateTime.parse('${dateTimeStr[0]} ${dateTimeStr[1]}');

//       data1.add(
//         const Graph(
//             deviceId: "",
//             startdate: "",
//             enddate: "",
//             temperature: "",
//             lightintensity: "",
//             mean: "",
//             sd: "",
//             timestamp: "",
//             relhumidity: ""),
//       );
//       // }

//       return data1;
//       // Last Week
//     }
//   }

// //===========================  Ui =======================
// //===========================  Ui =======================
// //===========================  Ui =======================

//   // Color bgColor = const Color.fromARGB(255, 255, 254, 230);
//   Color bgColor = Colors.white;
//   bool togel = true;
//   // Change background color
//   // Dark to Light and vice versa
//   void changeBgColor() {
//     if (togel) {
//       togel = false;
//       // bgColor = Colors.white;
//       bgColor = const Color.fromARGB(255, 50, 48, 48);
//     } else {
//       togel = true;

//       // bgColor = const Color.fromARGB(255, 255, 254, 230);
//       bgColor = Colors.white;
//     }
//     notifyListeners();
//   }

//   Map<String, dynamic> liveData() {
//     DateFormat f = DateFormat("yyyy-MM-dd HH:mm:ss");
//     // DateTime date = DateTime.now();
//     int index = 0;
//     int max = 0;
//     int milli = 0;
//     for (int i = datalist.length - 1; i >= 0; i--) {
//       // if (date
//       //     .isAfter(f.parse(dataListOneDay[i]['time_stamp'].substring(0, 19)))) {
//       //   index = i;
//       // }
//       milli = f
//           .parse(datalist[i]['time_stamp'].substring(0, 19))
//           .millisecondsSinceEpoch;
//       if (milli > max) {
//         max = milli;
//         index = i;
//       }
//     }

//     return datalist[index];
//   }

// //===========================  Ui  end=======================
// //===========================  Ui  end=======================
// //===========================  Ui  end=======================
// // Calculate Details
//   Future<Map<String, String>> calculateDetails(String? time) async {
//     List<Map<String, dynamic>> dataList = [];
//     Map<String, String> result = {};

//     // 'last_year'
//     // 'last_month'
//     // 'last_week'
//     // 'five_year'
//     if (time == 'last_week') {
//       if (oneWeekDetails.isEmpty) {
//         dataList = dataListOneWeek;
//       } else {
//         // print('========= After First Time ===============');
//         return oneWeekDetails;
//       }
//     } else if (time == 'last_month') {
//       if (oneMonthDetails.isEmpty) {
//         dataList = dataListOneMonth;
//       } else {
//         // print('========= After First Time ===============');
//         return oneMonthDetails;
//       }
//     } else if (time == 'last_year') {
//       if (oneYearDetails.isEmpty) {
//         dataList = dataListOneYear;
//       } else {
//         // print('========= After First Time ===============');
//         return oneYearDetails;
//       }
//     } else {
//       if (fiveYearDetails.isEmpty) {
//         dataList = dataListFiveYear;
//       } else {
//         // print('========= After First Time ===============');
//         return fiveYearDetails;
//       }
//     }
//     if (dataList.isEmpty) {
//       return {};
//     }

//     //Temeprature
//     double maxTemp = double.parse(dataList[0]['temperature']);
//     double minTemp = double.parse(dataList[0]['temperature']);
//     double avgTemp = 0.0;
//     double tempCompairResult = 0.0;
//     //TDS
//     double maxTds = double.parse(dataList[0]['TDS']);
//     double minTds = double.parse(dataList[0]['TDS']);
//     double avgTds = 0.0;
//     double tdsCompairResult = 0.0;
//     //COD
//     double maxCod = double.parse(dataList[0]['COD']);
//     double minCod = double.parse(dataList[0]['COD']);
//     double avgCod = 0.0;
//     double codCompairResult = 0.0;
//     //BOD
//     double maxBod = double.parse(dataList[0]['BOD']);
//     double minBod = double.parse(dataList[0]['BOD']);
//     double avgBod = 0.0;
//     double bodCompairResult = 0.0;
//     //pH
//     double maxpH = double.parse(dataList[0]['pH']);
//     double minpH = double.parse(dataList[0]['pH']);
//     double avgpH = 0.0;
//     double phCompairResult = 0.0;
//     // EC
//     double maxEc = double.parse(dataList[0]['EC']);
//     double minEc = double.parse(dataList[0]['EC']);
//     double avgEc = 0.0;
//     double ecCompairResult = 0.0;
//     // DO
//     // double firstDoItem = doFormula(dataList[0]['COD'], dataList[0]['BOD']);
//     double maxDo = double.parse(dataList[0]['DO']);
//     double minDo = double.parse(dataList[0]['DO']);
//     double avgDo = 0.0;
//     double doCompairResult = 0.0;

//     int length = dataList.length;
//     for (int i = 0; i < length; i++) {
//       // ============= temp
//       tempCompairResult = double.parse(dataList[i]['temperature']);
//       avgTemp += tempCompairResult;
//       if (tempCompairResult > maxTemp) {
//         maxTemp = tempCompairResult;
//       }

//       if (tempCompairResult < minTemp) {
//         minTemp = tempCompairResult;
//       }
//       //============== TDS
//       tdsCompairResult = double.parse(dataList[i]['TDS']);
//       avgTds += tdsCompairResult;
//       if (tdsCompairResult > maxTds) {
//         maxTds = tdsCompairResult;
//       }

//       if (tdsCompairResult < minTds) {
//         minTds = tdsCompairResult;
//       }
//       //============== COD
//       codCompairResult = double.parse(dataList[i]['COD']);
//       avgCod += codCompairResult;
//       if (codCompairResult > maxCod) {
//         maxCod = codCompairResult;
//       }

//       if (codCompairResult < minCod) {
//         minCod = codCompairResult;
//       }
//       //============== BOD
//       bodCompairResult = double.parse(dataList[i]['BOD']);
//       avgBod += bodCompairResult;
//       if (bodCompairResult > maxBod) {
//         maxBod = bodCompairResult;
//       }

//       if (bodCompairResult < minBod) {
//         minBod = bodCompairResult;
//       }
//       //============== pH
//       phCompairResult = double.parse(dataList[i]['pH']);
//       avgpH += phCompairResult;
//       if (phCompairResult > maxpH) {
//         maxpH = phCompairResult;
//       }

//       if (phCompairResult < minpH) {
//         minpH = phCompairResult;
//       }
//       // ============= EC
//       ecCompairResult = double.parse(dataList[i]['EC']);
//       avgEc += ecCompairResult;
//       if (ecCompairResult > maxEc) {
//         maxEc = ecCompairResult;
//       }
//       if (ecCompairResult < minEc) {
//         minEc = ecCompairResult;
//       }
//       // ==================== DO

//       doCompairResult = double.parse(dataList[i]['DO']);
//       avgDo += doCompairResult;
//       if (doCompairResult > maxDo) {
//         maxDo = doCompairResult;
//       }
//       if (doCompairResult < minDo) {
//         minDo = doCompairResult;
//       }
//     }

//     // // temp =======
//     // // this part will be remove in future
//     // minTemp = 0 > minTemp ? 15 : _minTemp;
//     // //===========
//     avgTemp = avgTemp / length;
//     avgTds = avgTds / length;
//     avgCod = avgCod / length;
//     avgBod = avgBod / length;
//     avgpH = avgpH / length;
//     avgEc = avgEc / length;
//     avgDo = avgDo / length;

//     result = {
//       //temp
//       'avgTemp': avgTemp.toStringAsFixed(2),
//       'minTemp': minTemp.toStringAsFixed(2),
//       'maxTemp': maxTemp.toStringAsFixed(2),
//       //tds
//       'avgTds': avgTds.toStringAsFixed(2),
//       'minTds': minTds.toStringAsFixed(2),
//       'maxTds': maxTds.toStringAsFixed(2),
//       //cod
//       'avgCod': avgCod.toStringAsFixed(2),
//       'minCod': minCod.toStringAsFixed(2),
//       'maxCod': maxCod.toStringAsFixed(2),
//       //bod
//       'avgBod': avgBod.toStringAsFixed(2),
//       'minBod': minBod.toStringAsFixed(2),
//       'maxBod': maxBod.toStringAsFixed(2),
//       //pH
//       'avgpH': avgpH.toStringAsFixed(2),
//       'minpH': minpH.toStringAsFixed(2),
//       'maxpH': maxpH.toStringAsFixed(2),
//       //Do
//       'avgDo': avgDo.toStringAsFixed(2),
//       'minDo': minDo.toStringAsFixed(2),
//       'maxDo': maxDo.toStringAsFixed(2),
//       //Ec
//       'avgEc': avgEc.toStringAsFixed(2),
//       'minEc': minEc.toStringAsFixed(2),
//       'maxEc': maxEc.toStringAsFixed(2),
//     };
//     if (time == 'last_week') {
//       oneWeekDetails = result;
//     } else if (time == 'last_month') {
//       oneMonthDetails = result;
//     } else if (time == 'last_year') {
//       oneYearDetails = result;
//     } else {
//       fiveYearDetails = result;
//     }
//     dataList = [];
//     // print('=========== First Time ============');
//     return result;
//   }

//   // ========================== CSV ===================
//   // ========================== CSV ===================
//   // ========================== CSV ===================
//   String convertToCsv() {
//     List<List<dynamic>> rowsCsv = [
//       [
//         "deviceId",
//         "pH",
//         "TDS",
//         "DO",
//         "COD",
//         "BODS",
//         "Temprature",
//         "EC",
//         "DateTime"
//       ]
//     ];

//     _dataFiveYear.sort((a, b) {
//       var adate = a['time_stamp'];
//       var bdate = b['time_stamp'];
//       return -adate.compareTo(bdate);
//     });
//     List<dynamic> row = [];
//     for (int i = 0; i < _dataFiveYear.length; i++) {
//       row = [];
//       row.add(_dataFiveYear[i]['deviceId']);
//       row.add(_dataFiveYear[i]['pH']);
//       row.add(_dataFiveYear[i]['TDS']);
//       row.add(_dataFiveYear[i]['BOD']);
//       row.add(_dataFiveYear[i]['COD']);
//       row.add(_dataFiveYear[i]['DO']);
//       row.add(_dataFiveYear[i]['temperature']);
//       row.add(_dataFiveYear[i]['EC']);
//       row.add(_dataFiveYear[i]['time_stamp']);

//       rowsCsv.add(row);
//     }
//     // String csv = const ListToCsvConverter().convert(rowsCsv);
//     return csv;
//   }

//   String csvDownloadSuccessfull = '';
//   String? csvPath;
//   Future<void> downloadCsv() async {
//     csvDownloadSuccessfull = 'wait';
//     notifyListeners(); // it will trigger when button click
//     String getData = await getLastFiveYearData();
//     if (getData == '200') {
//       csvDownloadSuccessfull = 'ok';

//       // if (kIsWeb) {
//       // downloadCsvForWeb(convertToCsv().codeUnits, downloadName: 'Jal.csv');
//       // } else {
//       if (await Permission.storage.request().isGranted) {
//         DateTime creationTime = DateTime.now();
//         String ti = creationTime.hour.toString() +
//             creationTime.minute.toString() +
//             creationTime.second.toString();
//         final String path = '/storage/emulated/0/Download/Jal$ti.csv';
//         File file = File(path);
//         file.writeAsString(convertToCsv());
//         csvPath = path;
//       } else {
//         // Map<Permission, PermissionStatus> statuses =
//         await [
//           Permission.storage,
//         ].request();
//       }
//       // }
//     } else {
//       csvDownloadSuccessfull = _dataFiveYear.isEmpty ? '' : 'ok';
//     }
//     notifyListeners();
//   }

//   // void downloadCsvForWeb(
//   //   List<int> bytes, {
//   //   String? downloadName,
//   // }) {
//   //   // Encode our file in base64
//   //   final base64 = base64Encode(bytes);
//   //   // Create the link with the file
//   //   final anchor =
//   //       html.AnchorElement(href: 'data:application/octet-stream;base64,$base64')
//   //         ..target = 'blank';
//   //   // add the name
//   //   if (downloadName != null) {
//   //     anchor.download = downloadName;
//   //   }
//   //   // trigger download
//   //   html.document.body!.append;
//   //   anchor.click();
//   //   anchor.remove();
//   //   return;
//   // }
// }

// // Model
// class GraphModel {
//   GraphModel({required this.xCord, required this.yCord});
//   final DateTime xCord;
//   final double yCord;
// }
