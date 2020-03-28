import 'package:flutter/material.dart';
import 'local_notifications_helper.dart';
import 'local_notification_widget.dart';
import 'services.dart';
class settingsPage extends StatefulWidget {

 @override
 settingsPageState createState() => settingsPageState();
}

class settingsPageState extends State<settingsPage> {

  @override
  Widget build(BuildContext context) => Container(
    child: ListView(
      children: <Widget>[
        RaisedButton(
          child: Text("Wipe all Data"),
          onPressed: () => deleteAll(),
        ),
      ],
    )
  );

}