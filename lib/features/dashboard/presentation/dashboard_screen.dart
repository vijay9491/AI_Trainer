import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/animated_background.dart';
import '../../../core/widgets/animated_header.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/health_ring.dart';
import '../../../core/widgets/metric_card.dart';
import '../../providers/app_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(greetingProvider);
    final score = ref.watch(healthScoreProvider);
    final metrics = ref.watch(dashboardMetricsProvider);

    return AnimatedGradientBackground(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              sliver: SliverList.list(
                children: [
                  AnimatedHeader(
                    title: greeting,
                    subtitle: 'Let\'s make today healthier than yesterday.',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Center(child: HealthRing(score: score)),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Today\'s Timeline', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: metrics.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: 1.25,
                    ),
                    itemBuilder: (_, index) =>
                        MetricCard(metric: metrics[index], index: index),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  _ActionRow(
                    onScanMeal: () => context.push('/scan'),
                    onLogWorkout: () => context.go('/timeline'),
                    onWater: () => context.go('/timeline'),
                    onProgress: () => context.go('/timeline'),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  GradientButton(
                    label: 'Scan Meal',
                    icon: Icons.camera_alt_rounded,
                    onPressed: () => context.push('/scan'),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 450.ms);
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.onScanMeal,
    required this.onLogWorkout,
    required this.onWater,
    required this.onProgress,
  });

  final VoidCallback onScanMeal;
  final VoidCallback onLogWorkout;
  final VoidCallback onWater;
  final VoidCallback onProgress;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _ChipButton(label: 'Scan Meal', icon: Icons.document_scanner_rounded, onTap: onScanMeal),
        _ChipButton(label: 'Log Workout', icon: Icons.fitness_center_rounded, onTap: onLogWorkout),
        _ChipButton(label: 'Drink Water', icon: Icons.water_drop_rounded, onTap: onWater),
        _ChipButton(label: 'View Progress', icon: Icons.monitor_heart_outlined, onTap: onProgress),
      ],
    );
  }
}

class _ChipButton extends StatelessWidget {
  const _ChipButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
      side: BorderSide.none,
      elevation: 0,
    );
  }
}
