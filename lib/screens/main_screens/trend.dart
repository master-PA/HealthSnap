import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen4.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';

class HealthTrendScreen extends StatelessWidget {
  const HealthTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = UserProfileService().userProfile;

    final int overallScore = _calculateHealthScore(userProfile);

    final List<String> symptoms = userProfile.symptoms;

    final String advice = _generateHealthAdvice(userProfile);

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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "⭐ You are doing great! keep walking.",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildMetricCard(
                        "STEPS TODAY",
                        "${userProfile.stepsWalked}",
                        "steps",
                        Icons.directions_walk,
                        _getStepsTrend(userProfile.stepsWalked),
                        Colors.blue,
                      ),
                      _buildMetricCard(
                        "CALORIE INTAKE",
                        "${userProfile.calorieIntake}",
                        "kcal",
                        Icons.local_fire_department,
                        _getCalorieTrend(userProfile.calorieIntake),
                        Colors.orange,
                      ),
                      _buildMetricCard(
                        "SLEEP DURATION",
                        "${userProfile.sleepHours}",
                        "hrs",
                        Icons.nightlight_round,
                        _getSleepTrend(userProfile.sleepHours),
                        Colors.purple,
                      ),
                      _buildMetricCard(
                        "WATER INTAKE",
                        "${userProfile.waterIntake}",
                        "L",
                        Icons.water_drop,
                        _getWaterTrend(userProfile.waterIntake),
                        Colors.lightBlue,
                        isNegative: userProfile.waterIntake < 2.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildSymptomsCard(
                    context,
                    symptoms,
                    userProfile.symptomSeverity,
                  ),
                  const SizedBox(height: 20),

                  _buildHealthScoreCard(overallScore),
                  const SizedBox(height: 20),

                  _buildAdviceCard(advice),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String unit,
    IconData icon,
    String change,
    Color color, {
    bool isNegative = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
              Icon(icon, color: color),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: isNegative ? Colors.red : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsCard(
    BuildContext context,
    List<String> symptoms,
    String symptomSeverity,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Current Symptoms",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          symptoms.isEmpty
              ? const Text(
                  "No symptoms reported",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                )
              : Wrap(
                  spacing: 10,
                  children: symptoms
                      .map(
                        (s) => Chip(
                          label: Text(_formatSymptomName(s)),
                          backgroundColor: Colors.blue.shade50,
                        ),
                      )
                      .toList(),
                ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "Severity: ",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              Text(
                symptomSeverity.isNotEmpty ? symptomSeverity : "Not specified",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Spacer(),
              _getSeverityIcon(symptomSeverity),
              const SizedBox(width: 6),
              Text(
                symptomSeverity.isNotEmpty ? symptomSeverity : "None",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SurveyScreenFourth(),
                  ),
                );
              },
              child: const Text(
                "Update symptoms",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScoreCard(int overallScore) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Overall Health Score",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: overallScore / 100,
                  strokeWidth: 8,
                  color: Colors.blue,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              Text(
                "$overallScore",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getScoreRating(overallScore),
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getScoreFeedback(overallScore),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceCard(String advice) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Advices",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            advice.isEmpty
                ? "No specific advice at the moment. Complete your health assessment for personalized recommendations."
                : advice,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _formatSymptomName(String symptom) {
    return symptom
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _getSeverityIcon(String severity) {
    switch (severity.toLowerCase()) {
      case 'severe':
        return const CircleAvatar(radius: 6, backgroundColor: Colors.red);
      case 'moderate':
        return const CircleAvatar(radius: 6, backgroundColor: Colors.orange);
      case 'mild':
        return const CircleAvatar(radius: 6, backgroundColor: Colors.amber);
      default:
        return const CircleAvatar(radius: 6, backgroundColor: Colors.green);
    }
  }

  int _calculateHealthScore(UserProfile profile) {
    int score = 75; // Base score

    // Adjust based on steps (target: 7500 steps)
    if (profile.stepsWalked >= 7500)
      score += 10;
    else if (profile.stepsWalked >= 5000)
      score += 5;
    else if (profile.stepsWalked < 3000)
      score -= 10;

    // Adjust based on sleep (target: 7-9 hours)
    if (profile.sleepHours >= 7 && profile.sleepHours <= 9)
      score += 10;
    else if (profile.sleepHours >= 6)
      score += 5;
    else if (profile.sleepHours < 5)
      score -= 10;

    // Adjust based on water intake (target: 2L)
    if (profile.waterIntake >= 2.0)
      score += 10;
    else if (profile.waterIntake >= 1.5)
      score += 5;
    else if (profile.waterIntake < 1.0)
      score -= 10;

    // Adjust based on BMI (healthy range: 18.5-24.9)
    if (profile.bmi > 0) {
      if (profile.bmi >= 18.5 && profile.bmi <= 24.9)
        score += 10;
      else if (profile.bmi > 25 && profile.bmi <= 29.9)
        score -= 5;
      else if (profile.bmi >= 30)
        score -= 10;
    }

    // Adjust based on symptoms
    if (profile.symptoms.isNotEmpty) {
      if (profile.symptomSeverity.toLowerCase() == 'severe')
        score -= 15;
      else if (profile.symptomSeverity.toLowerCase() == 'moderate')
        score -= 10;
      else if (profile.symptomSeverity.toLowerCase() == 'mild')
        score -= 5;
    }

    return score.clamp(0, 100);
  }

  String _getScoreRating(int score) {
    if (score >= 90) return "Excellent";
    if (score >= 80) return "Very Good";
    if (score >= 70) return "Good";
    if (score >= 60) return "Fair";
    return "Needs Improvement";
  }

  String _getScoreFeedback(int score) {
    if (score >= 80)
      return "You're maintaining great balance! Keep up the good work.";
    if (score >= 60)
      return "You're doing well. Focus on consistent hydration and sleep.";
    return "Let's work on improving your daily habits for better health.";
  }

  String _generateHealthAdvice(UserProfile profile) {
    final advice = <String>[];

    if (profile.stepsWalked < 5000) {
      advice.add(
        "Try to increase your daily steps to at least 5,000 for better cardiovascular health.",
      );
    }

    if (profile.sleepHours < 7) {
      advice.add(
        "Aim for 7-9 hours of sleep each night for optimal recovery and mental clarity.",
      );
    }

    if (profile.waterIntake < 2.0) {
      advice.add(
        "Increase your water intake to at least 2 liters daily for proper hydration.",
      );
    }

    if (profile.bmi > 25 && profile.bmi > 0) {
      advice.add(
        "Consider incorporating more physical activity and balanced nutrition for weight management.",
      );
    }

    if (profile.symptoms.isNotEmpty) {
      advice.add(
        "Monitor your symptoms and consult a healthcare provider if they persist or worsen.",
      );
    }

    if (advice.isEmpty) {
      return "Your health metrics look great! Maintain your current healthy habits and regular check-ups.";
    }

    return advice.join(" ");
  }

  // Trend calculation methods (simplified - in real app, you'd compare with historical data)
  String _getStepsTrend(int steps) {
    if (steps >= 8000) return "+15% from target";
    if (steps >= 6000) return "+5% from target";
    if (steps >= 4000) return "Meeting minimum";
    return "Below target";
  }

  String _getCalorieTrend(int calories) {
    if (calories >= 2000) return "Adequate intake";
    if (calories >= 1500) return "Moderate intake";
    return "Low intake";
  }

  String _getSleepTrend(int sleepHours) {
    if (sleepHours >= 8) return "Optimal sleep";
    if (sleepHours >= 7) return "Good sleep";
    if (sleepHours >= 6) return "Adequate sleep";
    return "Insufficient sleep";
  }

  String _getWaterTrend(double waterIntake) {
    if (waterIntake >= 2.5) return "Excellent hydration";
    if (waterIntake >= 2.0) return "Good hydration";
    if (waterIntake >= 1.5) return "Moderate hydration";
    return "Need more water";
  }
}
