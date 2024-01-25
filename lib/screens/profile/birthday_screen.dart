import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_state.dart';
import 'package:instax/widget/customButton.dart';
import 'package:instax/widget/customTextField.dart';
import 'package:instax/widget/switchThemeColor.dart';

class BirthDateScreen extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  BirthDateScreen({super.key});

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
          return Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'วันเกิด',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDayPicker(context);
                      },
                      child: Container(
                        width: 80, // Set the desired width
                        child: CustomTextField(
                          controller: _dateController,
                          hintText: '',
                          prefixText: 'วัน',
                          isDisabled: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showMonthPicker(context);
                      },
                      child: Container(
                        width: 100, // Set the desired width
                        child: CustomTextField(
                          controller: _monthController,
                          hintText: '',
                          prefixText: 'เดือน',
                          isDisabled: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showYearPicker(context);
                      },
                      child: Container(
                        width: 100, // Set the desired width
                        child: CustomTextField(
                          controller: _yearController,
                          hintText: '',
                          prefixText: 'ปี',
                          isDisabled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "วันเกิดของคุณจะไม่ถูกแสดงในสาธารณะ เราจะแสดงแค่อายุของคุณสำหรับใช้ในการสมัครงานเท่านั้น",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    onPressed: () {
                      // create date format
                      String date = _dateController.text;
                      String month = _monthController.text;
                      String year = _yearController.text;
                      String birthDate = "$date/$month/$year";
                      state.myUser.birthDate = birthDate;
                      context.read<MyUserBloc>().add(UpdateMyUser(
                            myUser: state.myUser,
                          ));
                    },
                    text: "ดำเนินการต่อ"),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'name');
                      },
                      child: const Text(
                        "ข้ามไปก่อน",
                        style: TextStyle(fontSize: 16),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _showMonthPicker(BuildContext context) {
    final List<String> thaiMonthNames = [
      'ม.ค.',
      'ก.พ.',
      'มี.ค.',
      'เม.ย.',
      'พ.ค.',
      'มิ.ย.',
      'ก.ค.',
      'ส.ค.',
      'ก.ย.',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: thaiMonthNames.length,
            padding: EdgeInsets.symmetric(
                vertical: 20), // Adjust the padding as needed
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text(thaiMonthNames[index])),
                onTap: () {
                  _monthController.text = thaiMonthNames[index];
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showDayPicker(BuildContext context) {
    // Implement your custom day picker
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: 31,
            padding: EdgeInsets.symmetric(
                vertical: 20), // Adjust the padding as needed
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text((index + 1).toString())),
                onTap: () {
                  _dateController.text = (index + 1).toString();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showYearPicker(BuildContext context) {
    // Implement your custom year picker
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: 42,
            padding: EdgeInsets.symmetric(
                vertical: 20), // Adjust the padding as needed
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(
                  child: Text((1980 + index).toString()),
                ),
                onTap: () {
                  _yearController.text = (1980 + index).toString();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
