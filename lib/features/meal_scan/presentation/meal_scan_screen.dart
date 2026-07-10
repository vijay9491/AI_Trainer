import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/glass_card.dart';
import '../../providers/app_providers.dart';

class MealScanScreen extends ConsumerWidget {
  const MealScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mealScanProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Meal')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              const _CameraMockFrame(),
              const SizedBox(height: AppSpacing.lg),
              if (state.imageBytes != null)
                Expanded(
                  child: Hero(
                    tag: 'meal-image',
                    child: GlassCard(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius - 6),
                        child: Image.memory(state.imageBytes!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text('Pick a meal image from gallery to continue'),
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              GradientButton(
                label: state.imageBytes == null ? 'Select from Gallery' : 'Analyze Meal',
                icon: Icons.photo_library_rounded,
                onPressed: () async {
                  if (state.imageBytes == null) {
                    final ok = await ref.read(mealScanProvider.notifier).pickFromGallery();
                    if (!ok && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No image selected')),
                      );
                    }
                    return;
                  }
                  if (context.mounted) context.push('/analysis');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraMockFrame extends StatefulWidget {
  const _CameraMockFrame();

  @override
  State<_CameraMockFrame> createState() => _CameraMockFrameState();
}

class _CameraMockFrameState extends State<_CameraMockFrame>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius - 4),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.16),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            ...List<Widget>.generate(14, (index) {
              final random = Random(index * 9);
              return Positioned(
                left: random.nextDouble() * 310,
                top: random.nextDouble() * 200,
                child: Container(
                  width: 4 + random.nextDouble() * 4,
                  height: 4 + random.nextDouble() * 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Positioned(
                  left: 10,
                  right: 10,
                  top: 10 + (_controller.value * 180),
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Theme.of(context).colorScheme.primary,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: const Padding(
                padding: EdgeInsets.all(AppSpacing.sm),
                child: Text('AI Camera Frame (Mock)'),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.98, 0.98));
  }
}
