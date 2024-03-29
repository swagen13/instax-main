import 'package:flutter/material.dart';
import 'package:instax/screens/authentication/login_screen.dart';

class OnBoard extends StatelessWidget {
  static const Color backgroundColor = Color(0xFF0056D2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Image(image: AssetImage('assets/images/logo.png')),
            const SizedBox(height: 100),
            Text(
              'ยินดีต้อนรับสู่ปลาวาฬ',
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'ค้นหางานหรือจ้างงาน ฟรีไม่มีค่าใช้จ่าย',
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            ElevatedButton(
              onPressed: () {
                // navigation to login screen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[200],
                minimumSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                ),
              ),
              child: Text(
                'ดำเนินการต่อ',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
