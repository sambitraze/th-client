import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String googleAPIkey = "AIzaSyCsCrdcPpr03PKI9TA0R3ndWclKnf5IZWY";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    print(l1.latitude);
    print(l2.latitude);
    print(l1.longitude);
    print(l2.longitude);
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$googleAPIkey";
    http.Response response = await http.get(Uri.parse(url));
    print(url);
    print(response.statusCode);
    print(response.body);
    Map values = jsonDecode(response.body);
    print("====================>>>>>>>>$values");

    return values["routes"][0]["overview_polyline"]["points"];
  }
}
