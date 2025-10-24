import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen2.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';
import 'package:healthsnap_app/widgets/survey1_card.dart';

class SurveyScreenFirst extends StatelessWidget {
  SurveyScreenFirst({super.key});

  final String? username = authService.value.currentUser?.displayName ?? "User";

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
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
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
              Text('👋 Hey $username !'),
              const SizedBox(height: 40),
              const Text('Who is the Survey for?'),
              const SizedBox(height: 20),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SurveyCard(imagepath: 'assets/icon1.png', title: "Myself"),
                  SizedBox(width: 10),
                  SurveyCard(
                    imagepath: 'assets/icon2.png',
                    title: "Someone else",
                  ),
                ],
              ),
              const SizedBox(height: 25),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveyScreenSecond(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1644E8),
                    shape: StadiumBorder(),
                  ),
                  child: Text('Next ⟶', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
