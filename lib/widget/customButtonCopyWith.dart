// ignore_for_file: file_names
import 'package:flutter/material.dart';

class CustomButtonWrapper extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButtonWrapper({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      text: text,
    );
  }
}

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();

  // Expose a method to update properties
  CustomButton update({
    VoidCallback? onPressed,
    String? text,
  }) {
    return CustomButton(
      onPressed: onPressed ?? this.onPressed,
      text: text ?? this.text,
    );
  }
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('CustomButton State changed: ${widget.text}');
  }

  // CopyWith method to create a new instance with updated properties
  CustomButton copyWith({
    VoidCallback? onPressed,
    String? text,
    Color? color,
  }) {
    return CustomButton(
      onPressed: onPressed ?? widget.onPressed,
      text: text ?? widget.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
      ),
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
