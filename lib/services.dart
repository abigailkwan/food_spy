import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

String url = 'https://abigailkwan.000webhostapp.com/';
String profileData = 'index.php?data=1';
String tempData = 'index.php?data=2';
String postData = 'post.php';

Future<List<Profile>> getProfileData() async{
  final response = await http.get(url + profileData);
  List responseJson = json.decode(response.body.toString());
  List<Profile> profileList = createProfileList(responseJson);
  return profileList;
}

Future getTemperatureData() async{
  final response = await http.get(url + tempData);
  Map<String, dynamic> map = json.decode(response.body.toString());
  String tempdata = map['temp_data'];
  Temperature temp_current = Temperature(tempdata);
  return temp_current;
}

List<Profile> createProfileList(List data) {

  List<Profile> list = new List();

  for(int i = 0; i < data.length; i++){
    String id = data[i]["food_id"];
    String food = data[i]["name"];
    String registered = data[i]["reg_date"];
    String expired = data[i]["exp_date"];
    Profile profile = new Profile(
      food_id: id, name: food, reg_date: registered, exp_date: expired);
    list.add(profile);
  }
  return list;
}
/*
List<Temperature> createTemperatureList(List data) {

  List<Temperature> list = new List();

  for(int i = 0; i < data.length; i++){
    String tempData = data[i]["temp_data"];
    Temperature profile = new Temperature(
        temp: tempData);
    list.add(profile);
  }
  return list;
}*/

class Profile {
  final String food_id;
  final String name;
  final String reg_date;
  final String exp_date;

  Profile({this.food_id,
    this.name,
    this.reg_date,
    this.exp_date});
}

class Temperature {
  final String temp;

  Temperature(this.temp);
}

