import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'package:http/http.dart' as http;

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
    String profileEdited = jsonEncode(_currentProfile.food_id);
    String pictureName = jsonEncode(_currentProfile.food_id + ".jpg");

    Map<String, dynamic> body = {
      'food_id': profileEdited,
      //'reg_date': reg_date,
      'file_name': pictureName,
    };

    String postUrl = url + addPic;
    http.Response r = await http.post(
      postUrl,
      body: body,
    );

    int statusCode = r.statusCode;
    String responseBody = r.body;
    print("Posting Status: ${statusCode.toString()}");
    print("responseBody: ${responseBody}");
    print("exp_date: ${pictureName}");

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
        child: Text("Add Image"),
        onPressed: () {
          postPicture();
          Navigator.of(context).pop();
        },
      ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],);
  }
}