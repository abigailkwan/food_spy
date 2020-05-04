import 'package:flutter/material.dart';
import 'package:food_spy/addProfile.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services.dart';
import 'profilePage.dart';
import 'text_style.dart';
import 'addProfile.dart';
import 'local_notifications_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'testPage.dart';

class listPage extends StatefulWidget{

  @override
  listPageState createState() => listPageState();
}

class listPageState extends State<listPage> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    final settingsAndroid = AndroidInitializationSettings('flutter_logo');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
    context, MaterialPageRoute(builder: (context) => testPage(payload: payload)),
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color.fromRGBO(0, 66, 116, 1.0),
        child: new FutureBuilder<List<Profile>>(
          future: getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  padding: const EdgeInsets.only(left:25.0, top: 70.0, right:  25.0, bottom: 0.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    String todaydate = DateTime.now().toString().substring(0,10);
                    print(todaydate);
                    if (snapshot.data[index].exp_date.substring(0,10) == todaydate){
                    showOngoingNotification(notifications, title: 'Expiration alert! The food below is about to expire:',
                      body: snapshot.data[index].name);}
                    return new Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: new Text(snapshot.data[index].name,
                            style: Style.listTextStyle),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                DetailPage(snapshot.data[index])),
                          );
                        },
                      ),
                      //EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return new Text("List is currently Empty.",
                textScaleFactor: 2,
              );
            }
            return new CircularProgressIndicator();
          },
        ),
    );
  }
}