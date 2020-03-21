import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'datetime_picker.dart';
import 'package:http/http.dart' as http;

class editButton extends StatefulWidget {
  final editTextController;
  final editExpireController;
  String food_id;
  BuildContext context;

  editButton(this.editTextController, this.editExpireController, this.context, this.food_id);

  @override
  editButtonState createState() => editButtonState(editTextController, editExpireController, context, this.food_id);
}

class editButtonState extends State<editButton> {
  final editTextController;
  final editExpireController;
  String food_id;
  BuildContext context;

  editButtonState(this.editTextController, this.editExpireController, this.context, this.food_id);

  Future editProfile() async{
    String name = jsonEncode(editTextController.text);
    String exp_date = jsonEncode(editExpireController.text.substring(0,19));
    String food_idjson = jsonEncode(food_id);

    Map<String, dynamic> body = {
      'food_id': food_idjson,
      'name': name,
      'exp_date': exp_date,
    };

    String postUrl = url + editData;
    http.Response r = await http.post(
      postUrl,
      body: body,
    );

    int statusCode = r.statusCode;
    String responseBody = r.body;
    print("Posting Status: ${statusCode.toString()}");
    print("responseBody: ${responseBody}");
  }

  @override
  Widget build(BuildContext context) {
        return AlertDialog(
            title: new Text("Edit Profile"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius
                    .all(
                    Radius.circular(5.0))),
            content: SingleChildScrollView(
              child: ListBody(
                  children: <Widget> [
                    TextField(
                      controller: editTextController,
                      decoration: (InputDecoration(
                        labelText: "Food Name",
                      )
                      )
                  ),
                    dateTimePicker(editExpireController),
                  ]
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: Text("Edit"),
                onPressed: () {
                  editProfile();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ]
        );
      }
}