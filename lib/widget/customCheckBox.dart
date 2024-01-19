import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String value;
  final String? selectedValue;
  final Function(String?) onTap;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(0),
        onTap: () {
          onTap(value);
        },
        title: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Color.fromARGB(255, 207, 207, 207),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: selectedValue == value
                          ? Color.fromRGBO(0, 86, 210, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: selectedValue == value
                            ? Color.fromRGBO(0, 86, 210, 1)
                            : const Color.fromARGB(255, 207, 207, 207),
                        width: 2,
                      ),
                    ),
                    child: selectedValue == value
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  )
                ],
              ),
            )));
  }
}
