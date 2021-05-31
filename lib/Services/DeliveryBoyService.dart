import 'dart:convert';
import 'package:client/models/deliveryBoy.dart';
import 'package:http/http.dart' as http;

class DeliveryBoyService {
  static Future getDeliveryBoyByEmail(email) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/deliveryBoy/email"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      DeliveryBoy deliveryBoy = DeliveryBoy.fromJson(responseMap[0]);
      return deliveryBoy;      
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  static Future getAllDeliveryBoy() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/deliveryBoy/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<DeliveryBoy> deliveryBoys = responseMap
          .map<DeliveryBoy>((itemMap) => DeliveryBoy.fromJson(itemMap))
          .toList();
      return deliveryBoys;
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  static Future<bool> updateDeliveryBoy(payload) async {
    print(payload);
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/deliveryBoy/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      print("true");
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
