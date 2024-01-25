import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_state.dart';
import 'package:instax/widget/customButton.dart';
import 'package:instax/widget/customTextField.dart';
import 'package:instax/widget/switchThemeColor.dart';

class DisplayNameScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  DisplayNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          SwitchThemeColor(),
        ],
      ),
      body: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
          // Initialize the _nameController text with the value from state.myUser.name
          if (_nameController.text.isEmpty) {
            _nameController.text = state.myUser.name;
          }

          return Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'ชื่อเล่น',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text("ชื่อเล่นของคุณที่ใช้ใน App ของเรา",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                CustomTextField(
                  controller: _nameController,
                  hintText: '',
                  prefixText: '',
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    // Update the name using a method in MyUserBloc
                    context.read<MyUserBloc>().add(
                          UpdateMyUser(
                            myUser: state.myUser.copyWith(
                              name: _nameController.text,
                            ),
                          ),
                        );
                  },
                  text: "ดำเนินการต่อ",
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'image');
                    },
                    child: const Text(
                      "ข้ามไปก่อน",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
