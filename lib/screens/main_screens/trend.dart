import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen4.dart';
import 'package:healthsnap_app/screens/in_app_screens/about_screen.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';
import 'package:healthsnap_app/widgets/health_score_util.dart';
import 'package:healthsnap_app/widgets/prediction_helper.dart';

class HealthTrendScreen extends StatelessWidget {
  const HealthTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileService = UserProfileService();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<UserProfile>(
        valueListenable: userProfileService.userProfileNotifier,
        builder: (context, userProfile, child) {
          final score = HealthScoreUtils.calculateHealthScore(userProfile);
          final advice = HealthScoreUtils.generateHealthAdvice(userProfile);
          final predictions = PredictionHelper(userProfile);

          return Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMetricsGrid(userProfile),
                      const SizedBox(height: 20),
                      _buildSymptomsCard(context, userProfile),
                      const SizedBox(height: 20),
                      _buildHealthScoreCard(score),
                      const SizedBox(height: 20),
                      _buildPredictionCard(predictions),
                      const SizedBox(height: 20),
                      _buildAdviceCard(advice),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            const Spacer(),
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (value) {
                if (value == 'about') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  );
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'about', child: Text('About Us')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(UserProfile p) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _metricCard(
          "Steps",
          "${p.stepsWalked}",
          "steps",
          Icons.directions_walk,
        ),
        _metricCard(
          "Calories",
          "${p.calorieIntake}",
          "kcal",
          Icons.local_fire_department,
        ),
        _metricCard("Sleep", "${p.sleepHours}", "hrs", Icons.bedtime),
        _metricCard("Water", "${p.waterIntake}", "L", Icons.water_drop),
      ],
    );
  }

  Widget _metricCard(String title, String value, String unit, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              Icon(icon, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsCard(BuildContext context, UserProfile p) {
    return _infoCard(
      title: "Symptoms",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          p.symptoms.isEmpty
              ? const Text(
                  "No symptoms reported",
                  style: TextStyle(color: Colors.grey),
                )
              : Wrap(
                  spacing: 8,
                  children: p.symptoms
                      .map(
                        (s) => Chip(
                          label: Text(s),
                          backgroundColor: Colors.blue.shade50,
                        ),
                      )
                      .toList(),
                ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text("Severity: "),
              Text(
                p.symptomSeverity.isNotEmpty ? p.symptomSeverity : "None",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SurveyScreenFourth()),
                ),
                child: const Text("Update Symptoms"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScoreCard(int score) {
    final rating = HealthScoreUtils.getScoreRating(score);
    final feedback = HealthScoreUtils.getScoreFeedback(score);
    return _infoCard(
      title: "Health Score",
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 8,
                color: Colors.blue,
                backgroundColor: Colors.grey.shade200,
              ),
              Text(
                "$score",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            rating,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(feedback, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(PredictionHelper p) {
    if (!p.hasPredictions) {
      return _infoCard(
        title: "Health Insights",
        child: const Text("Keep logging data to unlock AI insights."),
      );
    }

    return _infoCard(
      title: "AI Health Insights",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (p.trend != null)
            _mlBlock(p.trendTitle, p.trendColor, p.trendIcon, p.trendMsg),
          if (p.tip != null)
            _mlBlock(p.tipTitle, Colors.blue, p.tipIcon, p.tipMsg),
        ],
      ),
    );
  }

  Widget _mlBlock(String title, Color color, IconData icon, String msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(msg, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceCard(String advice) {
    return _infoCard(
      title: "Advices",
      child: Text(advice, style: const TextStyle(fontSize: 14, height: 1.4)),
    );
  }

  Widget _infoCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
