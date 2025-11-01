import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen5.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenFourth extends StatefulWidget {
  const SurveyScreenFourth({super.key});

  @override
  State<SurveyScreenFourth> createState() => _SurveyScreenFourthState();
}

class _SurveyScreenFourthState extends State<SurveyScreenFourth> {
  final Map<String, bool> symptoms = {
    'fever': false,
    'cough': false,
    'sore_throat': false,
    'runny_nose': false,
    'breath_shortness': false,
    'fatigue': false,
    'headache': false,
    'body_pain': false,
    'appetite_loss': false,
    'nausea': false,
    'stomach_pain': false,
    'sleep_quality': false,
    'mood_swings': false,
    'anxiety': false,
    'irritability': false,
    'concentration_loss': false,
  };

  final TextEditingController _otherSymptomController = TextEditingController();

  @override
  void dispose() {
    _otherSymptomController.dispose();
    super.dispose();
  }

  void _saveSymptomsData() {
    List<String> selectedSymptoms = symptoms.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (_otherSymptomController.text.isNotEmpty) {
      selectedSymptoms.add(_otherSymptomController.text);
    }

    UserProfileService().updateHealthMetrics(symptoms: selectedSymptoms);
  }

  void _validateAndProceed() {
    _saveSymptomsData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SurveyScreenFive()),
    );
  }

  String _formatSymptomName(String symptom) {
    return symptom
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
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
                  const SizedBox(width: 8),
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
                    const SizedBox(height: 20),
                    const Text(
                      'Select any symptoms you are experiencing today',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 32),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 16,
                      childAspectRatio: 4,
                      children: symptoms.keys.map((symptom) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              symptoms[symptom] = !symptoms[symptom]!;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: symptoms[symptom]!
                                      ? const Color(0xFF2563EB)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: symptoms[symptom]!
                                        ? const Color(0xFF2563EB)
                                        : Colors.grey[400]!,
                                    width: 2,
                                  ),
                                ),
                                child: symptoms[symptom]!
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  _formatSymptomName(symptom),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text(
                          'Other symptom(if any) :',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _otherSymptomController,
                            decoration: InputDecoration(
                              hintText: 'Type here',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF2563EB),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    if (symptoms.values.any((isSelected) => isSelected) ||
                        _otherSymptomController.text.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selected Symptoms:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getSelectedSymptomsText(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 32),

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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSelectedSymptomsText() {
    List<String> selectedSymptoms = symptoms.entries
        .where((entry) => entry.value)
        .map((entry) => _formatSymptomName(entry.key))
        .toList();

    if (_otherSymptomController.text.isNotEmpty) {
      selectedSymptoms.add(_otherSymptomController.text);
    }

    return selectedSymptoms.isEmpty ? 'None' : selectedSymptoms.join(', ');
  }
}
