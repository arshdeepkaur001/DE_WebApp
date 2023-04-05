// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// // void main() {
// //   return runApp(_ChartApp());
// // }

// // class _ChartApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       theme: ThemeData(prim  arySwatch: Colors.blue),
// //       home: _MyHomePage(),
// //     );
// //   }
// // }
// final _formKey = GlobalKey<FormState>();
// // final _startDateController = TextEditingController();
// // final _endDateController = TextEditingController();
// // final _deviceIdController = TextEditingController();

// class Graph extends StatefulWidget {
//   final String deviceId;
//   // final String startdate;
//   // final String enddate;

//   const Graph({
//     super.key,
//     required this.deviceId,
//     // required this.startdate,
//     // required this.enddate,
//     // required String startdate,
//     // required String enddate,
//     // required this.temperature,
//     // required this.lightintensity,
//     // required this.mean,
//     // required this.sd,
//     // required this.timestamp,
//     // required this.relhumidity,
//     // required this.deviceId,
//     // required this.startdate,
//     // required this.enddate
//   });

//   @override
//   State<Graph> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Graph> {
//   final _formKey = GlobalKey<FormState>();
//   final _startDateController = TextEditingController();
//   final _endDateController = TextEditingController();
//   // final _deviceIdController = TextEditingController();

//   // late List<ChartData> data;
//   late TooltipBehavior _tooltip;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Fetch Data'),
//           backgroundColor: Colors.green,
//         ),
//         body: SingleChildScrollView(
//           children: [
//             child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                     key: _formKey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         child: (
//                           TextFormField(
//                             controller: _startDateController,
//                             decoration: InputDecoration(
//                               labelText: 'Start Date (YYYY-MM-DD)',
//                             ),
//                             validator: (value) {
//                               if (value?.isEmpty ?? true) {
//                                 return 'Start date is required';
//                               }
//                               return null;
//                             },
//                           ),
//                           TextFormField(
//                             controller: _endDateController,
//                             decoration: InputDecoration(
//                               labelText: 'End Date (YYYY-MM-DD)',
//                             ),
//                             validator: (value) {
//                               if (value?.isEmpty ?? true) {
//                                 return 'End date is required';
//                               }
//                               return null;
//                             },
//                           ),
//                           // TextFormField(
//                           //   controller: _deviceIdController,
//                           //   decoration: InputDecoration(
//                           //     labelText: 'Device ID',
//                           //   ),
//                           //   validator: (value) {
//                           //     if (value?.isEmpty ?? true) {
//                           //       return 'Device ID is required';
//                           //     }
//                           //     return null;
//                           //   },
//                           // ),
//                           SizedBox(height: 16.0),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState?.validate() ?? false) {
//                                 getapiData(
//                                     _startDateController.toString(),
//                                     _endDateController.toString(),
//                                     widget.deviceId);
//                               }
//                             },
//                             child: Text('Get Data'),
//                             style: ElevatedButton.styleFrom(
//                               primary:
//                                   Colors.green, // Set the button color to green
//                             ),
//                           ),
//                           // SizedBox(height: 16.0),
//                           // ElevatedButton(
//                           //   onPressed: () {
//                           //     if (_data.isNotEmpty) {
//                           //       _downloadData(_data);
//                           //     }
//                           //   },
//                           //   child: Text('Download Data as CSV'),
//                           //   style: ElevatedButton.styleFrom(
//                           //     primary: Colors.green,
//                           //   ),
//                           // ),
//                           SizedBox(height: 16.0)
//         )))),

//             // body: Center(
//             child: Container(
//                 child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(),
//                     title: ChartTitle(text: 'Mean Graph'),
//                     series: <ChartSeries<apiData, String>>[
//                   LineSeries<apiData, String>(
//                     dataSource: chartData,
//                     xValueMapper: (apiData sales, _) => sales.TimeStamp,
//                     yValueMapper: (apiData sales, _) => int.parse(sales.Mean),
//                   )
//                 ]
//                     //             primaryXAxis:
//                     //                 CategoryAxis(title: AxisTitle(text: 'Primary X Axis')),
//                     //             primaryYAxis:
//                     //                 NumericAxis(title: AxisTitle(text: 'Primary Y Axis')),
//                     //             // adding multiple axis
//                     //             axes: <ChartAxis>[
//                     //   NumericAxis(
//                     //       name: 'xAxis',
//                     //       opposedPosition: true,
//                     //       interval: 1,
//                     //       minimum: 0,
//                     //       maximum: 5,
//                     //       title: AxisTitle(text: 'Secondary X Axis')),
//                     //   NumericAxis(
//                     //       name: 'yAxis',
//                     //       opposedPosition: true,
//                     //       title: AxisTitle(text: 'Secondary Y Axis'))
//                     // ],
//                     //             series: <ChartSeries>[
//                     //   LineSeries<apiData, String>(
//                     //       dataSource: chartData,
//                     //       xValueMapper: (ChartData data, _) => data.x,
//                     //       yValueMapper: (ChartData data, _) => data.y),
//                     //   LineSeries<ChartData, String>(
//                     //       dataSource: [
//                     //         ChartData('Jan', 15, 1),
//                     //         ChartData('Feb', 11, 2),
//                     //         ChartData('Mar', 14, 3),
//                     //         ChartData('Apr', 12, 4),
//                     //       ],
//                     //       xValueMapper: (ChartData data, _) => data.x,
//                     //       yValueMapper: (ChartData data, _) => data.y1,
//                     //       xAxisName: 'xAxis',
//                     //       yAxisName: 'yAxis')
//                     // ]
//                     )))
//                   ],
//                     );
//   }
// }

// Future<List<dynamic>> getAPIData(
//     String startDate, String endDate, String deviceId) async {
//   // DateTime now = DateTime.now();
//   // String formattedDate = '${now.year}-${now.month}-${now.day}';
//   // print(formattedDate);
//   final response = await http.get(Uri.https(
//     'z6sd4rs5e9.execute-api.us-east-1.amazonaws.com',
//     '/devlopement/lambda_db',
//     {'startdate': startDate, 'enddate': endDate, 'deviceid': deviceId},
//   ));

//   // final response = await http.get(Uri.parse(
//   //   'z6sd4rs5e9.execute-api.us-east-1.amazonaws.com/devlopement/lambda_db',
//   //   {
//   //     'startdate': _startDateController.text,
//   //     'enddate': _endDateController.text,
//   //     'deviceid': _deviceIdController.text,
//   //   },
//   // ));
//   // final response =Uri.parse(
//   //       'https://z6sd4rs5e9.execute-api.us-east-1.amazonaws.com/devlopement/lambda_db?deviceid=${deviceId}&startdate=2022-02-14&enddate=${formattedDate}');
//   //   Uri.parse('https://mocki.io/v1/d485ae33-22bf-4367-bae7-3f353a3663dd'),
//   // );
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.s
//     // print("Sahil");
//     // print(jsonDecode(response.body));

//     var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
//     List<dynamic> data = parsed['body'];
//     print(data);
//     return data;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load api');
//   }
// }

// // class ChartData {
// //   ChartData(this.x, this.y, this.y1);
// //   final String x;
// //   final double? y;
// //   final double? y1;
// // }

// class apiData {
//   apiData(this.TimeStamp, this.Mean);

//   final String TimeStamp;
//   final String Mean;

//   factory apiData.fromJson(dynamic parsedJson) {
//     return apiData(
//       parsedJson['TimeStamp'].toString(),
//       parsedJson['Mean'].toString(),
//     );
//   }
// }

// List<apiData> chartData = [];

// Future getapiData(String startdate, String enddate, String deviceId) async {
//   final List<dynamic> jsonString =
//       await getAPIData(startdate, enddate, deviceId);
//   // final dynamic jsonResponse = json.decode(jsonString.toString());
//   // if( jsonString == null)
//   for (dynamic i in jsonString) {
//     chartData.add(apiData.fromJson(i));
//   }
//   print(chartData);
// }

// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Graph extends StatefulWidget {
//   final String deviceId;

//   const Graph({
//     super.key,
//     required this.deviceId,
//   });

//   @override
//   State<Graph> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Graph> {
//   late TooltipBehavior _tooltip;
//   late String _startDate;
//   late String _endDate;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // _tooltip = TooltipBehavior(enable: true);
//   //   // _startDate = "2022-02-14";
//   //   // // _endDate = "2023-03-28";
//   //   // getapiData(widget.deviceId, _startDate, _endDate);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TimeSeries Data'),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: Container(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text("Start Date: "),
//                   Expanded(
//                     child: TextField(
//                       onChanged: (value) {
//                         _startDate = value;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'YYYY-MM-DD',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text("End Date: "),
//                   Expanded(
//                     child: TextField(
//                       onChanged: (value) {
//                         _endDate = value;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'YYYY-MM-DD',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                   onPressed: () {
//                     // Clear existing data
//                     chartData.clear();
//                     // Fetch new data
//                     getapiData(widget.deviceId, _startDate, _endDate);
//                   },
//                   child: Text('Get Data'),
//                   style: ElevatedButton.styleFrom(primary: Colors.green)),
//               SizedBox(height: 16.0),
//               Container(
//                 child: SfCartesianChart(
//                   primaryXAxis: CategoryAxis(),
//                   title: ChartTitle(text: 'Mean Graph'),
//                   series: <ChartSeries<apiData, String>>[
//                     LineSeries<apiData, String>(
//                       dataSource: chartData,
//                       xValueMapper: (apiData sales, _) => sales.TimeStamp,
//                       yValueMapper: (apiData sales, _) => int.parse(sales.Mean),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<List<dynamic>> getAPIData(
//     String deviceId, String _startDate, String _endDate) async {
//   final response = await http.get(Uri.https(
//     'z6sd4rs5e9.execute-api.us-east-1.amazonaws.com',
//     '/devlopement/lambda_db',
//     {
//       'startdate': _startDate,
//       'enddate': _endDate,
//       'deviceid': deviceId,
//     },
//   ));

//   if (response.statusCode == 200) {
//     var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
//     List<dynamic> data = parsed['body'];
//     print(data);
//     return data;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load api');
//   }
// }

// class apiData {
//   apiData(this.TimeStamp, this.Mean);

//   final String TimeStamp;
//   final String Mean;

//   factory apiData.fromJson(dynamic parsedJson) {
//     return apiData(
//       parsedJson['TimeStamp'].toString(),
//       parsedJson['Mean'].toString(),
//     );
//   }
// }

// List<apiData> chartData = [];

// Future getapiData(String deviceId, _startDate, _endDate) async {
//   final List<dynamic> jsonString =
//       await getAPIData(deviceId, _startDate, _endDate);

//   for (dynamic i in jsonString) {
//     chartData.add(apiData.fromJson(i));
//   }
//   print(chartData);
// }
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:detest/bg.dart';

class Graph extends StatefulWidget {
  final String deviceId;

  const Graph({
    super.key,
    required this.deviceId,
  });

  @override
  State<Graph> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Graph> {
  late TooltipBehavior _tooltipBehavior;
  late String _startDate;
  late String _endDate;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: Colors.purple);
    super.initState();
  }
  // TooltipBehavior? _tooltipBehavior;
  // @override
  // void initState() {
  //   super.initState();
  //   _tooltip = TooltipBehavior(enable: true);
  //   // _startDate = "2022-02-14";
  //   // // _endDate = "2023-03-28";
  //   // getapiData(widget.deviceId, _startDate, _endDate);
  // }

  void updateData() async {
    final List<dynamic> jsonString =
        await getAPIData(widget.deviceId, _startDate, _endDate);

    chartData.clear();
    for (dynamic i in jsonString) {
      chartData.add(apiData.fromJson(i));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // bool forColor = Provider.of<Logic>(context).togel;

    return Scaffold(
      appBar: AppBar(
        title: Text('TimeSeries Graphs'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (value) {
                    _startDate = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Start Date (YYYY-MM-DD)',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    _endDate = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'End Date (YYYY-MM-DD)',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // fetch new data
                    updateData();
                  },
                  child: Text('Get Data'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set the button color to green
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 500,
                  child: SfCartesianChart(
                    // tooltipBehavior: _tooltip,
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,
                    title: ChartTitle(
                        text: 'Light Intensity Graph',
                        backgroundColor: Color.fromARGB(160, 230, 221, 221),
                        borderColor: Colors.black,
                        borderWidth: 2,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    series: <ChartSeries<apiData, String>>[
                      LineSeries<apiData, String>(
                        markerSettings: const MarkerSettings(
                          height: 2.0,
                          width: 2.0,
                          borderColor: Colors.green,
                          isVisible: true,
                        ),
                        dataSource: chartData,
                        xValueMapper: (apiData sales, _) => sales.TimeStamp,
                        yValueMapper: (apiData sales, _) =>
                            double.parse(sales.Light_intensity),
                        dataLabelSettings: DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 500,
                  child: SfCartesianChart(
                    // tooltipBehavior: _tooltip,
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,
                    title: ChartTitle(
                        text: 'Temperature Graph',
                        backgroundColor: Color.fromARGB(160, 230, 221, 221),
                        borderColor: Colors.black,
                        borderWidth: 2,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    series: <ChartSeries<apiData, String>>[
                      LineSeries<apiData, String>(
                        markerSettings: const MarkerSettings(
                          height: 2.0,
                          width: 2.0,
                          borderColor: Colors.green,
                          isVisible: true,
                        ),
                        dataSource: chartData,
                        xValueMapper: (apiData sales, _) => sales.TimeStamp,
                        yValueMapper: (apiData sales, _) =>
                            double.parse(sales.Temperature),
                        dataLabelSettings: DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  child: SfCartesianChart(
                    // tooltipBehavior: _tooltip,

                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,
                    title: ChartTitle(
                        text: 'Relative Humidity Graph',
                        backgroundColor: Color.fromARGB(160, 230, 221, 221),
                        borderColor: Colors.black,
                        borderWidth: 2,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    // style: TextStyle(fontWeight: FontWeight.bold),
                    series: <ChartSeries<apiData, String>>[
                      LineSeries<apiData, String>(
                        markerSettings: const MarkerSettings(
                          height: 2.0,
                          width: 2.0,
                          borderColor: Colors.green,
                          isVisible: true,
                        ),
                        dataSource: chartData,
                        xValueMapper: (apiData sales, _) => sales.TimeStamp,
                        yValueMapper: (apiData sales, _) =>
                            double.parse(sales.Relative_Humidity),
                        dataLabelSettings: DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<dynamic>> getAPIData(
    String deviceId, String _startDate, String _endDate) async {
  final response = await http.get(Uri.https(
    'z6sd4rs5e9.execute-api.us-east-1.amazonaws.com',
    '/devlopement/lambda_db',
    {
      'startdate': _startDate,
      'enddate': _endDate,
      'deviceid': deviceId,
    },
  ));
  var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
  if (parsed['statusCode'] == 200) {
    List<dynamic> data = parsed['body'];
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load api');
  }
}

class apiData {
  apiData(this.TimeStamp, this.Light_intensity, this.Temperature,
      this.Relative_Humidity);

  final String TimeStamp;
  final String Light_intensity;
  final String Temperature;
  final String Relative_Humidity;

  factory apiData.fromJson(dynamic parsedJson) {
    return apiData(
      parsedJson['TimeStamp'].toString(),
      parsedJson['Light_intensity(Lux)'].toString(),
      parsedJson['Temperature(C)'].toString(),
      parsedJson['Relative_Humidity(%)'].toString(),
    );
  }
}

List<apiData> chartData = [];

Future getapiData(String deviceId, _startDate, _endDate) async {
  final List<dynamic> jsonString =
      await getAPIData(deviceId, _startDate, _endDate);

  for (dynamic i in jsonString) {
    chartData.add(apiData.fromJson(i));
  }

  // print(chartData);
}
