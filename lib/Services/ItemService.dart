import 'dart:convert';
import 'package:client/models/Item.dart';
import 'package:http/http.dart' as http;

class ItemService {
  // ignore: missing_return
  static Future<List<Item>> getItems() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/item/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Item> items =
          responseMap.map<Item>((itemMap) => Item.fromJson(itemMap)).toList();
      return items;
    } else {
      print("Debug get item");
    }
  }
}
