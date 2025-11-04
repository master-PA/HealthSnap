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
  final String? prediction;
  final double? confidence;
  final int? daysProvided;
  final String? prediction2;
  final double? confidence2;

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
    this.prediction,
    this.confidence,
    this.daysProvided,
    this.prediction2,
    this.confidence2,
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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['DOB'] ?? json['dob'] ?? '',
      relationship: json['relationship'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      country: json['country'] ?? '',
      dietType: json['diet_type'] ?? json['dietType'] ?? '',
      sleepQuality: json['sleep_quality'] ?? json['sleepQuality'] ?? '',
      hydrationLevel: json['hydration_level'] ?? json['hydrationLevel'] ?? '',
      stressLevel: json['stress_level'] ?? json['stressLevel'] ?? '',
      smoking: json['smoking'] ?? '',
      alcoholIntake: json['alcohol_intake'] ?? json['alcoholIntake'] ?? '',
      symptoms: json['symptoms'] != null
          ? List<String>.from(json['symptoms'])
          : [],
      symptomSeverity:
          json['symptom_severity'] ?? json['symptomSeverity'] ?? '',
      details: json['details'] ?? '',
      stepsWalked: json['steps_walked'] ?? json['stepsWalked'] ?? 0,
      sleepHours: json['sleep_hours'] ?? json['sleepHours'] ?? 0,
      waterIntake: (json['water_intake'] ?? json['waterIntake'] ?? 0.0)
          .toDouble(),
      bmi: (json['BMI'] ?? json['bmi'] ?? 0.0).toDouble(),
      heartRate: json['heart_rate'] ?? json['heartRate'] ?? 0,
      calorieIntake: json['calorie_intake'] ?? json['calorieIntake'] ?? 0,
      prediction: json['prediction'] ?? json['mlPrediction']?['prediction'],
      confidence: (json['confidence'] ?? json['mlPrediction']?['confidence'])
          ?.toDouble(),
      daysProvided: json['mlPrediction']?['days_provided'],
      prediction2: json['prediction_2'],
      confidence2: (json['confidence_2'])?.toDouble(),
    );
  }

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
      prediction: prediction ?? this.prediction,
      confidence: confidence ?? this.confidence,
      daysProvided: daysProvided ?? this.daysProvided,
      prediction2: prediction2 ?? this.prediction2,
      confidence2: confidence2 ?? this.confidence2,
    );
  }
}
