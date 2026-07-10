import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import 'glass_card.dart';

class NutritionCard extends StatelessWidget {
  const NutritionCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final int value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(
            '$value$unit',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
