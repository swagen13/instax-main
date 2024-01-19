// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class WorkCheckboxes extends StatefulWidget {
  final List<String> availableWorks;
  final Function(List<String>) onSelectionChanged;

  const WorkCheckboxes({
    Key? key,
    required this.availableWorks,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _WorkCheckboxesState createState() => _WorkCheckboxesState();
}

class _WorkCheckboxesState extends State<WorkCheckboxes> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.availableWorks.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              if (selectedValues.contains(widget.availableWorks[index])) {
                selectedValues.remove(widget.availableWorks[index]);
              } else {
                selectedValues.add(widget.availableWorks[index]);
              }

              // Call the callback function to notify the parent about the changes
              widget.onSelectionChanged(selectedValues);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 30, // Customize the checkbox size as needed
                  height: 30, // Customize the checkbox size as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(
                        5.0), // Set your desired border radius
                    color: selectedValues.contains(widget.availableWorks[index])
                        ? Color.fromARGB(255, 34, 82, 255)
                        : Colors.transparent,
                    border: Border.all(
                      color: Color.fromARGB(255, 34, 82, 255),
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: selectedValues.contains(widget.availableWorks[index])
                        ? Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                    width: 8.0), // Adjust spacing between checkbox and title
                Text(
                  widget.availableWorks[index],
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
