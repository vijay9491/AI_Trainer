import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/health_models.dart';
import '../services/mock_ai_service.dart';

final mockAiServiceProvider = Provider<MockAiService>((ref) => MockAiService());
final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

final healthScoreProvider = StateProvider<int>((ref) => 87);
final coachMessageIndexProvider = StateProvider<int>((ref) => 0);

final profileProvider = Provider<ProfileData>(
  (ref) => const ProfileData(
    weightKg: 62,
    goal: 'Lean Muscle Gain',
    targetCalories: 2600,
    targetProtein: 120,
  ),
);

final dashboardMetricsProvider = Provider<List<HealthMetric>>((ref) {
  return const <HealthMetric>[
    HealthMetric(label: 'Meal', value: '2/3', progress: 0.66, icon: Icons.restaurant_rounded),
    HealthMetric(label: 'Workout', value: '45m', progress: 0.7, icon: Icons.fitness_center_rounded),
    HealthMetric(label: 'Water', value: '2.1L', progress: 0.58, icon: Icons.water_drop_rounded),
    HealthMetric(label: 'Sleep', value: '6h 40m', progress: 0.8, icon: Icons.bedtime_rounded),
    HealthMetric(label: 'Weight', value: '62kg', progress: 0.72, icon: Icons.monitor_weight_rounded),
  ];
});

class TimelineNotifier extends StateNotifier<List<TimelineEvent>> {
  TimelineNotifier() : super(_seedTimeline);

  static final _seedTimeline = <TimelineEvent>[
    TimelineEvent(
      time: DateTime.now().subtract(const Duration(hours: 1)),
      title: 'Breakfast',
      summary: 'Oats + milk + banana',
      icon: Icons.wb_sunny_rounded,
      type: TimelineType.meal,
    ),
    TimelineEvent(
      time: DateTime.now().subtract(const Duration(hours: 3)),
      title: 'Workout',
      summary: 'Strength training, 45 mins',
      icon: Icons.fitness_center_rounded,
      type: TimelineType.workout,
    ),
    TimelineEvent(
      time: DateTime.now().subtract(const Duration(hours: 5)),
      title: 'Hydration',
      summary: 'Drank 500 ml water',
      icon: Icons.water_drop_rounded,
      type: TimelineType.water,
    ),
    TimelineEvent(
      time: DateTime.now().subtract(const Duration(hours: 8)),
      title: 'Sleep',
      summary: 'Slept 6h 40m with good recovery',
      icon: Icons.bedtime_rounded,
      type: TimelineType.sleep,
    ),
  ];

  void addMealEvent(MealAnalysis analysis) {
    state = [
      TimelineEvent(
        time: DateTime.now(),
        title: 'Meal Added',
        summary: '${analysis.nutrition.calories} kcal • Score ${analysis.healthScore}',
        icon: Icons.restaurant_menu_rounded,
        type: TimelineType.meal,
      ),
      ...state,
    ];
  }
}

final timelineProvider =
    StateNotifierProvider<TimelineNotifier, List<TimelineEvent>>((ref) {
      return TimelineNotifier();
    });

class MealScanNotifier extends StateNotifier<MealScanState> {
  MealScanNotifier(this._picker, this._aiService)
      : super(const MealScanState());

  final ImagePicker _picker;
  final MockAiService _aiService;

  Future<bool> pickFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      imageQuality: 88,
    );
    if (file == null) return false;
    final bytes = await file.readAsBytes();
    state = state.copyWith(imageBytes: bytes, fileName: file.name);
    return true;
  }

  Future<void> runMealAnalysis() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    state = state.copyWith(analysis: _aiService.analyzeMeal());
  }

  void clear() {
    state = const MealScanState();
  }
}

final mealScanProvider =
    StateNotifierProvider<MealScanNotifier, MealScanState>((ref) {
      return MealScanNotifier(
        ref.watch(imagePickerProvider),
        ref.watch(mockAiServiceProvider),
      );
    });

final randomCoachProvider = Provider<String>((ref) {
  final index = ref.watch(coachMessageIndexProvider);
  return ref.watch(mockAiServiceProvider).getCoachMessage(index);
});

final mockParticlesProvider = Provider<List<Offset>>((ref) {
  final random = Random(42);
  return List<Offset>.generate(
    24,
    (_) => Offset(random.nextDouble(), random.nextDouble()),
  );
});

final greetingProvider = Provider<String>((ref) {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning Vijay';
  if (hour < 18) return 'Good Afternoon Vijay';
  return 'Good Evening Vijay';
});
