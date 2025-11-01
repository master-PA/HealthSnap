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
    final updatedProfile = userProfileNotifier.value.copyWith(
      name: updates['name'],
      gender: updates['gender'],
      dob: updates['dob'],
      relationship: updates['relationship'],
      height: updates['height'],
      weight: updates['weight'],
      country: updates['country'],
      dietType: updates['dietType'],
      sleepQuality: updates['sleepQuality'],
      hydrationLevel: updates['hydrationLevel'],
      stressLevel: updates['stressLevel'],
      smoking: updates['smoking'],
      alcoholIntake: updates['alcoholIntake'],
      symptoms: updates['symptoms'],
      symptomSeverity: updates['symptomSeverity'],
      details: updates['details'],
      stepsWalked: updates['stepsWalked'],
      sleepHours: updates['sleepHours'],
      waterIntake: updates['waterIntake'],
      bmi: updates['bmi'],
      heartRate: updates['heartRate'],
      calorieIntake: updates['calorieIntake'],
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
    String? details,
    int? stepsWalked,
    int? sleepHours,
    double? waterIntake,
    int? calorieIntake,
  }) {
    _updateProfile({
      'dietType': dietType,
      'sleepQuality': sleepQuality,
      'hydrationLevel': hydrationLevel,
      'stressLevel': stressLevel,
      'smoking': smoking,
      'alcoholIntake': alcoholIntake,
      'details': details,
      'stepsWalked': stepsWalked,
      'sleepHours': sleepHours,
      'waterIntake': waterIntake,
      'calorieIntake': calorieIntake,
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
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(profile.toJson()),
      );

      print('API Response: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Failed to save profile: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error saving profile: $e');
      return false;
    }
  }
}
