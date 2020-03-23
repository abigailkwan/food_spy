import 'package:flutter/material.dart';
import 'local_notifications_helper.dart';
import 'local_notification_widget.dart';

class settingsPage extends StatefulWidget {

 @override
 settingsPageState createState() => settingsPageState();
}

class settingsPageState extends State<settingsPage> {


  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: LocalNotificationWidget(),
    )
  );

}