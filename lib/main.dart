import 'package:flutter/material.dart';
import 'package:food_spy/addProfile.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services.dart';
import 'profilePage.dart';
import 'text_style.dart';
import 'addProfile.dart';
import 'listPage.dart';
import 'cameraAccess.dart';

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
  int currentTab = 0;
  listPage one;
  cameraAccess two;
  addProfile three;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    one = listPage();
    two = cameraAccess();
    three = addProfile();
    pages = [one, two, three];
    currentPage = one;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
            title: Text("BlueJay"),
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

