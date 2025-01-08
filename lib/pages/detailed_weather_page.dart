import 'package:weather_app_programazione_exam_1/pages/myCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_programazione_exam_1/services/localization_service.dart';

class DetailedWeatherPage extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const DetailedWeatherPage({required this.weatherData});

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/animations/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'overcast clouds':
      case 'broken clouds':
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'fog':
        return 'assets/animations/cloudy.json';
      case 'rain':
      case 'light rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animations/rainy.json';
      case 'clear':
      case 'clear sky':
        return 'assets/animations/sunny.json';
      default:
        return 'assets/animations/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('DetailedWeather')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    children: [
                      Text(
                        '${weatherData!['name']}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const Icon(Icons.location_on),
                    ],
                  ),
                ),
              ],
            ),
            Lottie.asset(
                getWeatherAnimation('${weatherData!['weather'][0]['main']}')),
            Text(
              '${weatherData['main']['temp']}°C',
              style: TextStyle(fontSize: 25.0),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MyCard(
                            title: (AppLocalizations.of(context)!.translate('Sunrise')),
                            value: _formatTime(weatherData['sys']['sunrise']),
                            animationPath: 'assets/animations/sunny.json',
                          ),
                          MyCard(
                            title: (AppLocalizations.of(context)!.translate('Sunset')),
                            value: _formatTime(weatherData['sys']['sunset']),
                            animationPath: 'assets/animations/night.json',
                          ),
                          MyCard(
                            title: 'Max Temp',
                            value: '${weatherData['main']['temp_max']}°C',
                            animationPath: 'assets/animations/maxTemp.json',
                          ),
                          MyCard(
                            title: 'Min Temp',
                            value: '${weatherData['main']['temp_min']}°C',
                            animationPath: 'assets/animations/minTemp.json',
                          ),
                          MyCard(
                            title: (AppLocalizations.of(context)!.translate('WindSpeed')),
                            value: '${weatherData['wind']['speed']}KM',
                            animationPath: 'assets/animations/windSpeed.json',
                          ),
                          MyCard(
                            title: (AppLocalizations.of(context)!.translate('Humidity')),
                            value: '${weatherData['main']['humidity']}%',
                            animationPath: 'assets/animations/humidity.json',
                          ),
                          // ... other cards ...
                        ],
                      ),
                    ),
                  ],
                ),
            )


          ],
        ),
      ),
    );
  }
}

String _formatTime(int unixTimestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  return DateFormat('hh:mm a').format(dateTime);
}
