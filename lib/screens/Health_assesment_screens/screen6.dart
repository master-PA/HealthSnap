import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen7.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenSix extends StatefulWidget {
  const SurveyScreenSix({super.key});

  @override
  State<SurveyScreenSix> createState() => _SurveyScreenSixState();
}

class _SurveyScreenSixState extends State<SurveyScreenSix> {
  final TextEditingController _textC = TextEditingController();

  @override
  void dispose() {
    _textC.dispose();
    super.dispose();
  }

  void _saveAdditionalDetails() {
    if (_textC.text.isNotEmpty) {
      UserProfileService().updateHealthMetrics(details: _textC.text);
    }
  }

  void _validateAndProceed() {
    _saveAdditionalDetails();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SurveyScreenSeven()),
    );
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
                    const SurveyProgressIndicator(currentStep: 2),
                    const SizedBox(height: 30),
                    const Text(
                      '💬 Any other details we should know ?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: TextFormField(
                        controller: _textC,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText:
                              "✏️ Please describe any unique details, that makes them better or worse (e.g., 'worse in the morning', 'Happens after exercise')",
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${_textC.text.length} characters',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _validateAndProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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

                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _validateAndProceed,
                        child: const Text(
                          'Skip for now',
                          style: TextStyle(color: Colors.grey),
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
