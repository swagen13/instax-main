import 'package:flutter/material.dart';
import 'package:instax/widget/customButton.dart';

class MyFormScreen extends StatefulWidget {
  const MyFormScreen({Key? key}) : super(key: key);
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  String _buttonText = 'Submit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              onPressed: () {
                print('Form submitted');
              },
              text: _buttonText,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _buttonText = 'Submit';
                });
              },
              child: const Text('Update Button Properties'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _buttonText = 'Updated Text';
                });
              },
              child: const Text('Update Button Properties'),
            ),
          ],
        ),
      ),
    );
  }
}
