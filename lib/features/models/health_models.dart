import 'dart:typed_data';

import 'package:flutter/material.dart';

enum TimelineType { meal, workout, water, sleep, weight }

class HealthMetric {
  const HealthMetric({
    required this.label,
    required this.value,
    required this.progress,
    required this.icon,
  });

  final String label;
  final String value;
  final double progress;
  final IconData icon;
}

class NutritionData {
  const NutritionData({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final int fiber;
}

class FoodItem {
  const FoodItem({
    required this.name,
    required this.serving,
    required this.calories,
  });

  final String name;
  final String serving;
  final int calories;
}

class MealAnalysis {
  const MealAnalysis({
    required this.foods,
    required this.nutrition,
    required this.healthScore,
    required this.insight,
  });

  final List<FoodItem> foods;
  final NutritionData nutrition;
  final int healthScore;
  final String insight;
}

class TimelineEvent {
  const TimelineEvent({
    required this.time,
    required this.title,
    required this.summary,
    required this.icon,
    required this.type,
  });

  final DateTime time;
  final String title;
  final String summary;
  final IconData icon;
  final TimelineType type;
}

class ProfileData {
  const ProfileData({
    required this.weightKg,
    required this.goal,
    required this.targetCalories,
    required this.targetProtein,
  });

  final int weightKg;
  final String goal;
  final int targetCalories;
  final int targetProtein;
}

class MealScanState {
  const MealScanState({
    this.imageBytes,
    this.fileName,
    this.analysis,
  });

  final Uint8List? imageBytes;
  final String? fileName;
  final MealAnalysis? analysis;

  MealScanState copyWith({
    Uint8List? imageBytes,
    String? fileName,
    MealAnalysis? analysis,
    bool clearImage = false,
  }) {
    return MealScanState(
      imageBytes: clearImage ? null : imageBytes ?? this.imageBytes,
      fileName: clearImage ? null : fileName ?? this.fileName,
      analysis: analysis ?? this.analysis,
    );
  }
}
