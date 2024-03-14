import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_event.dart';
import 'package:instax/blocs/otp_bloc/otp_state.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/providers/temporary_otp_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OTPVerify extends StatelessWidget {
  OTPVerify({Key? key}) : super(key: key);

// Initialize with your countdown value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.authenticated &&
                    state.user?.providerData[0].providerId == 'facebook.com') {
                  Navigator.pushNamed(context, 'linking_account');
                } else {
                  Navigator.pushNamed(context, 'gender');
                }
              },
              builder: (context, state) {
                return BlocBuilder<OTPBloc, OTPState>(
                  builder: (context, optState) {
                    if (optState.status == OTPStatus.initial) {
                      startCountdown(context);
                    }
                    return Consumer<TemporaryOTPProvider>(
                        builder: (context, otpProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 150),
                          Text("ยืนยันรหัส",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.fontSize,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 5),
                          Text("ใส่รหัสยืนยัน 6 หลักที่ได้รับจาก SMS",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                              )),
                          const SizedBox(height: 5),
                          Text("เปลี่ยนหมายเลขโทรศัพท์",
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 82, 255),
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                              )),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: SizedBox(
                                  width: 50,
                                  child: TextField(
                                    onChanged: (value) {
                                      otpProvider.setOTPText(value, index);
                                      if (value.isNotEmpty && index < 5) {
                                        otpProvider.focusNodes[index + 1]
                                            .requestFocus();
                                      }
                                      if (value.isEmpty && index > 0) {
                                        otpProvider.focusNodes[index - 1]
                                            .requestFocus();
                                      }
                                      context
                                          .read<OTPBloc>()
                                          .add(UpdateOTP(value));
                                    },
                                    onEditingComplete: () {
                                      // Move to the next field when pressing Enter on the keyboard
                                      if (index < 5) {
                                        otpProvider.focusNodes[index + 1]
                                            .requestFocus();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.fontSize),
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    focusNode: otpProvider.focusNodes[index],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                          Center(
                              child: Column(
                            children: [
                              Text(
                                "คุณสามารถส่งรหัสยืนยันได้อีกครั้ง",
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.fontSize,
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
                                          child: Text(
                                            "ส่งรหัสยืนยันอีกครั้ง",
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.fontSize,
                                              color: Color.fromARGB(
                                                  255, 34, 82, 255),
                                            ),
                                          ),
                                        )
                                      : Visibility(
                                          visible: counterProvider.countdown > 0
                                              ? true
                                              : false,
                                          child: Text(
                                            "ในอีก ${formatTime(counterProvider.countdown)}",
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.fontSize,
                                            ),
                                          ),
                                        );
                                },
                              ),
                              const SizedBox(
                                height: 300,
                              ),
                              BlocBuilder<SignInBloc, SignInState>(
                                builder: (context, userState) {
                                  return ElevatedButton.icon(
                                      onPressed: () {
                                        context.read<SignInBloc>().add(
                                              MultiFactorVerification(
                                                  otpProvider.otpText),
                                            );
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios),
                                      label: const Text("ถัดไป"));
                                },
                              )
                            ],
                          )),
                        ],
                      );
                    });
                  },
                );
              },
            )),
      ),
    );
  }

  void startCountdown(BuildContext context) {}

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}
