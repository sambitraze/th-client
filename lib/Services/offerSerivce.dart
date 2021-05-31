
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/offers.dart';

class OfferService {
  // ignore: missing_return
  static Future<List<Offer>> getUnBlockedOffers() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/offer/unblocked"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Offer> offers =
      responseMap.map<Offer>((itemMap) => Offer.fromJson(itemMap)).toList();
      return offers;
    } else {
      print(response.body);
    }
  }


}
