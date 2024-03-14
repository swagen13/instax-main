import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_state.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/providers/temporary_gender_provider.dart';
import 'package:instax/widget/customButton.dart';
import 'package:instax/widget/customCheckBox.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'))
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
                    Text(
                      "เพศ",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.fontSize,
                          fontWeight: FontWeight.bold),
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
                      text: "ดำเนินการต่อ",
                      onPressed: () {
                        context.read<MyUserBloc>().add(
                              UpdateMyUser(
                                myUser: state.myUser.copyWith(
                                  gender:
                                      temporaryGenderProvider.selectedGender,
                                ),
                              ),
                            );
                        Navigator.pushNamed(context, 'birthday');
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'birthday');
                          },
                          child: Text(
                            "ข้ามไปก่อน",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                                color: Colors.black),
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
