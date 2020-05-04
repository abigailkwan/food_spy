import 'package:flutter/material.dart';
import 'local_notifications_helper.dart';
import 'local_notification_widget.dart';
import 'services.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
class settingsPage extends StatefulWidget {

 @override
 settingsPageState createState() => settingsPageState();
}

class settingsPageState extends State<settingsPage> {

  void changeTheme() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light:Brightness.dark);
  }

   Text changeText() {
    Text display = Theme.of(context).brightness == Brightness.dark ? Text("Light Mode"): Text("Dark Mode");
    return display;
  }

  @override
  Widget build(BuildContext context) => Container(
    child: ListView(
      children: <Widget>[
        RaisedButton(
          child: Text("Wipe all Data"),
          onPressed: () => deleteAll(),
        ),
        RaisedButton(
          child: changeText(),
          onPressed: () => changeTheme(),
        )
  ]
        ),
    );
}