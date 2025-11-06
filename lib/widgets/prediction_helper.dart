import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';

class PredictionHelper {
  final UserProfile p;
  PredictionHelper(this.p);

  bool get hasPredictions => p.prediction != null || p.prediction2 != null;

  String? get trend => p.prediction;
  String get trendTitle => "Health Trend: ${_capitalize(p.prediction!)}";
  Color get trendColor => _color(p.prediction!);
  IconData get trendIcon => _icon(p.prediction!);
  String get trendMsg => _trendMsg(p.prediction!);

  String? get tip => p.prediction2;
  String get tipTitle => "Focus Area: ${_capitalize(p.prediction2!)}";
  IconData get tipIcon => _tipIcon(p.prediction2!);
  String get tipMsg => _tipMsg(p.prediction2!);

  Color _color(String v) {
    switch (v.toLowerCase()) {
      case 'improving':
        return Colors.green;
      case 'worsening':
        return Colors.red;
      case 'stable':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  IconData _icon(String v) {
    switch (v.toLowerCase()) {
      case 'improving':
        return Icons.trending_up;
      case 'worsening':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.analytics;
    }
  }

  String _trendMsg(String v) {
    switch (v.toLowerCase()) {
      case 'improving':
        return 'Your health trend is improving — keep up the good work.';
      case 'stable':
        return 'Your health is stable — maintain your current habits.';
      case 'moderate':
        return 'Your health is moderate — stay consistent and monitor your progress.';
      case 'declining':
        return 'Your health seems to be declining — take some rest and review your routine.';
      default:
        return 'Health trend not available.';
    }
  }

  IconData _tipIcon(String t) {
    switch (t.toLowerCase()) {
      case 'hydration':
        return Icons.water_drop;
      case 'sleep':
        return Icons.bedtime;
      case 'exercise':
        return Icons.directions_run;
      case 'nutrition':
        return Icons.restaurant;
      default:
        return Icons.favorite;
    }
  }

  String _tipMsg(String t) {
    switch (t.toLowerCase()) {
      case 'hydration':
        return 'Focus on staying hydrated today.';
      case 'nutrition':
        return 'Pay attention to balanced meals and nutrition.';
      case 'rest':
        return 'Ensure you’re getting proper rest and recovery.';
      case 'exercise':
        return 'Try to stay active with light exercise.';
      case 'stress':
        return 'Take some time to relax and reduce stress.';
      default:
        return 'No specific advice at the moment.';
    }
  }

  String _capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;
}
