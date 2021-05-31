import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/models/top.dart';

class TopService {

  // ignore: missing_return
  static Future<List<Top>> getTops() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/top/"),
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