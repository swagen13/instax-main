import 'package:flutter/material.dart';

class OtpTextField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;

  const OtpTextField({
    Key? key,
    required this.length,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );

    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < widget.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });

      // Handle backspace/delete
      _focusNodes[i].addListener(() {
        if (!_focusNodes[i].hasFocus && _controllers[i].text.isEmpty && i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.length; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: 50.0,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) {
              if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
        ),
      ),
    );
  }
}
