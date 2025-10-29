import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  const Tip({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 400,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.lightBlue[50]!, Colors.lightBlue[100]!],
          ),
          border: BoxBorder.all(
            color: Color(0xFF105BBB),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Text('💡 Tip', style: TextStyle(fontSize: 12)),
            SizedBox(height: 6),
            Text(
              "Stay hydrated! Aim for 8 glass of water today ...",
              style: TextStyle(color: Color(0xFF495A85), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
