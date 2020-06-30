import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  ///Flutter Local Notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String notifyTime = "your time";
  String nHour = "";
  String nMinutes = "";
  String nSeconds = "";

  @override
  initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future scheuleAtParticularTime(DateTime timee) async {
    var time = Time(timee.hour, timee.minute, timee.second);

    print(time.toString());
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.showDailyAtTime(0, 'Hey! Check your',
        'Login now to finish your quiz', time, platformChannelSpecifics);
    print('scheduled');
    setState(() {
      nHour = time.hour.toString();
      nMinutes = time.minute.toString();
      nSeconds = time.second.toString();
      notifyTime = nHour + " : " + nMinutes + " : " + nSeconds;
    });
  }

  //function ends
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text(
            'Notification time - $notifyTime',
            style: TextStyle(
              color: Color(0xff6200ee),
            ),
          ),
          onPressed: () {
            DatePicker.showTimePicker(context, showTitleActions: true,
                onChanged: (date) {
              print('change $date');
            }, onConfirm: (date) {
              print('confirm $date');
              scheuleAtParticularTime(DateTime.fromMillisecondsSinceEpoch(
                  date.millisecondsSinceEpoch));
            }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
        ),
      ),
    );
  }
}
