import 'dart:convert';
import 'package:detest/Image_download.dart';
import 'package:detest/Inferenced_Data copy.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:detest/constant.dart';
import 'package:detest/weatherData.dart';
import 'package:intl/intl.dart';

class SpainScreen extends StatefulWidget {
  @override
  State<SpainScreen> createState() => _SpainScreenState();
}

class _SpainScreenState extends State<SpainScreen> {
  late TextEditingController dateController;
  late TextEditingController timeinput;

  late int sleepDuration = 0;
  List<Device> filterData = deviceData
      .where((device) =>
          device.deviceId == "D1003" ||
          device.deviceId == "D1004" ||
          device.deviceId == "D1005")
      .toList();
  @override
  void initState() {
    dateController = TextEditingController();
    timeinput = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          title: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text('Spain DATA')
            ],
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Table(
                    columnWidths: const {
                      0: FractionColumnWidth(0.18),
                      1: FractionColumnWidth(0.17),
                      2: FractionColumnWidth(0.16),
                      3: FractionColumnWidth(0.16),
                      4: FractionColumnWidth(0.16),
                      5: FractionColumnWidth(0.17)
                      // 6: FractionColumnWidth(0.14),
                    },
                    children: const <TableRow>[
                      TableRow(children: <Widget>[
                        Center(
                          child: Text(
                            'S.NO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: backgroundColor),
                          ),
                        ),
                        Center(
                          child: Text(
                            'DEVICE ID',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: backgroundColor),
                          ),
                        ),
                        Center(
                          child: Text(
                            'BOOT STATUS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: backgroundColor),
                          ),
                        ),

                        Center(
                          child: Text(
                            'Weather Data',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: backgroundColor),
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     'Motion Count',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //         color: backgroundColor),
                        //   ),
                        // ),
                        Center(
                          child: Text(
                            'Insect Count',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: backgroundColor),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Image',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: backgroundColor),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            for (int i = 0; i < filterData.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.16),
                        1: FractionColumnWidth(0.17),
                        2: FractionColumnWidth(0.17),
                        3: FractionColumnWidth(0.17),
                        4: FractionColumnWidth(0.18),
                        5: FractionColumnWidth(0.15)
                        // 6: FractionColumnWidth(0.14)
                      },
                      children: [
                        TableRow(children: [
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(
                                    fontSize: 16, color: backgroundColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                filterData[i].deviceId,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                filterData[i].status,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  // print('Status');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => Weather(
                                        // values: [],
                                        deviceId: filterData[i].deviceId,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.cloud,
                                  color: backgroundColor,
                                ),
                                // label: const Text('TempDB Data'),
                                style: ElevatedButton.styleFrom(
                                    // elevation: 10,
                                    backgroundColor: Colors.white10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  // print('Inference');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => Inference(
                                        // values: [],
                                        deviceId: filterData[i].deviceId,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.insert_chart,
                                  color: backgroundColor,
                                ),
                                // label: const Text('Inferenced Data'),
                                style: ElevatedButton.styleFrom(
                                    // elevation: 10,
                                    backgroundColor: Colors.white10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  // print('Status');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => Pictures(
                                        deviceId: filterData[i].deviceId,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.image,
                                  color: backgroundColor,
                                ),
                                // label: const Text('TempDB Data'),
                                style: ElevatedButton.styleFrom(
                                    // elevation: 10,
                                    backgroundColor: Colors.white10),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}
