import 'package:flutter/material.dart';

class SurveyCard extends StatelessWidget {
  const SurveyCard({super.key, required this.imagepath, required this.title});

  final String imagepath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        shadowColor: const Color(0xFF1644E8),
        child: Column(
          children: [
            Image.asset(imagepath, height: 60, width: 60),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
