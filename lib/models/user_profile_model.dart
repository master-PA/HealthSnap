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

  const UserProfile({
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

  // ----------------------------
  // 🔹 Convert to JSON for API
  // ----------------------------
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

  // ----------------------------
  // 🔹 Copy existing object with new values
  // ----------------------------
  UserProfile copyWith({
    String? name,
    String? gender,
    String? dob,
    String? relationship,
    int? height,
    int? weight,
    String? country,
    String? dietType,
    String? sleepQuality,
    String? hydrationLevel,
    String? stressLevel,
    String? smoking,
    String? alcoholIntake,
    List<String>? symptoms,
    String? symptomSeverity,
    String? details,
    int? stepsWalked,
    int? sleepHours,
    double? waterIntake,
    double? bmi,
    int? heartRate,
    int? calorieIntake,
  }) {
    return UserProfile(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      relationship: relationship ?? this.relationship,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      country: country ?? this.country,
      dietType: dietType ?? this.dietType,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      hydrationLevel: hydrationLevel ?? this.hydrationLevel,
      stressLevel: stressLevel ?? this.stressLevel,
      smoking: smoking ?? this.smoking,
      alcoholIntake: alcoholIntake ?? this.alcoholIntake,
      symptoms: symptoms ?? this.symptoms,
      symptomSeverity: symptomSeverity ?? this.symptomSeverity,
      details: details ?? this.details,
      stepsWalked: stepsWalked ?? this.stepsWalked,
      sleepHours: sleepHours ?? this.sleepHours,
      waterIntake: waterIntake ?? this.waterIntake,
      bmi: bmi ?? this.bmi,
      heartRate: heartRate ?? this.heartRate,
      calorieIntake: calorieIntake ?? this.calorieIntake,
    );
  }
}
