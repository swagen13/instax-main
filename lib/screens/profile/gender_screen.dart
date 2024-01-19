import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_state.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/providers/temporary_gender_provider.dart';
import 'package:instax/widget/customButtonCopyWith.dart';
import 'package:instax/widget/customCheckBox.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<SignInBloc>().add((const SignOutRequired()));
              },
            )
          ],
        ),
        body: BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
          var temporaryGenderProvider =
              Provider.of<TemporaryGenderProvider>(context);

          if (state.status == MyUserStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "คุณเป็น",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomCheckbox(
                      value: "ชาย",
                      selectedValue: temporaryGenderProvider.selectedGender,
                      onTap: (value) {
                        temporaryGenderProvider.setGender(value!);
                      },
                    ),
                    CustomCheckbox(
                      value: "หญิง",
                      selectedValue: temporaryGenderProvider.selectedGender,
                      onTap: (value) {
                        temporaryGenderProvider.setGender(value!);
                      },
                    ),
                    CustomCheckbox(
                      value: "LGBT",
                      selectedValue: temporaryGenderProvider.selectedGender,
                      onTap: (value) {
                        temporaryGenderProvider.setGender(value!);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        state.myUser.gender =
                            temporaryGenderProvider.selectedGender;
                        context.read<MyUserBloc>().add(UpdateMyUser(
                            myUser: state.myUser.copyWith(
                                gender:
                                    temporaryGenderProvider.selectedGender)));
                        Navigator.pushNamed(context, '/birthday');
                      },
                      text: "ดำเนินการต่อ",
                      color: const Color.fromRGBO(0, 86, 210, 1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/birthday');
                          },
                          child: const Text(
                            "ข้ามไปก่อน",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    )
                  ],
                ),
              ),
            );
          } else if (state.status == MyUserStatus.failure) {
            return const Center(
              child: Text('Error , Please try signing in again'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
