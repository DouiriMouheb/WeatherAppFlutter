import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class MyCard extends StatelessWidget {
  final String title;
  final String value;
  final String animationPath;

  const MyCard({
    Key? key,
    required this.title,
    required this.value,
    required this.animationPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Lottie.asset(animationPath),
            ),
            SizedBox(width: 8.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(value, style: TextStyle(fontSize: 12.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Helper function to format time
