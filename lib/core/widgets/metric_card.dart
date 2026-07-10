import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../features/models/health_models.dart';
import '../constants/app_spacing.dart';
import 'glass_card.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.metric,
    required this.index,
  });

  final HealthMetric metric;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(metric.icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const Spacer(),
          Text(metric.label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            metric.value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          LinearProgressIndicator(
            value: metric.progress,
            borderRadius: BorderRadius.circular(100),
            minHeight: 6,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: index * 70), duration: 450.ms)
        .slideY(
          begin: 0.08,
          end: 0,
          delay: Duration(milliseconds: index * 70),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
