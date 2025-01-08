import 'dart:convert';
import 'package:weather_app_programazione_exam_1/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL='https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "1b6e560dcc6db8097fcea91e7cedff01";
  //final String apiKey ;
  Future<Weather> getWeather(String cityName) async{
    final res = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
  if(res.statusCode==200){
    return Weather.fromJson(jsonDecode(res.body));
  } else{
    throw Exception('Failed to load weather data');
  }
  }


  Future<Map<String, dynamic>?> fetchWeather(String cityName) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the JSON response if successful
        return jsonDecode(response.body);

      } else {
        // Handle errors
        return {'error': 'OOPS City Not Found.'};
      }
    } catch (e) {
      // Handle network errors
      return {'error': 'Failed to fetch weather. Please try again.'};
    }
  }


}
