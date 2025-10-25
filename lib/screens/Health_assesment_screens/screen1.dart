import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen2.dart';
import 'package:healthsnap_app/widgets/survey1_card.dart';

class SurveyScreenFirst extends StatefulWidget {
  const SurveyScreenFirst({super.key});

  @override
  State<SurveyScreenFirst> createState() => _SurveyScreenFirstState();
}

class _SurveyScreenFirstState extends State<SurveyScreenFirst> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: "Screen0",
        child: Column(
          children: [
            Container(
              color: const Color(0xFFEE9B7B),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo.png', height: 80),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      '👋 Hey User !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 60),

                    const Text(
                      'Who is the Survey for?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: SurveyCard(
                            imagepath: 'assets/icon1.png',
                            title: "Myself",
                            isSelected: _selectedIndex == 0,
                            onTap: () {
                              setState(() => _selectedIndex = 0);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SurveyCard(
                            imagepath: 'assets/icon2.png',
                            title: "Someone else",
                            isSelected: _selectedIndex == 1,
                            onTap: () {
                              setState(() => _selectedIndex = 1);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    Hero(
                      tag: "Screen1",
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _selectedIndex != null
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SurveyScreenSecond(),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            disabledBackgroundColor: Colors.grey.shade400,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Next →',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
