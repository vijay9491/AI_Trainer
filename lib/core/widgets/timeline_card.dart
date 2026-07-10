import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import 'glass_card.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    super.key,
    required this.timeLabel,
    required this.title,
    required this.summary,
    required this.icon,
  });

  final String timeLabel;
  final String title;
  final String summary;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(summary, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(timeLabel, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
