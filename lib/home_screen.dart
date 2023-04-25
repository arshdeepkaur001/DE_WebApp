import 'dart:convert';
import 'package:detest/Inferenced_Data.dart';
import 'package:http/http.dart' as http;
import 'package:detest/device_screen.dart';
import 'package:detest/login.dart';
import 'package:detest/text_input_field.dart';
import 'package:flutter/material.dart';
import 'config_screen.dart';
import 'constant.dart';
import 'package:detest/weatherData.dart';
import 'package:detest/insectCount.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String> response;
  late TextEditingController _serialId;
  late TextEditingController _securityKey;
  bool _hovering = false;
  @override
  void initState() {
    response = getData(widget.email);
    _serialId = TextEditingController();
    _securityKey = TextEditingController();
    super.initState();
    print("Vanshu was here");
  }

  @override
  void dispose() {
    _serialId.dispose();
    _securityKey.dispose();
    super.dispose();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Register a new Device ',
            style: TextStyle(color: buttonColor),
          )),
          content: SizedBox(
            height: 140,
            width: 400,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    initalvalue: 'D0999',
                    controller: _serialId,
                    labelText: 'Device ID',
                    icon: Icons.devices,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    initalvalue: '1234',
                    controller: _securityKey,
                    labelText: 'Serial ID',
                    icon: Icons.devices,
                    // isObscure: true,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              textColor: Colors.white,
              color: Colors.red,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              textColor: Colors.white,
              color: buttonColor,
              child: const Text('Register'),
              onPressed: () {
                RegistrationUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future RegistrationUser() async {
    var APIURL = Uri.parse(
        "https://uo1t934012.execute-api.us-east-1.amazonaws.com//addNewDevice");
    Map mapeddate = {
      'device_id': _serialId.text,
      'serial_id': _securityKey.text,
      'email': widget.email
    };
    String requestBody = jsonEncode(mapeddate);
    // print("JSON DATA: ${requestBody}");
    http.Response response = await http.post(APIURL, body: requestBody);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data.toString()),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      throw Exception('Failed to load api');
    }
  }

  // Future<void> Delete_device(String deviceId) async {
  //   final url = Uri.https(
  //     'z29tdyfh2h.execute-api.us-east-1.amazonaws.com',
  //     '/remove/remove-device',
  //     {
  //       'deviceid': deviceId,
  //     },
  //   );
  //   final response = await http.get(url);
  //   var decoded = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     print(decoded);
  //     print(decoded['body']['message']);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(decoded['body']['message']),
  //         duration: Duration(seconds: 3),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   } else {
  //     throw Exception('Failed to load api');
  //   }
  // }

  // Future<void> _dialogbox(BuildContext context, String device_id) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Center(
  //             child: Text(
  //           'Are you sure!! You want to DELETE?? ',
  //           style: TextStyle(color: buttonColor),
  //         )),
  //         actions: <Widget>[
  //           MaterialButton(
  //             textColor: Colors.white,
  //             color: Colors.red,
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           MaterialButton(
  //             textColor: Colors.white,
  //             color: buttonColor,
  //             child: const Text('Delete'),
  //             onPressed: () {
  //               Delete_device(device_id);
  //               Navigator.of(context).pop();
  //               // },
  //               // Delete_device(
  //               //   'deviceid':$
  //               // );
  //               // Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
// {email: milanpreetkaur502@gmail.com, serialID: D0314, deviceBooted: true, deviceProvisoned: true}
//change check
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: Row(
          children: [
            const Icon(
              Icons.dashboard,
              size: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Biodiversity Sensor Console')
          ],
        ),
        // centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20, top: 8, bottom: 10),
        //     child: ElevatedButton.icon(
        //       onPressed: () {
        //         Navigator.of(context).pushReplacement(
        //             MaterialPageRoute(builder: (context) => const Login()));
        //         setState(() {
        //           // deviceData = [];
        //         });
        //       },
        //       // icon: const Icon(
        //       //   Icons.logout,
        //       //   color: backgroundColor,
        //       // ),
        //       // label: const Text(
        //       //   'LOG OUT',
        //       //   style: TextStyle(fontWeight: FontWeight.bold),
        //       // ),
        //       // style: ElevatedButton.styleFrom(
        //       //     // elevation: 10,
        //       //     backgroundColor: Colors.white10),
        //     ),
        //   )
        // ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: 'btn3',
          backgroundColor: buttonColor,
          onPressed: () => _dialogBuilder(context),
          label: const Text('Register a new Device +')),
      body: FutureBuilder<String>(
        future: response,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == '200') {
              // print(data);
              return ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Table(
                          columnWidths: const {
                            0: FractionColumnWidth(0.10),
                            1: FractionColumnWidth(0.10),
                            2: FractionColumnWidth(0.10),
                            3: FractionColumnWidth(0.10),
                            4: FractionColumnWidth(0.10),
                            5: FractionColumnWidth(0.10),
                            6: FractionColumnWidth(0.10),
                            7: FractionColumnWidth(0.10),
                            8: FractionColumnWidth(0.10),
                            9: FractionColumnWidth(0.01),
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
                                  'REGISTERED',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: backgroundColor),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'CONFIGURE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: backgroundColor),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'DOWNLOAD',
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
                              Center(
                                child: Text(
                                  'Motion Count',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: backgroundColor),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Insect Count',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: backgroundColor),
                                ),
                              ),
                              // Center(
                              //   child: Text(
                              //     '',
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 16,
                              //         color: backgroundColor),
                              //   ),
                              // ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < deviceData.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.10),
                              1: FractionColumnWidth(0.10),
                              2: FractionColumnWidth(0.10),
                              3: FractionColumnWidth(0.10),
                              4: FractionColumnWidth(0.10),
                              5: FractionColumnWidth(0.10),
                              6: FractionColumnWidth(0.10),
                              7: FractionColumnWidth(0.10),
                              8: FractionColumnWidth(0.10),
                              9: FractionColumnWidth(0.01),
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
                                      deviceData[i].deviceId,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      deviceData[i].status,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '${deviceData[i].registerStatus}',
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
                                        // print('CONFIGURE');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ConfigScreen(
                                              deviceId: deviceData[i].deviceId,
                                              userName: widget.email,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.settings,
                                        color: backgroundColor,
                                      ),
                                      // label: const Text('CONFIGURE'),
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
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => DeviceScreen(
                                              deviceId: deviceData[i].deviceId,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.download,
                                        color: backgroundColor,
                                      ),
                                      // label: const Text('DOWNLOAD'),
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
                                            builder: (_) => Weather(
                                              // values: [],
                                              deviceId: deviceData[i].deviceId,
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
                                        // print('Insect');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => Insects(
                                              // values: [],
                                              deviceId: deviceData[i].deviceId,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.bug_report_rounded,
                                        color: backgroundColor,
                                      ),
                                      // label: const Text('InsectCount Data'),
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
                                              deviceId: deviceData[i].deviceId,
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
                                // SizedBox(
                                //   height: 40,
                                //   child: Center(
                                //     child: Tooltip(
                                //         message: "Delete",
                                //         child: MouseRegion(
                                //           onEnter: (_) {
                                //             setState(() {
                                //               _hovering = true;
                                //             });
                                //           },
                                //           onExit: (_) {
                                //             setState(() {
                                //               _hovering = false;
                                //             });
                                //           },
                                //           child: _hovering
                                //               ? IconButton(
                                //                   onPressed: () => _dialogbox(
                                //                       context,
                                //                       deviceData[i].deviceId),
                                //                   icon: const Icon(
                                //                     Icons.close,
                                //                     color: backgroundColor,
                                //                   ),
                                //                   style:
                                //                       ElevatedButton.styleFrom(
                                //                           backgroundColor:
                                //                               Colors.white10),
                                //                 )
                                //               : null,
                                //         )),
                                //     // child: IconButton(
                                //     //   onPressed: () => _dialogbox(context),
                                //     //   icon: const Icon(
                                //     //     Icons.delete,
                                //     //     color: backgroundColor,
                                //     //   ),
                                //     //   style: ElevatedButton.styleFrom(
                                //     //       backgroundColor: Colors.white10),
                                //     // ),
                                //   ),
                                // )
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }
            return Container();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        }),
      ),
    );
  }
}
