import 'dart:io';
import 'package:alarm_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showToast();
              },
              child: const Text('btn'),
            ),
            ElevatedButton(
              onPressed: () async {
                final notification = flutterLocalNotificationsPlugin;

                const android = AndroidNotificationDetails(
                  '0',
                  '알림 테스트',
                  channelDescription: '알림 테스트 바디 부분',
                  importance: Importance.max,
                  priority: Priority.max,
                );
                // const ios = IOSNotificationDetails();
                const detail = NotificationDetails(
                  android: android,
                  // iOS: ios,
                );

                final permission = Platform.isAndroid
                    ? true
                    : ((await notification
                            .resolvePlatformSpecificImplementation<
                                IOSFlutterLocalNotificationsPlugin>()
                            ?.requestPermissions(
                                alert: true, badge: true, sound: true)) ??
                        false);
                if (!permission) {
                  // await showNotiPermissionDialog(context);
                  // return toast 권한이 없습니다.
                  return;
                }

                // print('permission $permission');

                // await flutterLocalNotificationsPlugin.show(
                //   0,
                //   'plain title',
                //   'plain body',
                //   detail,
                // );
                // 타임존 셋팅 필요
                final now = tz.TZDateTime.now(tz.local);
                // var notiDay = now.day;

                // 예외처리
                // if (now.hour > hour || now.hour == hour && now.minute >= minute) {
                //   notiDay = notiDay + 1;
                // }
                await notification.zonedSchedule(
                  1,
                  'alarmtitle',
                  'alarmDescription',
                  tz.TZDateTime(
                    tz.local,
                    now.year,
                    now.month,
                    now.day,
                    now.hour,
                    now.minute + 1,
                  ),
                  detail,
                  androidAllowWhileIdle: true,
                  uiLocalNotificationDateInterpretation:
                      UILocalNotificationDateInterpretation.absoluteTime,
                  matchDateTimeComponents: DateTimeComponents.time,
                );
              },
              child: const Text('add alarm'),
            ),
            const Center(child: Text('hi')),
          ],
        ),
      ),
    );
  }

  void _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 5),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 100.0,
            left: 50.0,
          );
        });
  }
}
