// import 'dart:convert';
// import 'dart:html' as html;
// import 'package:share/share.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:detest/widget/check_permission.dart';
// import 'package:detest/widget/directory_path.dart';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class Battery extends StatefulWidget {
//   final String deviceId;

//   const Battery({
//     super.key,
//     required this.deviceId,
//   });

//   @override
//   State<Battery> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Battery> {
//   late DateTime ts;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     ts = DateTime.parse(DateTime.now().toString());
//   }

//   Future<void> getAPIData(String deviceId, DateTime ts) async {
//     final response = await http.get(Uri.https(
//       'https://eyezeqzt5c.execute-api.us-east-1.amazonaws.com',
//       '/getData/voltage',
//       {
//         'TimeStamp': ts.year.toString() +
//             "-" +
//             ts.month.toString() +
//             "-" +
//             ts.day.toString() +
//             "%20" +
//             ts.hour.toString() +
//             ":" +
//             ts.minute.toString() +
//             ":" +
//             ts.second.toString(),
//         'DeviceId': deviceId,
//       },
//     ));
//     var parsed = jsonDecode(response.body);
//     if (parsed['statusCode'] == 200) {
//       final data = parsed['body'];
//       print(data);
//     } else if (parsed['statusCode'] == 400 ||
//         parsed['statusCode'] == 404 ||
//         parsed['statusCode'] == 500) {
//       setState(() {
//         errorMessage = parsed['body'][0]['message'];
//       });
//     } else {
//       throw Exception('Failed to load api');
//     }
//     // @override
//     // Widget build(BuildContext context) {
//     //   throw UnimplementedError();
//     // }
//   }

//   void updateData() async {
//     await getAPIData(widget.deviceId, ts);
//     // if (chartData.isEmpty) {
//     //   Class = ' ';
//     // } else {
//     //   Class = chartData[0].Class;
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
class Battery extends StatefulWidget {
  final String deviceId;

  const Battery({
    super.key,
    required this.deviceId,
  });

  @override
  State<Battery> createState() => _BatteryState();
}

class _BatteryState extends State<Battery> {
  late DateTime ts;
  String errorMessage = '';
  String voltageData = ''; // Store the voltage data here

  @override
  void initState() {
    super.initState();
    ts = DateTime.now();
    updateData(); // Call updateData when the widget is initialized
  }

  List<double> lastResponses = [];
  double average = 12.63;
  Future<void> getAPIData(String deviceId, DateTime ts) async {
    final response = await http.get(Uri.https(
      'eyezeqzt5c.execute-api.us-east-1.amazonaws.com',
      '/getData/voltage',
      {
        'TimeStamp':
            '${ts.year}-${ts.month}-${ts.day} ${ts.hour}:${ts.minute}:${ts.second}',
        // ts.year +
        //     "-" +
        //     ts.month +
        //     "-" +
        //     ts.day +
        //     "%20" +
        //     ts.hour +
        //     ":" +
        //     ts.minute +
        //     ":" +
        //     ts.second,
        'DeviceId': deviceId,
      },
    ));
    // print(response.body);
    print(ts.month.runtimeType);
    print(ts.day.runtimeType);
    print(ts.year.runtimeType);
    var parsed = jsonDecode(response.body);
    if (parsed['statusCode'] == 200) {
      final data = parsed['body'];

      //last 10 non-null approach
      if (data != null) {
        lastResponses.add(double.parse(data));

        if (lastResponses.length > 10) {
          lastResponses.removeAt(0);
        }
      }
      setState(() {
        voltageData = data.toString(); // Update the voltage data here
      });
    } else if (parsed['statusCode'] == 404) {
      double sum = 0.0;
      int count = 0;
      for (double resp in lastResponses) {
        if (resp != 0) {
          sum += resp;
          count++;
        }
      }
      // print("sum");
      // print(sum);
      // print("count");
      // print(count);
      // print("average");
      // print(average);
      average = sum / count;
      setState(() {
        voltageData = average.toString(); // Update the voltage data here
      });
    } else if (parsed['statusCode'] == 400 || parsed['statusCode'] == 500) {
      setState(() {
        errorMessage = parsed['body'][0]['message'];
      });
    } else {
      throw Exception('Failed to load api');
    }
  }

  void updateData() async {
    await getAPIData(widget.deviceId, ts);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.battery_full, // You can choose a suitable battery icon
          size: 48,
        ),
        Text(
          'Voltage: $voltageData', // Display the voltage data here
          style: TextStyle(fontSize: 16),
        ),
        if (errorMessage.isNotEmpty)
          Text(
            'Error: $errorMessage',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
