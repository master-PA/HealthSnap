import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/main_screens/home.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';
import 'package:healthsnap_app/widgets/loading_widget.dart';
import 'package:healthsnap_app/widgets/survey7_helper.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenSeven extends StatefulWidget {
  const SurveyScreenSeven({super.key});

  @override
  State<SurveyScreenSeven> createState() => _SurveyScreenSevenState();
}

class _SurveyScreenSevenState extends State<SurveyScreenSeven> {
  final TextEditingController _stepsC = TextEditingController();
  final TextEditingController _waterC = TextEditingController();
  final TextEditingController _sleepC = TextEditingController();
  final TextEditingController _heartC = TextEditingController();
  final TextEditingController _bmiC = TextEditingController();
  final TextEditingController _mentalC = TextEditingController();
  final TextEditingController _calorieC = TextEditingController();

  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _stepsC.dispose();
    _waterC.dispose();
    _sleepC.dispose();
    _heartC.dispose();
    _bmiC.dispose();
    _mentalC.dispose();
    _calorieC.dispose();
  }

  int? _parseInt(String text) {
    if (text.isEmpty) return null;
    final cleanText = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanText);
  }

  double? _parseDouble(String text) {
    if (text.isEmpty) return null;
    final cleanText = text.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleanText);
  }

  void _saveHealthMetrics() {
    UserProfileService().updateHealthMetrics(
      stepsWalked: _parseInt(_stepsC.text),
      sleepHours: _parseInt(_sleepC.text),
      waterIntake: _parseDouble(_waterC.text),
      heartRate: _parseInt(_heartC.text),
      bmi: _parseDouble(_bmiC.text),
      calorieIntake: _parseInt(_calorieC.text),
    );

    UserProfileService().updateLifestyleInfo(
      details: _mentalC.text.isNotEmpty
          ? "Mental wellbeing: ${_mentalC.text}"
          : null,
    );
  }

  Future<void> _submitAllData() async {
    _saveHealthMetrics();

    setState(() {
      _isLoading = true;
    });

    try {
      final String? authToken = await _authService.getToken();

      if (authToken == null || authToken.isEmpty) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please login first to save your profile"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final success = await UserProfileService().saveProfileToServer(authToken);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Profile saved successfully! View your Health Trends in trends section",
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to save to server, but data saved locally."),
            backgroundColor: Colors.orange,
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
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
                    SurveyProgressIndicator(currentStep: 3),
                    const SizedBox(height: 20),
                    Text(
                      'Fuel Your Progress : Enter Your\nMatrices for Personalized Advice',
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

                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: _isLoading
                          ? LoadingWidget()
                          : ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "View your Health Trends in trends section",
                                    ),
                                  ),
                                );
                                _submitAllData;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
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
                    ),
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
