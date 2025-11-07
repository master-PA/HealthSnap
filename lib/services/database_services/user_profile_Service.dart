import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserProfileService {
  // Singleton pattern
  static final UserProfileService _instance = UserProfileService._internal();
  factory UserProfileService() => _instance;
  UserProfileService._internal();

  final ValueNotifier<UserProfile> userProfileNotifier = ValueNotifier(
    UserProfile(
      name: '',
      gender: '',
      dob: '',
      relationship: '',
      height: 0,
      weight: 0,
      country: '',
      dietType: '',
      sleepQuality: '',
      hydrationLevel: '',
      stressLevel: '',
      smoking: '',
      alcoholIntake: '',
      symptoms: [],
      symptomSeverity: '',
      details: '',
      stepsWalked: 0,
      sleepHours: 0,
      waterIntake: 0.0,
      bmi: 0.0,
      heartRate: 0,
      calorieIntake: 0,
    ),
  );

  UserProfile get userProfile => userProfileNotifier.value;

  void _updateProfile(Map<String, dynamic> updates) {
    final current = userProfileNotifier.value;

    final updatedProfile = UserProfile(
      name: updates['name'] ?? current.name,
      gender: updates['gender'] ?? current.gender,
      dob: updates['dob'] ?? current.dob,
      relationship: updates['relationship'] ?? current.relationship,
      height: updates['height'] ?? current.height,
      weight: updates['weight'] ?? current.weight,
      country: updates['country'] ?? current.country,
      dietType: updates['dietType'] ?? current.dietType,
      sleepQuality: updates['sleepQuality'] ?? current.sleepQuality,
      hydrationLevel: updates['hydrationLevel'] ?? current.hydrationLevel,
      stressLevel: updates['stressLevel'] ?? current.stressLevel,
      smoking: updates['smoking'] ?? current.smoking,
      alcoholIntake: updates['alcoholIntake'] ?? current.alcoholIntake,
      symptoms: updates['symptoms'] ?? current.symptoms,
      symptomSeverity: updates['symptomSeverity'] ?? current.symptomSeverity,
      details: updates['details'] ?? current.details,
      stepsWalked: updates['stepsWalked'] ?? current.stepsWalked,
      sleepHours: updates['sleepHours'] ?? current.sleepHours,
      waterIntake: updates['waterIntake'] ?? current.waterIntake,
      bmi: updates['bmi'] ?? current.bmi,
      heartRate: updates['heartRate'] ?? current.heartRate,
      calorieIntake: updates['calorieIntake'] ?? current.calorieIntake,
      prediction: current.prediction,
      confidence: current.confidence,
      daysProvided: current.daysProvided,
      prediction2: current.prediction2,
      confidence2: current.confidence2,
    );

    userProfileNotifier.value = updatedProfile;
  }

  void updatePersonalInfo({
    String? name,
    String? gender,
    String? dob,
    String? relationship,
    int? height,
    int? weight,
    String? country,
  }) {
    _updateProfile({
      'name': name,
      'gender': gender,
      'dob': dob,
      'relationship': relationship,
      'height': height,
      'weight': weight,
      'country': country,
    });
  }

  void updateLifestyleInfo({
    String? dietType,
    String? sleepQuality,
    String? hydrationLevel,
    String? stressLevel,
    String? smoking,
    String? alcoholIntake,
  }) {
    _updateProfile({
      'dietType': dietType,
      'sleepQuality': sleepQuality,
      'hydrationLevel': hydrationLevel,
      'stressLevel': stressLevel,
      'smoking': smoking,
      'alcoholIntake': alcoholIntake,
    });
  }

  void updateHealthMetrics({
    List<String>? symptoms,
    String? symptomSeverity,
    String? details,
    double? bmi,
    int? heartRate,
    int? stepsWalked,
    int? sleepHours,
    double? waterIntake,
    int? calorieIntake,
  }) {
    _updateProfile({
      'symptoms': symptoms,
      'symptomSeverity': symptomSeverity,
      'details': details,
      'bmi': bmi,
      'heartRate': heartRate,
      'stepsWalked': stepsWalked,
      'sleepHours': sleepHours,
      'waterIntake': waterIntake,
      'calorieIntake': calorieIntake,
    });
  }

  void calculateBMI() {
    final profile = userProfileNotifier.value;

    if (profile.height > 0 && profile.weight > 0) {
      final heightInMeters = profile.height / 100;
      final calculatedBMI = profile.weight / (heightInMeters * heightInMeters);

      _updateProfile({'bmi': double.parse(calculatedBMI.toStringAsFixed(2))});
    }
  }

  Future<bool> saveProfileToServer(String authToken) async {
    const url = 'https://healthsnap-68ry.onrender.com/api/profile';
    final profile = userProfileNotifier.value;

    try {
      final jsonData = profile.toJson();

      // Debug: Print the data being sent
      print('═══════════════════════════════════════════');
      print('SENDING DATA TO SERVER:');
      print('═══════════════════════════════════════════');
      print(JsonEncoder.withIndent('  ').convert(jsonData));
      print('═══════════════════════════════════════════');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(jsonData),
      );

      print('\n📥 SERVER RESPONSE:');
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');
      print('═══════════════════════════════════════════\n');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final entry = data['data']?['entry'];
        if (entry != null) {
          print('ML Predictions received:');
          print(
            '   Prediction 1: ${entry['prediction']} (${entry['confidence']})',
          );
          print(
            '   Prediction 2: ${entry['prediction_2']} (${entry['confidence_2']})',
          );

          final updatedProfile = userProfile.copyWith(
            prediction: entry['prediction'],
            confidence: entry['confidence'] != null
                ? (entry['confidence'] as num).toDouble()
                : null,
            prediction2: entry['prediction_2'],
            confidence2: entry['confidence_2'] != null
                ? (entry['confidence_2'] as num).toDouble()
                : null,
          );

          userProfileNotifier.value = updatedProfile;
        } else {
          print(' Warning: No entry data in response');
        }

        return true;
      } else {
        print('Failed to save profile: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print(' Error saving profile: $e');
      return false;
    }
  }
}
