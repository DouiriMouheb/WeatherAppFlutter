//import 'package:Weather/services/preferences_manager.dart';
import 'package:weather_app_programazione_exam_1/pages//detailed_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../services/weather_service.dart';
import '../pages//about_view.dart';
//import '../pages//theme_switch.dart';
//import '../gen/strings.g.dart';
    //'/i18n/strings.g.dart'; // (1) import


class HomeView extends StatefulWidget {
  final bool isDarkMode;
  final Function toggleTheme;
  final Function(AppLocale) onLanguageChange; // Add this callback
  const HomeView({required this.isDarkMode, required this.toggleTheme,required this.onLanguageChange});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  String cityName = "";
  String a = t.Settings;
  Map<String, dynamic>? weatherData;

  final WeatherService weatherService = WeatherService();
  void _openSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter City Name'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'City Name'),
          autofocus: true, // Focus the text field automatically
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cityName = _controller.text;
              });
              fetchWeather();
              Navigator.pop(context);
            },
            child: const Text('Search'),
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
    if (mainCondition == null) return 'assets/sunny.json';
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
        return 'assets/cloudy.json';
      case 'rain':
      case 'light rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'clear':
      case 'clear sky':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text('Weather App'),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          elevation: 1, // Remove shadow
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8.0), // Add space here
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
                    t.Settings,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              ThemeSwitch(
                  isDarkMode: widget.isDarkMode,
                  toggleTheme: widget.toggleTheme),
              ListTile(
                title: Text('Change Language'),
                onTap: () async {
                  final preferencesManager = PreferencesManager();
                  final currentLanguage = await preferencesManager.loadLanguagePreference();
                  final newLanguage = currentLanguage == 'en' ? 'it' : 'en';

                  // Save the new language preference
                  await preferencesManager.saveLanguagePreference(newLanguage);

                  // Notify the parent widget to rebuild with the new locale
                  widget.onLanguageChange(newLanguage == 'en' ? AppLocale.en : AppLocale.it);

                  // Show a toast to confirm the change
                  Fluttertoast.showToast(
                    msg: 'Language changed to ${newLanguage == 'en' ? 'English' : 'Italian'}.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );

                  // Close the drawer
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('About App'),
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
            child: SingleChildScrollView( // to avoid the keyboard overfllowing error
                child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align to the end
                children: [
                  SizedBox(
                      width: 12), // Add spacing between TextField and button
                  IconButton(
                    // Use IconButton for a smaller button
                    icon: Icon(Icons.search, size: 30), // Adjust icon size
                    onPressed: _openSearchDialog,
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (weatherData == null)
                Column(
                  children: [
                    //  Row
                    //  Lottie.asset('assets/noData.json'),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Lottie.asset('assets/noData.json'),
                    ),

                    Text(t.EnterCityName)
                    //)
                  ],
                )
              else if (weatherData!.containsKey('error'))
                Column(
                  children: [
                    //  Row
                    //  Lottie.asset('assets/noData.json'),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Lottie.asset('assets/notFound.json'),
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
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center horizontally
                      children: [
                        Center(
                          // Center vertically within the row
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
                        t.MoreDetails,
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
