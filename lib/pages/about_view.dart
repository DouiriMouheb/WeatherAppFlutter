import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_programazione_exam_1/services/localization_service.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('AboutApp')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
            AppLocalizations.of(context)!.translate('AboutAppIntroduction'),              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
                AppLocalizations.of(context)!.translate('Features'),

              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('AboutApp1'),style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context)!.translate('AboutApp2'),style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context)!.translate('AboutApp3'),style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context)!.translate('AboutApp4'),style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context)!.translate('AboutApp5'),style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context)!.translate('AboutApp6'),style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context)!.translate('AboutApp7'),style: TextStyle(fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}