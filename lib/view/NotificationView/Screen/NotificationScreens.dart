import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RemoteMessage message =
        ModalRoute.of(context)?.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Text('Notification Data: ${message.notification?.title}'),
      ),
    );
  }
}
