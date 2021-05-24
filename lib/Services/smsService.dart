import 'dart:convert';
import 'package:http/http.dart' as http;

class SmsService {
  static Future<bool> getTops(phone) async {
    http.Response response = await http.post(
        Uri.parse("http://64.225.85.5/sms/send"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
