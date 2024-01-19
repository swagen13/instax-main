import 'package:flutter/material.dart';
import 'package:instax/screens/authentication/otp_screen.dart';

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({super.key});

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Add this line
          children: [
            const SizedBox(height: 150),
            const Text("ยืนยันเบอร์โทร",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 5),
            const Text("เพื่อปกป้องบัญชีและเพื่อยืนยันตัวตนของคุณ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                )),
            const SizedBox(height: 50),
            const Text("เบอร์โทรศัพท์",
                style: TextStyle(color: Colors.black, fontSize: 17)),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(
                  color: Color.fromARGB(255, 34, 34, 34), fontSize: 16),
              decoration: InputDecoration(
                hintText: '08X-XXXXXXX',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius as needed
                  borderSide: const BorderSide(
                    color: Colors.grey, // Customize the border color
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // navigation to login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const OTPScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 34, 82, 255),
                minimumSize: const Size(350, 45),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                ),
                alignment: Alignment.center,
              ),
              child: const Text('ดำเนินการต่อ',
                  style: TextStyle(fontSize: 17, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
