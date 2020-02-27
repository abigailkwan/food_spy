import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services.dart';
import 'profilePage.dart';
import 'text_style.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 66, 116, 1.0)
      ),
      home: MyHomePage(title: 'Testing JSON'),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
            title: Text("BlueJay"),
          ),
          body: //

          new Container(
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
          ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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

