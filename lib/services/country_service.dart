import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryService {
  static const String _url =
      'https://restcountries.com/v3.1/all?fields=name,capital,population,area,region,flags,languages,currencies,timezones,borders';

  static Future<List<Country>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Network or parsing error: $e');
    }
  }
}
