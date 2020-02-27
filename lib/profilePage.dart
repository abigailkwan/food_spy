import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';

class DetailPage extends StatelessWidget {
  final Profile profile;

  DetailPage(this.profile);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(profile.name),
        ),
        body: new Container(
          constraints: new BoxConstraints.expand(),
          color: Color.fromRGBO(0, 66, 116, 1.0),
          child: new Stack(
            children: <Widget>[
              displayContent()
            ],
          ),
        ),
    );
  }
  Container displayContent() {
    final title = "Details".toUpperCase();
    return new Container(
        child: new ListView(
            padding: new EdgeInsets.fromLTRB(50.0, 145.0, 50.0, 32.0),
            children: <Widget>[
              new Container(
                  decoration: new BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1.0),
                borderRadius: new BorderRadius.circular(25.0),
                ),
                  padding: new EdgeInsets.symmetric(vertical:32.0, horizontal:32.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(title),
                        new Text(profile.name,
                        style: Style.commonTextStyle),
                        new Text(profile.exp_date),
                        new Text(profile.reg_date)
                      ]
                  )
              )
            ]
        )
    );
  }
}

