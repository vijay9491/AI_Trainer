import 'package:flutter/material.dart';

import '../../features/models/health_models.dart';
import '../constants/app_spacing.dart';
import 'glass_card.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF3CD), Color(0xFFFFE082)],
              ),
            ),
            child: const Icon(Icons.local_dining_rounded),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: Theme.of(context).textTheme.titleMedium),
                Text(food.serving, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            '${food.calories} kcal',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
