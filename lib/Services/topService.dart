import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/models/top.dart';

class TopService {

  static Future<List<Top>> getTops() async {
    http.Response response = await http.get(
      "http://64.225.85.5/top/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Top> tops =
      responseMap.map<Top>((itemMap) => Top.fromJson(itemMap)).toList();
      return tops;
    } else {
      print(response.body);
    }
  }
}