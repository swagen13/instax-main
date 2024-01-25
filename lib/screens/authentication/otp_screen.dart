import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_state.dart';
import 'package:instax/providers/temporary_otp_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);

  int _countdown = 5; // Initialize with your countdown value
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: BlocBuilder<OTPBloc, OTPState>(
          builder: (context, state) {
            if (state.status == OTPStatus.initial) {
              startCountdown(context);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Text("เปลี่ยนหมายเลขโทรศัพท์",
                    style: TextStyle(
                      color: Color.fromARGB(255, 34, 82, 255),
                      fontSize: 15,
                    )),
                const SizedBox(height: 50),
                Consumer<TemporaryOTPProvider>(
                  builder: (context, otpProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: SizedBox(
                            width: 50,
                            child: TextField(
                              onChanged: (value) {
                                otpProvider.setOTPText(value);
                                if (value.isNotEmpty && index < 5) {
                                  otpProvider.focusNodes[index + 1]
                                      .requestFocus();
                                }
                                if (value.isEmpty && index > 0) {
                                  otpProvider.focusNodes[index - 1]
                                      .requestFocus();
                                }
                              },
                              onEditingComplete: () {
                                // Move to the next field when pressing Enter on the keyboard
                                if (index < 5) {
                                  otpProvider.focusNodes[index + 1]
                                      .requestFocus();
                                }
                              },
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 24),
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              focusNode: otpProvider.focusNodes[index],
                              decoration: const InputDecoration(
                                counterText: '',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                    child: Column(
                  children: [
                    const Text(
                      "คุณสามารถส่งรหัสยืนยันได้อีกครั้ง",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Consumer<TemporaryCounterProvider>(
                      builder: (context, counterProvider, child) {
                        return counterProvider.countdown == 0
                            ? GestureDetector(
                                onTap: () {
                                  print("Send OTP again");
                                  counterProvider.resetCountdown();
                                  startCountdown(context);
                                },
                                child: const Text(
                                  "ส่งรหัสยืนยันอีกครั้ง",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 34, 82, 255),
                                  ),
                                ),
                              )
                            : Visibility(
                                visible: counterProvider.countdown > 0
                                    ? true
                                    : false,
                                child: Text(
                                  "ในอีก ${formatTime(counterProvider.countdown)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 300,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, 'gender');
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                        label: const Text("ถัดไป"))
                  ],
                )),
              ],
            );
          },
        ),
      ),
    );
  }

  void startCountdown(BuildContext context) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        final temporaryCounterProvider =
            context.read<TemporaryCounterProvider>();
        if (temporaryCounterProvider.countdown == 0) {
          timer.cancel();
        } else {
          temporaryCounterProvider.CounterProvider();
        }
      },
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}
