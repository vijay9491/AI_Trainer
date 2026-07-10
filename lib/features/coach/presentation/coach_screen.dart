import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/animated_header.dart';
import '../../../core/widgets/coach_bubble.dart';
import '../../providers/app_providers.dart';

class CoachScreen extends ConsumerWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final coachMessage = ref.watch(randomCoachProvider);
    final index = ref.watch(coachMessageIndexProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(coachMessageIndexProvider.notifier).state = index + 1;
        },
        label: const Text('New Tip'),
        icon: const Icon(Icons.auto_awesome_rounded),
      ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnimatedHeader(
                title: 'AI Coach',
                subtitle: 'Personalized guidance based on your goals.',
              ),
              const SizedBox(height: AppSpacing.md),
              CoachBubble(
                message:
                    'Great job today, Vijay. Your protein target is ${profile.targetProtein}g.',
              ).animate().fadeIn(duration: 450.ms),
              const SizedBox(height: AppSpacing.sm),
              CoachBubble(message: coachMessage).animate().fadeIn(delay: 140.ms, duration: 450.ms),
              const SizedBox(height: AppSpacing.sm),
              const CoachBubble(
                message: 'Keep your dinner high-fiber to improve fullness and recovery.',
              ).animate().fadeIn(delay: 240.ms, duration: 450.ms),
            ],
          ),
        ),
      ),
    );
  }
}
