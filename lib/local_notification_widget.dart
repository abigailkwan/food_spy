import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_spy/local_notifications_helper.dart';
import 'testPage.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() => _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    final settingsAndroid = AndroidInitializationSettings('flutter_logo');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(payload));

    notifications.initialize(
      InitializationSettings(settingsAndroid, settingsIOS),
      onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
    context, MaterialPageRoute(builder: (context) => testPage(payload: payload)),
  );

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView(
      children: <Widget> [
        RaisedButton(
          child: Text('Show Notification'),
          onPressed: () => showOngoingNotification(notifications, title: 'Title', body: 'Body')
        )
      ]
    )
  );
}