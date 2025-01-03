import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest';
  static const String _apiKey = 'fcf7b872-7c16-4e4d-87af-f62feafedb57';

  Future<Map<String, dynamic>?> fetchCryptoPrice(String symbol) async {
  try {
    final url = Uri.parse('$_baseUrl?symbol=$symbol');

    final response = await http.get(
      url,
      headers: {
        'Accepts': 'application/json',
        'X-CMC_PRO_API_KEY': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'][symbol];
    } else {
      print('API Error: ${response.statusCode}');
      return null;
    }
  } on SocketException catch (e) {
    print('SocketException: $e');
    return null;  
  } catch (e) {
    print('Unexpected Error: $e');
    return null;  
  }
}

}
