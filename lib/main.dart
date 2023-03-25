import 'dart:async';

import 'package:chess_clock_app/constants/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    selectedVal = durations[0];
  }

  bool isActiveUp = true;
  bool isActiveBottom = false;
  late Timer timer1;
  late Timer timer2;

  int time1 = 10;
  int time2 = 10;

  bool isFinished1() {
    late bool flag1;
    setState(() {
      flag1 = time1 == 0 ? true : false;
    });
    return flag1;
  }

  bool isFinished2() {
    late bool flag2;
    setState(() {
      flag2 = time2 == 0 ? true : false;
    });
    return flag2;
  }

  void startCount1() {
    timer1 = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (time1 >= 0) {
          setState(() {
            time1>0?time1--:timer1.cancel();
          });
        } else {
          setState(() {
            timer.cancel();
          });
        }
      },
    );
  }

  void startCount2() {
    timer2 = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (time2 >= 0) {
          setState(() {
            time2>0? time2--:timer2.cancel();
          });
        } else {
          setState(() {
            timer.cancel();
          });
        }
      },
    );
  }

  void pause1() {
    setState(() {
      timer1.cancel();
    });
  }

  void pause2() {
    setState(() {
      timer2.cancel();
    });
  }

  void restart1() {
    setState(() {
      time1 = 10;
    });
  }

  void restart2() {
    setState(() {
      time2 = 10;
    });
  }

  List durations = [60, 120, 300, 600];
  int? selectedVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess clock'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    startCount2();
                    pause1();
                    isActiveBottom = true;
                    isActiveUp = false;
                  },
                  child: Container(
                    color: isActiveUp
                        ? (isFinished1() ? Colors.redAccent : activeColor)
                        : notActiveColor,
                    child: Center(
                      child: Text(
                        time1.toString(),
                        style: upperContainerStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 5.0),
                      color: Colors.yellowAccent,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        pause1();
                        pause2();
                      },
                      child: const Icon(
                        Icons.pause,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 5.0),
                      color: Colors.yellowAccent,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        restart1();
                        restart2();
                      },
                      child: const Icon(
                        Icons.restart_alt_outlined,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton(
                    items: durations.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e seconds'),
                        );
                      },
                    ).toList(),
                    value: selectedVal,
                    onChanged: (value) {
                      setState(() {
                        selectedVal = value as int?;
                        time2 = selectedVal!;
                        time1 = selectedVal!;
                      });
                    },
                    iconSize: 100,
                  ),
                ],
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    startCount1();
                    pause2();
                    isActiveBottom = false;
                    isActiveUp = true;
                  },
                  child: Container(
                    color: isActiveBottom
                        ? (isFinished2() ? Colors.redAccent : activeColor)
                        : notActiveColor,
                    child: Center(
                      child: Text(
                        time2.toString(),
                        style: lowerContainerStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
