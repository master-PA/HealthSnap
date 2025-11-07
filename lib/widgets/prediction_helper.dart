import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';

class PredictionHelper {
  PredictionHelper(this.p);
  final UserProfile p;

  bool get hasPredictions => p.prediction != null || p.prediction2 != null;

  // Prediction 1 (Health Trend)
  String? get trend => p.prediction;
  String get trendTitle => "Health Trend";
  Color get trendColor => _getColorForTrend(p.prediction);
  IconData get trendIcon => Icons.analytics;
  String get trendMsg => p.prediction ?? 'No prediction available';
  String get trendConfidence => p.confidence != null
      ? '${(p.confidence! * 100).toStringAsFixed(1)}% confidence'
      : '';

  // Prediction 2 (Focus Area)
  String? get tip => p.prediction2;
  String get tipTitle => "Focus Area";
  IconData get tipIcon => _getIconForArea(p.prediction2);
  String get tipMsg => p.prediction2 ?? 'No focus area identified';
  String get tipConfidence => p.confidence2 != null
      ? '${(p.confidence2! * 100).toStringAsFixed(1)}% confidence'
      : '';

  Color _getColorForTrend(String? trend) {
    if (trend == null) return Colors.grey;

    final t = trend.toLowerCase();
    if (t.contains('improving') || t.contains('better') || t.contains('good')) {
      return Colors.green;
    }
    if (t.contains('worse') || t.contains('decline') || t.contains('bad')) {
      return Colors.red;
    }
    if (t.contains('stable') || t.contains('maintain')) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  IconData _getIconForArea(String? area) {
    if (area == null) return Icons.favorite;

    final a = area.toLowerCase();
    if (a.contains('hydration') || a.contains('water')) {
      return Icons.water_drop;
    }
    if (a.contains('sleep') || a.contains('rest')) {
      return Icons.bedtime;
    }
    if (a.contains('exercise') ||
        a.contains('activity') ||
        a.contains('step')) {
      return Icons.directions_run;
    }
    if (a.contains('nutrition') || a.contains('diet') || a.contains('food')) {
      return Icons.restaurant;
    }
    if (a.contains('stress') || a.contains('mindfulness')) {
      return Icons.self_improvement;
    }
    return Icons.favorite;
  }

  String _capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;
}
