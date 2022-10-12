import 'package:flutter/material.dart';
import 'package:alarm_project/pages/home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initNotiSetting();

  runApp(const MyApp());
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void _initNotiSetting() async {
  const initializationSettingsAndriod =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // const initializationSettingsIOS = IOSInitializationSettings(
  //   requestAlertPermission: false,
  //   requestBadgePermission: false,
  //   requestSoundPermission: false,
  // );

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndriod,
    // iOS: initializationSettingsIOS,
  );

  final result = await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  print(result);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
