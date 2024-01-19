import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instax/widget/otptextfield.dart';
import 'package:instax/screens/profile/gender_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int _countdown = 5; // Initialize with your countdown value
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_countdown > 0) {
            _countdown--;
            formatTime(_countdown);
          } else {
            _timer.cancel();
          }
        });
      } else {
        _timer.cancel(); // Cancel the timer if the widget is disposed
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Add this line
          children: [
            const SizedBox(height: 150),
            const Text("ยืนยันรหัส",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 5),
            const Text("ใส่รหัสยืนยัน 6 หลักที่ได้รับจาก SMS",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                )),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Text("เปลี่ยนหมายเลขโทรศัพท์",
                  style: TextStyle(
                    color: Color.fromARGB(255, 34, 82, 255),
                    fontSize: 15,
                  )),
            ),
            const SizedBox(height: 50),
            OtpTextField(
              length: 6,
              onCompleted: (value) {
                log("value: " + value);
              },
            ),
            const SizedBox(height: 50),
            Center(
                child: Column(
              children: [
                Text(
                  "คุณสามารถส่งรหัสยืนยันได้อีกครั้ง",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  child: Text(
                    "ในอีก ${formatTime(_countdown)}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  visible: _countdown > 0 ? true : false,
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  child: TextButton(
                    onPressed: () {
                      _countdown = 5;
                      startCountdown();
                    },
                    child: Text(
                      "ส่งรหัสยืนยันอีกครั้ง",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 34, 82, 255),
                      ),
                    ),
                  ),
                  visible: _countdown == 0 ? true : false,
                ),
                SizedBox(
                  height: 300,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      // navigate to the next screen
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenderScreen()));
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                    label: Text("ถัดไป"))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
