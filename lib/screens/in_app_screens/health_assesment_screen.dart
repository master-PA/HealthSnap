import 'package:flutter/material.dart';
import 'package:healthsnap_app/widgets/survey_card.dart';

class HealthAssesmentScreen extends StatefulWidget {
  const HealthAssesmentScreen({super.key});

  @override
  State<HealthAssesmentScreen> createState() => _HealthAssesmentScreenState();
}

class _HealthAssesmentScreenState extends State<HealthAssesmentScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 80),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1644E8),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          '← Back',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.white54),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text('👋 Hey User !'),
              const SizedBox(height: 40),
              const Text('Who is the Survey for?'),
              const SizedBox(height: 20),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SurveyCard(icon: Icons.person, title: "Myself"),
                  SizedBox(width: 10),
                  SurveyCard(
                    icon: Icons.diversity_3_rounded,
                    title: "Someone else",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
