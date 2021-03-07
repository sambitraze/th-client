import 'dart:convert';
import 'package:client/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // ignore: missing_return
  static Future<User> createUser(payload) async {
    http.Response response = await http.post(Uri.parse("http://64.225.85.5/user/create"),
        headers: {"Content-Type": "application/json"}, body: payload);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", user.id);
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
      Uri.parse("http://64.225.85.5/user/$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap);
      return user;
    } else {
      print("Debug create user");
    }
  }

  // ignore: missing_return
  static Future<User> getUserByPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phoneNo");
    http.Response response = await http.post(
        Uri.parse("http://64.225.85.5/user/number/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}));
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap[0]);
      return user;
    } else {
      print("Debug create user");
    }
  }

  static Future<bool> userchk(phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.post(
        Uri.parse("http://64.225.85.5/user/number/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}));
    if (response.statusCode == 200) {
      prefs.setString("phoneNo", phone);
      return true;
    } else {
      return false;
    }
  }

  // ignore: missing_return
  static Future<bool> updateUser(User user) async {
    http.Response response = await http.put(
      Uri.parse("http://64.225.85.5/user/update/${user.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        user.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Debug update user");
      return false;
    }
  }
}
