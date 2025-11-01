import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen6.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';
import 'package:healthsnap_app/widgets/survey_progress_indicator.dart';

class SurveyScreenFive extends StatefulWidget {
  const SurveyScreenFive({super.key});

  @override
  State<SurveyScreenFive> createState() => _SurveyScreenFiveState();
}

class _SurveyScreenFiveState extends State<SurveyScreenFive> {
  int selectedIndex = 1;
  int duration = 3;

  String get _symptomSeverity {
    switch (selectedIndex) {
      case 0:
        return "None";
      case 1:
        return "Mild";
      case 2:
        return "Moderate";
      case 3:
        return "Severe";
      default:
        return "Mild";
    }
  }

  void _saveSymptomData() {
    UserProfileService().updateHealthMetrics(
      symptomSeverity: _symptomSeverity,

      details: "Symptom duration: $duration days",
    );
  }

  void _validateAndProceed() {
    _saveSymptomData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SurveyScreenSix()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                  const Icon(Icons.menu, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Icon(
                        Icons.help_outline_rounded,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Symptom Severity',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "select the level that best describes your symptom",
                    style: TextStyle(color: Color(0xFF4F8EF7), fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 4; i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = i;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selectedIndex == i
                                        ? const Color(0xFF4F8EF7)
                                        : Colors.grey.shade300,
                                    width: selectedIndex == i ? 2 : 1,
                                  ),
                                  boxShadow: selectedIndex == i
                                      ? [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      ["✅", "🟡", "🟠", "🔴"][i],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      ["None", "Mild", "Moderate", "Severe"][i],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      [
                                        "No symptoms",
                                        "Slight discomfort",
                                        "Noticeable symptoms",
                                        "Significant symptoms",
                                      ][i],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Symptom Duration",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton<int>(
                          value: duration,
                          underline: const SizedBox(),
                          onChanged: (v) {
                            setState(() {
                              duration = v!;
                            });
                          },
                          items: List.generate(
                            10,
                            (i) => DropdownMenuItem(
                              value: i + 1,
                              child: Text(
                                "${i + 1}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Days",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                _validateAndProceed;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
