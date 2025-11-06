import 'package:healthsnap_app/models/user_profile_model.dart';

class HealthScoreUtils {
  static int calculateHealthScore(UserProfile p) {
    int score = 75;
    if (p.stepsWalked >= 7500)
      score += 10;
    else if (p.stepsWalked < 3000)
      score -= 10;

    if (p.sleepHours < 5)
      score -= 10;
    else if (p.sleepHours >= 7)
      score += 10;

    if (p.waterIntake < 1.5)
      score -= 5;
    else if (p.waterIntake >= 2.0)
      score += 5;

    if (p.bmi > 0 && (p.bmi < 18.5 || p.bmi > 25)) score -= 5;

    if (p.symptomSeverity.toLowerCase() == 'severe') score -= 15;
    return score.clamp(0, 100);
  }

  static String getScoreRating(int score) {
    if (score >= 90) return "Excellent";
    if (score >= 75) return "Good";
    if (score >= 60) return "Fair";
    return "Needs Improvement";
  }

  static String getScoreFeedback(int score) {
    if (score >= 75) return "You’re on track! Keep your healthy routine.";
    if (score >= 60) return "Doing okay, but consistency is key.";
    return "Try improving hydration, sleep, and activity.";
  }

  static String generateHealthAdvice(UserProfile p) {
    List<String> tips = [];
    if (p.stepsWalked < 5000) tips.add("Walk more—target 5,000+ steps daily.");
    if (p.sleepHours < 7) tips.add("Sleep at least 7 hours for recovery.");
    if (p.waterIntake < 2) tips.add("Drink 2L+ water daily.");
    if (p.symptoms.isNotEmpty) tips.add("Monitor symptoms and rest well.");
    return tips.isEmpty
        ? "You're maintaining great balance! Keep it up."
        : tips.join(" ");
  }
}
