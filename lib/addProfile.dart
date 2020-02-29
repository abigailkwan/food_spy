import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class addProfile extends StatefulWidget {

  @override
  addProfileState createState() => addProfileState();
}

class addProfileState extends State <addProfile> {
  final formKey = GlobalKey<FormState>();
  final newProfile = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 250, 1.0),
      body: Container(
            child: Builder(
                builder: (context) => Form (
                  key: formKey,
                    child: Column(
                      children: [
                       SizedBox(height: 50.0),
                      TextFormField(
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
                        onSaved: (val) => setState(() => newProfile.name),
                      ),
                        SizedBox(height: 25.0),
                        FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2099, 12, 31),
                              onChanged: (date) {print('Enter ExpirationDate');},
                              onConfirm: (date) {print('Confirm Expiration Date');},
                              currentTime: DateTime.now(), locale: LocaleType.en);},
                            child: Text('Enter expiration date',)
                            ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                          child: RaisedButton(
                            onPressed: () {
                              final form = formKey.currentState;
                              }
                              )
                          ),
                      ]
                    )
                ),
            ),
      )
    );
  }
}