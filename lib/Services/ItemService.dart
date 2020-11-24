import 'dart:convert';

import 'package:client/models/Item.dart';
import 'package:client/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ItemService {
  // ignore: missing_return
  static Future<List<Item>> getItems() async {
    http.Response response = await http.get(
      "http://tandoorhut.tk/item/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Item> items =
          responseMap.map<Item>((itemMap) => Item.fromJson(itemMap)).toList();
      return items;
    } else {
      print("Debug create user");
    }
  }
  
}
