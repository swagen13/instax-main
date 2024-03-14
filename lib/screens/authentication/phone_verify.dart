// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_event.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_state.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/widget/customButton.dart';

class PhoneVerify extends StatelessWidget {
  const PhoneVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
          listener: (context, state) {
            if (state.status == PhoneNumberStatus.success &&
                // ignore: unnecessary_null_comparison
                state.verificationId != null) {
              // router to otp screen
              Navigator.pushNamed(context, 'otp_screen');
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                Text("ยืนยันเบอร์โทร",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displayLarge?.fontSize,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 5),
                Text("เพื่อปกป้องบัญชีและเพื่อยืนยันตัวตนของคุณ",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    )),
                const SizedBox(height: 50),
                Text("เบอร์โทรศัพท์",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize)),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    context
                        .read<PhoneNumberBloc>()
                        .add(UpdatePhoneNumber(value));
                  },
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
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
                    print(state.phoneNumber);
                    // format phone number for +66
                    final String formattedPhoneNumber =
                        formatPhoneNumber(state.phoneNumber);

                    print(formattedPhoneNumber);

                    context.read<PhoneNumberBloc>().add(PhoneVerifyRequired(
                          formattedPhoneNumber,
                        ));
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

  String formatPhoneNumber(String phoneNumber) {
    final String formattedPhoneNumber = phoneNumber.replaceAll('-', '');
    return '+66' + formattedPhoneNumber.substring(1);
  }
}
