class UserProfile {
  final String name;
  final String gender;
  final String dob;
  final String relationship;
  final int height;
  final int weight;
  final String country;
  final String dietType;
  final String sleepQuality;
  final String hydrationLevel;
  final String stressLevel;
  final String smoking;
  final String alcoholIntake;
  final List<String> symptoms;
  final String symptomSeverity;
  final String details;
  final int stepsWalked;
  final int sleepHours;
  final double waterIntake;
  final double bmi;
  final int heartRate;
  final int calorieIntake;

  UserProfile({
    required this.name,
    required this.gender,
    required this.dob,
    required this.relationship,
    required this.height,
    required this.weight,
    required this.country,
    required this.dietType,
    required this.sleepQuality,
    required this.hydrationLevel,
    required this.stressLevel,
    required this.smoking,
    required this.alcoholIntake,
    required this.symptoms,
    required this.symptomSeverity,
    required this.details,
    required this.stepsWalked,
    required this.sleepHours,
    required this.waterIntake,
    required this.bmi,
    required this.heartRate,
    required this.calorieIntake,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'DOB': dob,
      'relationship': relationship,
      'height': height,
      'weight': weight,
      'country': country,
      'diet_type': dietType,
      'sleep_quality': sleepQuality,
      'hydration_level': hydrationLevel,
      'stress_level': stressLevel,
      'smoking': smoking,
      'alcohol_intake': alcoholIntake,
      'symptoms': symptoms,
      'symptom_severity': symptomSeverity,
      'details': details,
      'steps_walked': stepsWalked,
      'sleep_hours': sleepHours,
      'water_intake': waterIntake,
      'BMI': bmi,
      'heart_rate': heartRate,
      'calorie_intake': calorieIntake,
    };
  }
}
