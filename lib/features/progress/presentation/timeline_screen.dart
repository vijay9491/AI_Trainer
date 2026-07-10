import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/animated_header.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/timeline_card.dart';
import '../../providers/app_providers.dart';
import '../../utils/date_utils.dart';

class TimelineScreen extends ConsumerWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(timelineProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              const AnimatedHeader(
                title: 'Today\'s Timeline',
                subtitle: 'Track every meal, movement, and recovery moment.',
              ),
              const SizedBox(height: AppSpacing.md),
              if (events.isEmpty)
                const Expanded(
                  child: EmptyState(
                    title: 'No events yet',
                    subtitle: 'Start by scanning a meal or logging an activity.',
                    icon: Icons.timeline_rounded,
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: events.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, index) {
                      final event = events[index];
                      return TimelineCard(
                        timeLabel: formatTime(event.time),
                        title: event.title,
                        summary: event.summary,
                        icon: event.icon,
                      ).animate().fadeIn(
                            delay: Duration(milliseconds: index * 70),
                            duration: 450.ms,
                          );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
