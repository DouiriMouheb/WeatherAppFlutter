import 'dart:convert';
import 'package:weather_app_programazione_exam_1/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "1b6e560dcc6db8097fcea91e7cedff01";


  Future<Map<String, dynamic>?> fetchWeather(String cityName) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'OOPS City Not Found.'};
      }
    } catch (e) {
      return {'error': 'Failed to fetch weather. Please try again.'};
    }
  }
}
