import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = const Color.fromARGB(255, 34, 82, 255),
  }) : super(key: key);

  CustomButton copyWith({
    VoidCallback? onPressed,
    String? text,
    Color? color,
  }) {
    return CustomButton(
      onPressed: onPressed ?? this.onPressed,
      text: text ?? this.text,
      color: color ?? this.color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }
}
