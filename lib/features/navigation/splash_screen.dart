import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/widgets/animated_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2300), () {
      if (mounted) context.go('/dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C853), Color(0xFF8FE08F)],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x5500C853),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 44),
              )
                  .animate()
                  .scale(duration: 900.ms, curve: Curves.easeOutBack)
                  .then()
                  .shimmer(duration: 1200.ms, color: Colors.white.withValues(alpha: 0.6)),
              const SizedBox(height: AppSpacing.lg),
              Text('HealthOS AI', style: Theme.of(context).textTheme.headlineLarge)
                  .animate()
                  .fadeIn(duration: 600.ms),
              const SizedBox(height: AppSpacing.xs),
              Text('Your Personal AI Health Coach',
                      style: Theme.of(context).textTheme.bodyLarge)
                  .animate(delay: 250.ms)
                  .fadeIn(duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
