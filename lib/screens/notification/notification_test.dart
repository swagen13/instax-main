import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // custom overlay notification for user image, title and body
            InAppNotification.show(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Text(
                      'Notification Title',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Notification Body',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              context: context,
              onTap: () {
                print('Notification tapped');
              },
            );
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}
