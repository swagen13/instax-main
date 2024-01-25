// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_event.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_state.dart';
import 'package:instax/blocs/theme_bloc/theme_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_event.dart';
import 'package:instax/blocs/theme_bloc/theme_state.dart';
import 'package:instax/widget/customButton.dart';

class PhoneVerify extends StatelessWidget {
  const PhoneVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ยืนยันเบอร์โทร'),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<ThemeBloc>().add(UpdateThemeDataEvent(
                            ThemeData(
                              primaryColor: Colors.blue,
                            ),
                          ));
                    },
                    child: Text('blue'),
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<ThemeBloc>().add(UpdateThemeDataEvent(
                              ThemeData(
                                primaryColor: Colors.yellow,
                              ),
                            ));
                      },
                      child: Text(
                        'yellow',
                      )),
                  const SizedBox(width: 10),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                const Text("ยืนยันเบอร์โทร",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 5),
                const Text("เพื่อปกป้องบัญชีและเพื่อยืนยันตัวตนของคุณ",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                const SizedBox(height: 50),
                const Text("เบอร์โทรศัพท์", style: TextStyle(fontSize: 17)),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    context
                        .read<PhoneNumberBloc>()
                        .add(UpdatePhoneNumber(value));
                  },
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: '08X-XXXXXXX',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'otp_screen');
                  },
                  text: 'ดำเนินการต่อ',
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
