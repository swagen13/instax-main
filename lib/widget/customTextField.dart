import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixText;
  final bool isDisabled;
  final Color bgColor; // Add this property for customizable text color

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixText,
    this.isDisabled = false,
    this.bgColor = Colors.white, // Default text color is black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(prefixText,
            style: const TextStyle(
                color: Colors.black, fontSize: 15)), // Apply text color here
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bgColor,
          ),
          child: TextField(
            controller: controller,
            enabled: !isDisabled,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 34, 82, 255),
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 144, 144, 144),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 144, 144, 144),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}