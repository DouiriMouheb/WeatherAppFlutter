import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_programazione_exam_1/models/settings_model.dart';

class SettingsProvider with ChangeNotifier {
  Settings _settings = Settings(language: 'en', theme: 'light');

  Settings get settings => _settings;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? settingsString = prefs.getString('settings');
    if (settingsString != null) {
      _settings = Settings.fromJson(json.decode(settingsString));
      notifyListeners();
    }
  }

  Future<void> updateSettings(Settings newSettings) async {
    _settings = newSettings;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('settings', json.encode(newSettings.toJson()));
    notifyListeners();
  }
}
