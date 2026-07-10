import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import 'glass_card.dart';

class CoachBubble extends StatelessWidget {
  const CoachBubble({
    super.key,
    required this.message,
    this.isAi = true,
  });

  final String message;
  final bool isAi;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: GlassCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAi)
                const CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.smart_toy_outlined, size: 18),
                ),
              if (isAi) const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
