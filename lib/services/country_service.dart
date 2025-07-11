import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/country.dart';

class CountryService {
  static const String _url =
      'https://restcountries.com/v3.1/all?fields=name,capital,population,area,region,flags,languages,currencies,timezones,borders';

  static const String _cacheKey = 'cached_countries';
  static const String _cacheTimestampKey = 'cached_countries_timestamp';

  static Future<List<Country>> fetchCountries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);
      final cachedTimestamp = prefs.getInt(_cacheTimestampKey);
      final now = DateTime.now().millisecondsSinceEpoch;

      final bool isValidCache =
          cachedData != null &&
          cachedTimestamp != null &&
          now - cachedTimestamp <= const Duration(hours: 24).inMilliseconds;

      if (isValidCache) {
        final List<dynamic> jsonData = json.decode(cachedData);
        return jsonData.map((e) => Country.fromJson(e)).toList();
      }

      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        prefs.setString(_cacheKey, json.encode(data));
        prefs.setInt(_cacheTimestampKey, now);
        return data.map((e) => Country.fromJson(e)).toList();
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Network or parsing error: $e');
    }
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    await prefs.remove(_cacheTimestampKey);
  }
}
