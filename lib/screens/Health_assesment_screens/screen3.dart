import "package:flutter/material.dart";
import "package:healthsnap_app/screens/Health_assesment_screens/screen7.dart";
import "package:healthsnap_app/services/database_services/user_profile_Service.dart";
import "package:healthsnap_app/widgets/survey3_helper.dart";
import "package:healthsnap_app/widgets/survey_progress_indicator.dart";

class SurveyScreenThird extends StatefulWidget {
  const SurveyScreenThird({super.key});

  @override
  State<SurveyScreenThird> createState() => _SurveyScreenThirdState();
}

class _SurveyScreenThirdState extends State<SurveyScreenThird> {
  String? dietType;
  String? sleepQuality;
  String? hydrationLevel;
  String? stressLevel;
  String? smoking;
  String? alcoholIntake;

  void _saveLifestyleData() {
    UserProfileService().updateLifestyleInfo(
      dietType: dietType,
      sleepQuality: sleepQuality,
      hydrationLevel: hydrationLevel,
      stressLevel: stressLevel,
      smoking: smoking,
      alcoholIntake: alcoholIntake,
    );
  }

  void _validateAndProceed() {
    if (dietType != null &&
        sleepQuality != null &&
        hydrationLevel != null &&
        stressLevel != null &&
        smoking != null &&
        alcoholIntake != null) {
      _saveLifestyleData();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SurveyScreenSeven()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Image.asset('assets/logo.png', height: 40),

                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      label: const Text('Back'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SurveyProgressIndicator(currentStep: 2),
                    const SizedBox(height: 32),
                    const Text(
                      'Select what describes you .',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select one answer for each statement',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2196F3)),
                    ),
                    const SizedBox(height: 32),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const SizedBox(height: 20),
                    SurveySingleOption(
                      title: "Diet type",
                      first: "Vegan",
                      second: "Vegetarian",
                      third: "Non vegetarian",
                      noOfOptions: 3,
                      selectedValue: dietType,
                      onChanged: (value) {
                        setState(() {
                          dietType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const SizedBox(height: 20),
                    SurveySingleOption(
                      title: "Sleep quality",
                      first: "Low",
                      second: "Normal",
                      third: "High",
                      noOfOptions: 3,
                      selectedValue: sleepQuality,
                      onChanged: (value) {
                        setState(() {
                          sleepQuality = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const SizedBox(height: 20),
                    SurveySingleOption(
                      title: "Hydration level",
                      first: "Low",
                      second: "Normal",
                      third: "High",
                      noOfOptions: 3,
                      selectedValue: hydrationLevel,
                      onChanged: (value) {
                        setState(() {
                          hydrationLevel = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const SizedBox(height: 20),
                    SurveySingleOption(
                      title: "Stress level",
                      first: "Low",
                      second: "Normal",
                      third: "High",
                      noOfOptions: 3,
                      selectedValue: stressLevel,
                      onChanged: (value) {
                        setState(() {
                          stressLevel = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const SizedBox(height: 20),
                    SurveySingleOption(
                      title: "Smoking",
                      first: "Yes",
                      second: "No",
                      third: "",
                      noOfOptions: 2,
                      selectedValue: smoking,
                      onChanged: (value) {
                        setState(() {
                          smoking = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const SizedBox(height: 20),
                    SurveySingleOption(
                      title: "Alcohol intake",
                      first: "Occasionally",
                      second: "Regularly",
                      third: "Never",
                      noOfOptions: 3,
                      selectedValue: alcoholIntake,
                      onChanged: (value) {
                        setState(() {
                          alcoholIntake = value;
                        });
                      },
                    ),
                    const SizedBox(height: 48),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          _validateAndProceed;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
