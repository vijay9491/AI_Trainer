import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/animated_header.dart';
import '../../../core/widgets/glass_card.dart';
import '../../providers/app_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnimatedHeader(
                title: 'Profile',
                subtitle: 'Your health identity and core targets.',
              ),
              const SizedBox(height: AppSpacing.md),
              _ProfileItem(title: 'Weight', value: '${profile.weightKg}kg'),
              const SizedBox(height: AppSpacing.sm),
              _ProfileItem(title: 'Goal', value: profile.goal),
              const SizedBox(height: AppSpacing.sm),
              _ProfileItem(title: 'Target Calories', value: '${profile.targetCalories}'),
              const SizedBox(height: AppSpacing.sm),
              _ProfileItem(title: 'Target Protein', value: '${profile.targetProtein}g'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
