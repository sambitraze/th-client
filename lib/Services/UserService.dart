import 'dart:convert';

import 'package:client/models/User.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<User> createUser(payload) async {
    http.Response response = await http.post(
      "http://tandoorhut.tk/user/create",
      headers: {"Content-Type": "application/json"},
      body: payload
    );
    print(response.body);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap);
      print(user.uid);
      return user;
    } else {
      print("Debug create user");
    }
  }
}
