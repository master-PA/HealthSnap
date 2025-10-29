import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen5.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenFourth extends StatefulWidget {
  const SurveyScreenFourth({super.key});

  @override
  State<SurveyScreenFourth> createState() => _SurveyScreenFourthState();
}

class _SurveyScreenFourthState extends State<SurveyScreenFourth> {
  final Map<String, bool> symptoms = {
    'Headache': false,
    'Muscle pain': false,
    'Dizzy': false,
    'Fatigue': false,
    'Fever': false,
    'Vomiting': false,
  };

  final TextEditingController _otherSymptomController = TextEditingController();

  @override
  void dispose() {
    _otherSymptomController.dispose();
    super.dispose();
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
                colors: [Colors.orange[100]!, Colors.orange],
              ),
            ),
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
                        onPressed: () {},
                        child: const Text(
                          'Re-evaluate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const SurveyProgressIndicator(currentStep: 2),
                    const SizedBox(height: 20),
                    const Text(
                      'Select any symptoms person is experiencing today',
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
                                  symptom,
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
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          List<String> selectedSymptoms = symptoms.entries
                              .where((entry) => entry.value)
                              .map((entry) => entry.key)
                              .toList();

                          if (_otherSymptomController.text.isNotEmpty) {
                            selectedSymptoms.add(_otherSymptomController.text);
                          }

                          print('Selected symptoms: $selectedSymptoms');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurveyScreenFive(),
                            ),
                          );
                        },
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
                        child: const Text(
                          'Next ->',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
