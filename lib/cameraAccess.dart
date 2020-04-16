import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'picturebutton.dart';

class cameraAccess extends StatefulWidget {

  @override
  cameraAccessState createState() => cameraAccessState();
}

class cameraAccessState extends State<cameraAccess> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Image.network('https://abigailkwan.000webhostapp.com/img/abby.jpg'),
          FlatButton(
            child: Text("Add Picture to Profile"),
            onPressed: () {
              showDialog<String>(context: context,
                builder: (BuildContext builder){
                return pictureButton(context);
              }
              );
              },
          ),
        ],
      )
    );
  }
  //button with popup adds photo to photo column of food
}