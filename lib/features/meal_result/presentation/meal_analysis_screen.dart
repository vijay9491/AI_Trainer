import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/loading_animation.dart';
import '../../providers/app_providers.dart';

class MealAnalysisScreen extends ConsumerStatefulWidget {
  const MealAnalysisScreen({super.key});

  @override
  ConsumerState<MealAnalysisScreen> createState() => _MealAnalysisScreenState();
}

class _MealAnalysisScreenState extends ConsumerState<MealAnalysisScreen> {
  static const _messages = <String>[
    'Analyzing your meal...',
    'Detecting ingredients...',
    'Calculating calories...',
    'Estimating nutrition...',
    'Generating insights...',
  ];

  int _index = 0;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 560), (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % _messages.length);
    });
    Future<void>.microtask(() async {
      await ref.read(mealScanProvider.notifier).runMealAnalysis();
      if (mounted) context.go('/meal-result');
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimation(text: _messages[_index]),
      ),
    );
  }
}
