import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Weather extends StatefulWidget {
  final String deviceId;

  const Weather({
    super.key,
    required this.deviceId,
  });

  @override
  State<Weather> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Weather> {
  late TooltipBehavior _tooltipBehavior;
  late String _startDate;
  late String _endDate;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: Colors.purple);
    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // _tooltip = TooltipBehavior(enable: true);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeSeries Graphs for Weather Data'),
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
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,
                    title: ChartTitle(text: 'Light Intensity Graph'),
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
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,
                    title: ChartTitle(text: 'Temperature Graph'),
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
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,
                    title: ChartTitle(text: 'Relative Humidity Graph'),
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
  if (response.statusCode == 200) {
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
