import 'dart:convert';

class Settings {
  String language;
  String theme;

  Settings({required this.language, required this.theme});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      language: json['language'],
      theme: json['theme'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'theme': theme,
    };
  }
}
