//https://api.coingecko.com/api/v3/coins/

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String coin) async {
  String url = 'https://api.coingecko.com/api/v3/coins/$coin';
  try {
    http.Response response = await http.get(Uri.parse(url));
    var jsonResponse = json.decode(response.body);
    var price = jsonResponse['market_data']['current_price']['usd'].toString();
    return double.parse(price);
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}
