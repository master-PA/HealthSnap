import 'package:flutter/material.dart';

class HomeFlashcard extends StatelessWidget {
  const HomeFlashcard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttontext,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 180,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue[100]!,
          border: BoxBorder.all(
            color: Color(0xFF495A85),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            Text(subtitle, style: TextStyle(color: Colors.black, fontSize: 6)),
            SizedBox(height: 6),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(shape: StadiumBorder()),
              child: Text(
                "$buttontext ⟶",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
