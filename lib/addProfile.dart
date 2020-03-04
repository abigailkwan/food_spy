import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'datetime_picker.dart';

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

  _printLatestValue() {
    print("Testing: ${myController.text}");
    print("Current Date: ${dateTimeController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 250, 1.0),
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
                        color: Color.fromRGBO(0, 0, 0, 1.0),
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
                            onPressed: () {
                              }
                              )
                          ),
                      ]
                    )
                ),
    );
  }
}