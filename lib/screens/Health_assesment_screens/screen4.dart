import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/main_screens/dashboard.dart';
import 'package:healthsnap_app/widgets/survey4_helper.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenFourth extends StatefulWidget {
  const SurveyScreenFourth({super.key});

  @override
  State<SurveyScreenFourth> createState() => _SurveyScreenFourthState();
}

class _SurveyScreenFourthState extends State<SurveyScreenFourth> {
  final TextEditingController _symptomC = TextEditingController();
  final TextEditingController _stepsC = TextEditingController();
  final TextEditingController _waterC = TextEditingController();
  final TextEditingController _sleepC = TextEditingController();
  final TextEditingController _heartC = TextEditingController();
  final TextEditingController _bmiC = TextEditingController();
  final TextEditingController _mentalC = TextEditingController();
  final TextEditingController _calorieC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _symptomC.dispose();
    _stepsC.dispose();
    _waterC.dispose();
    _sleepC.dispose();
    _heartC.dispose();
    _bmiC.dispose();
    _mentalC.dispose();
    _calorieC.dispose();
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
              const SizedBox(height: 20),
              SurveyProgressIndicator(currentStep: 3),
              const SizedBox(height: 20),
              Text('How is your score?'),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Symptom Severity",
                controller: _symptomC,
                hinttext: "e.g., None,mild,moderate,severe",
                keyboardtype: TextInputType.text,
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Steps Walked",
                controller: _stepsC,
                hinttext: "e.g., 7,500 steps today",
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Water Intake",
                controller: _waterC,
                hinttext: "e.g., 2.5 litres or 8 glasses",
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Sleep Hours",
                controller: _sleepC,
                hinttext: "e.g., slept for 7 hours last night",
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Average Heart Beat",
                controller: _heartC,
                hinttext: "e.g., 78 bpm (beats per minute)",
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "BMI (Body Mass Index)",
                controller: _bmiC,
                hinttext: "e.g., 23.4 (Normal range)",
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Mental wellbeing score",
                controller: _mentalC,
                hinttext: "e.g., Feeling relaxed or focussed (8/10)",
                keyboardtype: TextInputType.text,
              ),
              const SizedBox(height: 16),
              SurveyTextField(
                title: "Calorie Intake",
                controller: _calorieC,
                hinttext: "e.g., 1,950 kcal today",
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
