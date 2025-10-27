import 'package:flutter/material.dart';

class ScreenFiveCard extends StatefulWidget {
  const ScreenFiveCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;

  @override
  State<ScreenFiveCard> createState() => _ScreenFiveCardState();
}

class _ScreenFiveCardState extends State<ScreenFiveCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.blue[100],
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueGrey,
                  child: Text(widget.icon),
                ),
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(fontSize: 8, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
