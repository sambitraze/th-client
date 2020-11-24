import 'dart:convert';

import 'package:client/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<User> createUser(payload) async {
    http.Response response = await http.post("http://tandoorhut.tk/user/create",
        headers: {"Content-Type": "application/json"}, body: payload);
    print(response.body);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", user.id);
      print(prefs.getString("id"));
      return user;
    } else {
      print("Debug create user");
    }
  }

  // ignore: missing_return
  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    http.Response response = await http.get(
      "http://tandoorhut.tk/user/$id",
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap);
      return user;
    } else {
      print("Debug create user");
    }
  }

  static Future<User> getUserByPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phoneNo");
    http.Response response = await http.post(
        "http://tandoorhut.tk/user/number/",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}));
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap[0]);
      print(user.address);
      return user;
    } else {
      print("Debug create user");
    }
  }
}
