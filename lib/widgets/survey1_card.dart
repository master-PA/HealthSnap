import 'package:flutter/material.dart';

class SurveyCard extends StatelessWidget {
  final String imagepath;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SurveyCard({
    super.key,
    required this.imagepath,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4285F4).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF4285F4) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: const Color(0xFF1644E8).withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagepath, height: 60, width: 60),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
