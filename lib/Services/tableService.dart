import 'package:http/http.dart' as http;
import 'dart:convert';

class TableService {

  static Future tableCount() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/table/count"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap["tablecount"];
    } else {
      print(response.body);
      return 0;
    }
  }
}