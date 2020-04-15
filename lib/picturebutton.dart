import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';

class pictureButton extends StatefulWidget {

  BuildContext context;

  pictureButton(this.context);

  @override
  pictureButtonState createState() => pictureButtonState(this.context);
}

class pictureButtonState extends State<pictureButton> {
  String _selectedText = "None";
  Profile _currentProfile;
  BuildContext context;
  Future<List<Profile>> dropDownList;

  pictureButtonState(this.context);

  @override
  void initState(){
    dropDownList = getProfileData();
    super.initState();
  }

  Future postPicture() async {
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Add Picture"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        content:
        SingleChildScrollView(
            child: ListBody(
                children: <Widget>[
                  FutureBuilder<List<Profile>>(
                    future: dropDownList,
                    builder: (BuildContext context,
                    snapshot){
                      if(snapshot.hasData){
                        return DropdownButton<Profile>(
                          value: _currentProfile,
                          items: snapshot.data.map((profile) => DropdownMenuItem<Profile>(
                            child: Text(profile.name),
                            value: profile,
                          )).toList(),
                          onChanged: (Profile prof) {
                            setState(() {
                              _currentProfile = prof;
                              print(_currentProfile.name);
                          });},
                          isExpanded: true,
                          hint: Text("Select Food"),
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }
                  )
                ])),
      actions: <Widget>[
      FlatButton(
        child: Text("Ok"),
        onPressed: () {

        },
      )
      ],);
//button with popup adds photo to photo column of food
  }
}