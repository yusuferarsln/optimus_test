import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:optimus_test_app/models/single_timezone_model.dart';
import 'package:optimus_test_app/models/timezone_model.dart';

ApiService get api => ApiService.instance;

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  Future fetchAvailableTimezones() async {
    final url = Uri.parse('https://timeapi.io/api/timezone/availabletimezones');

    try {
      final response = await http.get(url, headers: {
        'accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final timezones = jsonDecode(response.body);
        print('Available Timezones: ${timezones.length}');
        return TimeZoneModel.fromJson(timezones);
      } else {
        print('Failed to fetch timezones. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching timezones: $e');
    }
  }

  Future<String> getTimezoneFromIP() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['timezone'];
    } else {
      throw Exception('Failed to load timezone');
    }
  }

  Future getTimezoneData(String timeZone) async {
    final url =
        Uri.parse('https://timeapi.io/api/timezone/zone?timeZone=$timeZone');
    final response =
        await http.get(url, headers: {'accept': 'application/json'});

    if (response.statusCode == 200) {
      var timezone = json.decode(response.body);
      return SingleTimeZone.fromJson(timezone);
    } else {
      return null;
    }
  }
}
