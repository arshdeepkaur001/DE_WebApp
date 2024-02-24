import 'dart:convert';
import 'package:detest/Inferenced_Data copy.dart';
import 'package:http/http.dart' as http;
import 'package:detest/device_screen.dart';
import 'package:detest/login.dart';
import 'package:detest/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:detest/config_screen.dart';
import 'package:detest/constant.dart';
import 'package:detest/weatherData.dart';
import 'package:detest/insectCount.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';
import 'package:detest/filteredData.dart';
import 'package:detest/Battery.dart';

class LabScreen extends StatefulWidget {
  @override
  State<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> {
  late TextEditingController dateController;
  late TextEditingController timeinput;

  late int sleepDuration = 0;
  List<Device> filterData = deviceData
      .where((device) =>
          device.deviceId == "bf" ||
          device.deviceId == "22" ||
          device.deviceId == "15" ||
          device.deviceId == "16" ||
          device.deviceId == "S4" ||
          device.deviceId == "S23" ||
          device.deviceId == "S21" ||
          device.deviceId == "S11" ||
          device.deviceId == "S14")
      .toList();
  @override
  void initState() {
    dateController = TextEditingController();
    timeinput = TextEditingController();
    super.initState();
  }

  Future<void> rebootDevice(String deviceId, String status) async {
    String result = " ";
    const url =
        'https://2cbz9w9ydi.execute-api.us-east-1.amazonaws.com/deviceReboot';

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final payload =
        json.encode({'deviceId': deviceId, 'message': 'Reboot Device'});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: payload);

      if (response.statusCode == 200) {
        result = '1';
        print('Reboot request sent successfully');
      } else {
        result = '2';
        print(
            'Failed to send reboot request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      result = '3';
      print('Error occurred while sending reboot request: $e');
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (result == '1' && status == "active") {
          return AlertDialog(
            title: const Center(
                child: Text(
              "Reboot request sent successfully",
              style: TextStyle(color: Color.fromARGB(255, 13, 77, 15)),
            )),
          );
        } else {
          return AlertDialog(
            title: const Center(
                child: Text(
              "Failed to send reboot request",
              style: TextStyle(color: Color.fromARGB(255, 188, 29, 18)),
            )),
          );
        }
      },
    );
  }

  Future<void> sleepDevice(String type, String deviceId, int time) async {
    String result = " ";
    const url =
        'https://9905c6492h.execute-api.us-east-1.amazonaws.com/sleepDevice-V1';

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final payload = json
        .encode({'type': '1', 'deviceId': deviceId, 'time': time.toString()});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: payload);

      if (response.statusCode == 200) {
        result = '1';
        print('Sleep request sent successfully');
      } else {
        result = '2';
        print(
            'Failed to send sleep request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      result = '3';
      print('Error occurred while sending sleep request: $e');
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (result == '1') {
          return AlertDialog(
            title: const Center(
              child: Text(
                "Sleep request sent successfully",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          );
        } else {
          return AlertDialog(
            title: const Center(
              child: Text(
                "Failed to send sleep request",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _showDurationPicker() async {
    final int? selectedDuration = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Duration'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                const Text('Enter the sleep duration:'),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      prefixIcon: const Icon(Icons.calendar_month),
                      labelStyle: const TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(2000), // allow to choose before today.
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.green,
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor:
                                      Colors.black, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        // DateFormat('dd-MM-yyyy').format(pickedDate);

                        setState(() {
                          dateController.text = formattedDate;
                          // print(dateController.text);
                        });
                      } else {
                        // print("Date is not selected");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextField(
                    controller: timeinput,
                    decoration: InputDecoration(
                      labelText: 'Select Time',
                      prefixIcon: const Icon(Icons.calendar_month),
                      labelStyle: const TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.green,
                                onPrimary: Colors.white,
                                onSurface: Colors.purple,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor:
                                      Colors.black, // button text color
                                ),
                              ),
                            ),
                            // child: child!,
                            child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? Container(),
                            ),
                          );
                        },
                      );

                      if (pickedTime != null) {
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());

                        String formattedTime =
                            DateFormat('HH:mm:ss').format(parsedTime);

                        setState(() {
                          timeinput.text = formattedTime;
                          // print(timeinput.text);
                        });
                      } else {
                        // print("Time is not selected");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(sleepDuration);
              },
            ),
          ],
        );
      },
    );

    if (selectedDuration != null) {
      sleepDevice('type', 'deviceID', selectedDuration);
    }
  }

  Future<void> modeDevice(String deviceId, String status) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Action'),
          content: Text('Choose an option:'),
          actions: [
            TextButton(
              child: Text('Reboot', style: TextStyle(color: Colors.green)),
              onPressed: () {
                rebootDevice('$deviceId', '$status');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sleep', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                _showDurationPicker();
              },
            ),
          ],
        );
      },
    );
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
              Text('Lab DATA')
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
                            'POWER',
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
                                  modeDevice(
                                      // values: [],
                                      filterData[i].deviceId,
                                      filterData[i].status);
                                },
                                icon: const Icon(
                                  Icons.power_settings_new,
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
