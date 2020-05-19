import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'picturebutton.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class cameraAccess extends StatefulWidget {

  @override
  cameraAccessState createState() => cameraAccessState();
}

class cameraAccessState extends State<cameraAccess> {

  String imageKey;

  String getDate() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = dateFormat.format(DateTime.now());
    return formattedDate;
  }

  @override
  void initState(){
    imageKey = getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(0, 66, 116, 1.0),
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: (){
              setState(() {
                imageKey = getDate();
              });
            },
            child: Stack(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                Center(child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'https://abigailkwan.000webhostapp.com/img/abby.jpg' + "?v=" + imageKey)),
              ]
            ),
          ),
          RaisedButton(
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