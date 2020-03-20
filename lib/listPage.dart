import 'package:flutter/material.dart';
import 'package:food_spy/addProfile.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services.dart';
import 'profilePage.dart';
import 'text_style.dart';
import 'addProfile.dart';

class listPage extends StatefulWidget{

  @override
  listPageState createState() => listPageState();
}

class listPageState extends State<listPage> {


  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new FutureBuilder<List<Profile>>(
          future: getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  padding: const EdgeInsets.only(left:25.0, top: 70.0, right:  25.0, bottom: 0.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
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
              return new Text("${snapshot.error}"
              );
            }
            return new CircularProgressIndicator();
          },
        ),
        color: Color.fromRGBO(0, 66, 116, 1.0)
    );
  }
}