import 'dart:math';

import '../models/health_models.dart';

class MockAiService {
  final Random _random = Random();

  static const _coachMessages = <String>[
    'You still need 30g protein today. Add a lean snack.',
    'Drink 800ml more water to hit your hydration target.',
    'Great consistency. Your recovery trend is improving.',
    'Add 15 minutes of light cardio after dinner today.',
    'Your macros are balanced. Keep this rhythm going.',
  ];

  MealAnalysis analyzeMeal() {
    const foods = <FoodItem>[
      FoodItem(name: 'Paneer', serving: '120g', calories: 320),
      FoodItem(name: 'Rice', serving: '180g', calories: 230),
      FoodItem(name: 'Dal', serving: '150g', calories: 180),
      FoodItem(name: 'Milk', serving: '250ml', calories: 140),
      FoodItem(name: 'Banana', serving: '1 medium', calories: 105),
    ];

    return MealAnalysis(
      foods: foods.sublist(0, 3 + _random.nextInt(2)),
      nutrition: NutritionData(
        calories: 780 + _random.nextInt(160),
        protein: 35 + _random.nextInt(14),
        carbs: 86 + _random.nextInt(20),
        fat: 18 + _random.nextInt(10),
        fiber: 8 + _random.nextInt(7),
      ),
      healthScore: 78 + _random.nextInt(19),
      insight:
          'Excellent protein source. Low in fiber. Consider adding vegetables.',
    );
  }

  String getCoachMessage(int seed) {
    return _coachMessages[seed % _coachMessages.length];
  }
}
