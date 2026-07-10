import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/food_card.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/nutrition_card.dart';
import '../../providers/app_providers.dart';

class MealResultScreen extends ConsumerWidget {
  const MealResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mealScanProvider);
    final analysis = state.analysis;
    if (analysis == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Meal Result')),
        body: const Center(child: Text('No meal analysis available yet.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('AI Meal Analysis')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'meal-image',
                child: GlassCard(
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius - 6),
                      child: state.imageBytes != null
                          ? Image.memory(state.imageBytes!, fit: BoxFit.cover)
                          : const ColoredBox(color: Color(0x1100C853)),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.98, 0.98)),
              const SizedBox(height: AppSpacing.lg),
              Text('Detected Foods', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              ...analysis.foods.map(
                (food) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: FoodCard(food: food),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Nutrition Summary', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NutritionCard(label: 'Calories', value: analysis.nutrition.calories, unit: ''),
                  NutritionCard(label: 'Protein', value: analysis.nutrition.protein, unit: 'g'),
                  NutritionCard(label: 'Carbs', value: analysis.nutrition.carbs, unit: 'g'),
                  NutritionCard(label: 'Fat', value: analysis.nutrition.fat, unit: 'g'),
                  NutritionCard(label: 'Fiber', value: analysis.nutrition.fiber, unit: 'g'),
                  NutritionCard(label: 'Score', value: analysis.healthScore, unit: '%'),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Insight', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(analysis.insight, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientButton(
                label: 'Add to Timeline',
                icon: Icons.timeline_rounded,
                onPressed: () {
                  ref.read(timelineProvider.notifier).addMealEvent(analysis);
                  ref.read(mealScanProvider.notifier).clear();
                  context.go('/timeline');
                },
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
