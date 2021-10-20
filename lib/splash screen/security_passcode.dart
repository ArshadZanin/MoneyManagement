// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:money_management/color/app_color.dart' as app_color;
import 'package:money_management/db/database_passcode.dart';
import 'package:money_management/home.dart';

class SecurityPasscode extends StatefulWidget {
  const SecurityPasscode({Key? key}) : super(key: key);

  @override
  _SecurityPasscodeState createState() => _SecurityPasscodeState();
}

class _SecurityPasscodeState extends State<SecurityPasscode> {
  DatabaseHandlerPasscode handler = DatabaseHandlerPasscode();

  Future<bool?>? getBoolValuesSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    final bool? boolValue = prefs.getBool('boolValue');
    debugPrint('in sp value : $boolValue');
    return boolValue;
  }

  Future<String?>? getStringValuesSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    final String? stringValue = prefs.getString('stringValue');
    debugPrint('passcode in sp : $stringValue');
    return stringValue;
  }

  int count = 0;
  String passcode = '';
  bool check = false;
  String passcodeFromDb = '';

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().whenComplete(() async {
      check = (await getBoolValuesSF())!;
    });
    SharedPreferences.getInstance().whenComplete(() async {
      passcodeFromDb = (await getStringValuesSF())!;
      debugPrint(passcode);
    });
    if (mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
  }

  @Deprecated('message')
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_color.back,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Passcode',
            style: TextStyle(color: app_color.text, fontSize: 33),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              count >= 1
                  ? const Icon(Icons.circle)
                  : const Icon(Icons.circle_outlined),
              const SizedBox(
                width: 5,
              ),
              count >= 2
                  ? const Icon(Icons.circle)
                  : const Icon(Icons.circle_outlined),
              const SizedBox(
                width: 5,
              ),
              count >= 3
                  ? const Icon(Icons.circle)
                  : const Icon(Icons.circle_outlined),
              const SizedBox(
                width: 5,
              ),
              count >= 4
                  ? const Icon(Icons.circle)
                  : const Icon(Icons.circle_outlined),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                  onPressed: () {
                    if (count != 4) {
                      if (passcode.length != 4) {
                        passcode = passcode + '1';
                      }
                      setState(() {
                        count++;
                      });
                    }
                  },
                  child: const Text(
                    '1',
                    style: TextStyle(color: app_color.text, fontSize: 33),
                  )),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '2';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '2',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '3';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '3',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '4';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '4',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '5';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '5',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '6';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '6',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '7';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '7',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '8';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '8',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '9';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '9',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {
                  if (passcode.length == 4) {
                    debugPrint('$passcode  $passcodeFromDb');
                    if (passcode == passcodeFromDb) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyHomePage()));
                    } else {
                      setState(() {
                        passcode = '';
                        count = 0;
                      });
                    }
                  }
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 4) {
                    if (passcode.length != 4) {
                      passcode = passcode + '0';
                    }
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Text(
                  '0',
                  style: TextStyle(color: app_color.text, fontSize: 33),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FlatButton(
                onPressed: () {
                  if (count != 0) {
                    setState(() {
                      passcode = passcode.substring(0, passcode.length - 1);
                      debugPrint(passcode);
                      count--;
                    });
                  }
                },
                child: const Icon(Icons.backspace),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
