import 'package:flutter/material.dart';
import 'package:food_spy/addProfile.dart';
import 'package:food_spy/local_notifications_helper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services.dart';
import 'profilePage.dart';
import 'text_style.dart';
import 'addProfile.dart';
import 'listPage.dart';
import 'cameraAccess.dart';
import 'settingsPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'testPage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          primaryColor: Color.fromRGBO(0, 66, 116, 1.0),
          accentColor: Color.fromRGBO(255, 255, 255, 1.0),
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        home: MyHomePage(title: 'Testing JSON'),
      );
    }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;
  listPage one;
  cameraAccess two;
  addProfile three;
  settingsPage four;
  List<Widget> pages;
  Widget currentPage;
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    one = listPage();
    two = cameraAccess();
    three = addProfile();
    four = settingsPage();
    pages = [one, two, three, four];
    currentPage = one;
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
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
            title: new FutureBuilder(

              future: getTemperatureData(),
              builder: (context, snap){
                if(snap.hasData){
                  int currentTemp = int.parse(snap.data.temp);
                  if(currentTemp >= 4){
                    showOngoingNotification(notifications, title: 'Temperature Alert! Temp is higher than 4C',
                        body: snap.data.temp);
                  }
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${currentTemp}', textAlign: TextAlign.left, textScaleFactor: 2,),
                        Text("°C", textAlign: TextAlign.left, textScaleFactor: 2,),
                      ]
                  );
                }else if (snap.hasError) {
                  print('${snap.error}');
                  return new Text("BlueJay");
                }
                return new CircularProgressIndicator();
              },),

              ),
          body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() { currentTab = index;
            currentPage = pages[index]; });
          },
          items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted),
                                      title: Text('Food List')),
              BottomNavigationBarItem(icon: Icon(Icons.camera_enhance),
                                      title: Text('Add Picture')),
              BottomNavigationBarItem(icon: Icon(Icons.note_add),
                                      title: Text('Add Item')),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                                      title: Text('Settings'))
          ],
        ),

        );
  }
}

