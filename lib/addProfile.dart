import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class addProfile extends StatefulWidget {

  @override
  addProfileState createState() => addProfileState();
}

class addProfileState extends State <addProfile> {
  final newProfile = Profile();
  final myController = TextEditingController();
  final dateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
    dateTimeController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  Future postSettings() async{
    String name = jsonEncode(myController.text);

    String exp_date = jsonEncode(dateTimeController.text.substring(0,19));

    Map<String, dynamic> body = {
      'name': name,
      //'reg_date': reg_date,
      'exp_date': exp_date,
    };

    String postUrl = url + postData;
    http.Response r = await http.post(
      postUrl,
      body: body,
    );

    int statusCode = r.statusCode;
    String responseBody = r.body;
    print("Posting Status: ${statusCode.toString()}");
    print("responseBody: ${responseBody}");
    print("exp_date: ${exp_date}");
  }

  _printLatestValue() {
    print("Testing: ${myController.text}");
    print("Current Date: ${dateTimeController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            child: Column(
                      children: [
                       SizedBox(height: 50.0),
                      TextFormField(
                        controller: myController,
                        decoration: InputDecoration(
                        labelText: 'Name',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                        Icons.local_offer,
                      ),
                        hintText: "Enter the food's name",
                      ),
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter the food name';
                          }
                          return null;
                          },
                          onChanged: (val) {
                          setState(() => newProfile.name);
                          print("Testing: $val");}
                          ),
                        SizedBox(height: 25.0),
                        dateTimePicker(dateTimeController),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                          child: RaisedButton(
                            child: Container(
                              child: const Text ('Add Food'),
                            ),
                            onPressed: () {
                                postSettings();
                              }
                              )
                          ),
                      ]
                    )
                ),
    );
  }
}