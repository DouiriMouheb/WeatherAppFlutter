import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:weather_app_programazione_exam_1/models/settings_model.dart';
import 'package:weather_app_programazione_exam_1/pages/about_view.dart';
import 'package:weather_app_programazione_exam_1/pages/detailed_weather_page.dart';
import 'package:weather_app_programazione_exam_1/services/localization_service.dart';
import 'package:weather_app_programazione_exam_1/services/settings_provider.dart';
import 'package:weather_app_programazione_exam_1/services/weather_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String cityName = "";

  Map<String, dynamic>? weatherData;

  final WeatherService weatherService = WeatherService();
  void _openSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.translate('EnterCityName')),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
              hintText: (AppLocalizations.of(context)!.translate('CityName'))),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.translate('Cancel')),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cityName = _controller.text;
              });
              fetchWeather();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.translate('Search')),
          ),
        ],
      ),
    );
  }

  void fetchWeather() async {
    if (cityName.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a city name.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      final data = await weatherService.fetchWeather(cityName);

      setState(() {
        weatherData = data;
      });

      if (data == null || !data.containsKey('main')) {
        Fluttertoast.showToast(
          msg: "City not found or something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error fetching weather: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

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
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          elevation: 1,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8.0),
            child: Container(),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    (AppLocalizations.of(context)!.translate('Settings')),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              Column(
                children: [
                  DropdownButton<String>(
                    value: settingsProvider.settings.language,
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                            AppLocalizations.of(context)!.translate('English')),
                      ),
                      DropdownMenuItem(
                        value: 'it',
                        child: Text('Italien'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        settingsProvider.updateSettings(
                          Settings(
                            language: value,
                            theme: settingsProvider.settings.theme,
                          ),
                        );
                      }
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                        AppLocalizations.of(context)!.translate('dark_theme')),
                    value: settingsProvider.settings.theme == 'dark',
                    onChanged: (value) {
                      settingsProvider.updateSettings(
                        Settings(
                          language: settingsProvider.settings.language,
                          theme: value ? 'dark' : 'light',
                        ),
                      );
                    },
                  ),
                ],
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context)!.translate('AboutApp')),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutView()));
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 12),
                  IconButton(
                    icon: Icon(Icons.search, size: 30),
                    onPressed: _openSearchDialog,
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (weatherData == null)
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Lottie.asset('assets/animations/noData.json'),
                    ),
                    Text(AppLocalizations.of(context)!
                        .translate('EnterCityNameGetWeather')),
                  ],
                )
              else if (weatherData!.containsKey('error'))
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Lottie.asset('assets/animations/notFound.json'),
                    ),

                    Text(
                      weatherData!['error'],
                      style: TextStyle(color: Colors.red, fontSize: 25.0),
                    )
                    //)
                  ],
                )
              else
                Column(
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
                    const SizedBox(height: 20),
                    Text('${weatherData!['main']['temp']}°C',
                        style: const TextStyle(fontSize: 30.0)),
                    Lottie.asset(getWeatherAnimation(
                        '${weatherData!['weather'][0]['main']}')),
                    ElevatedButton(
                      onPressed: () {
                        if (weatherData != null &&
                            !weatherData!.containsKey('error')) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailedWeatherPage(
                                  weatherData: weatherData!),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please fetch weather data first.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      },
                      child: Text(
                        (AppLocalizations.of(context)!
                            .translate('MoreDetails')),
                        style: const TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ))));
  }
}
