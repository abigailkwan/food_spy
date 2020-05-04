import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'services.dart';
import 'text_style.dart';
import 'package:http/http.dart' as http;
import 'editButton.dart';

class DetailPage extends StatefulWidget {

  final Profile profile;

  DetailPage(this.profile);

  @override
  _DetailPageState createState() => _DetailPageState(profile);
}

class _DetailPageState extends State<DetailPage> {
  final Profile profile;
  final editTextController = TextEditingController();
  final editExpireController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editTextController.addListener(_printLatestValue);
    editExpireController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    editTextController.dispose();
    editExpireController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Testing Edit Name: ${editTextController.text}");
    print("Testing Edit Date: ${editExpireController.text}");
  }

  _DetailPageState(this.profile);

  Future deleteProfile() async{
    String food_id = jsonEncode(profile.food_id);

    Map<String, dynamic> body = {
      'food_id': food_id,
    };

    String postUrl = url + deleteData;
    http.Response r = await http.post(
      postUrl,
      body: body,
    );

    int statusCode = r.statusCode;
    String responseBody = r.body;
    print("Posting Status: ${statusCode.toString()}");
    print("responseBody: ${responseBody}");
  }

  Future <void> _showDialog (BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Delete Profile"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .all(
                      Radius.circular(5.0))),
              content: SingleChildScrollView(
                  child: ListBody(
                      children: <Widget>[
                        Text(
                            "Are you sure you want to delete?"),
                      ]
                  )
              ),
              actions: <Widget>[
                new FlatButton(
                  child: Text("Delete"),
                  onPressed: () {
                    deleteProfile();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    setState((){});
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
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(profile.name),
        ),
        body: new Container(
          color: Theme.of(context).primaryColor,
          constraints: new BoxConstraints.expand(),
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
            padding: new EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 32.0),
            children: <Widget>[
              new Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
                borderRadius: new BorderRadius.circular(25.0),
                ),
                  padding: new EdgeInsets.symmetric(vertical:32.0, horizontal:32.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(url+"/img/"+profile.food_image,
                              height: 200,
                              width: 250),
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(profile.name,
                                style: Style.commonTextStyle),
                          ]
                        ),
                        new Row(
                            children: <Widget>[
                              new Text("Date Registered: "),
                              new Text(profile.reg_date),
                            ]
                        ),
                        new Row(
                            children: <Widget>[
                              new Text("Expiration: "),
                              new Text(profile.exp_date),
                            ]
                        ),
                      ]
                  )
              ),
              new Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  height: 100,
                  width: 400,
                  child: new Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget> [
                    new Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: new ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                              width: 5,
                              height: 40.0,
                              child: Material(
                                  child: InkWell(
                                      splashColor: Color.fromRGBO(0, 66, 116, 1.0),
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                            builder: (BuildContext builder) {
                                              return editButton(editTextController,
                                                  editExpireController,
                                                  context, profile.food_id);
                                            });
                                        setState(() {});
                                        },
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget> [
                                            Icon(Icons.edit),
                                            Text("Edit"),
                                          ]
                                      )
                                  )
                              )
                          )
                      ),
                    ),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                                width: 5,
                                height: 40.0,
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                                child: Material(
                                    child: InkWell(
                                        splashColor: Color.fromRGBO(0, 66, 116, 1.0),
                                        onTap: () {
                                          _showDialog(context);
                                          setState(() {
                                          });
                                        },
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget> [
                                              Icon(Icons.delete_forever),
                                              Text("Delete"),
                                            ]
                                        )
                                    )
                                )
                            )
                        )
                    ),
                  ]
                  ),
              )
            ],
        )
    );
  }
}



