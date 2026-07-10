import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../coach/presentation/coach_screen.dart';
import '../dashboard/presentation/dashboard_screen.dart';
import '../meal_result/presentation/meal_analysis_screen.dart';
import '../meal_result/presentation/meal_result_screen.dart';
import '../meal_scan/presentation/meal_scan_screen.dart';
import '../profile/presentation/profile_screen.dart';
import '../progress/presentation/timeline_screen.dart';
import 'root_scaffold.dart';
import 'splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => RootScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/timeline',
            builder: (context, state) => const TimelineScreen(),
          ),
          GoRoute(
            path: '/coach',
            builder: (context, state) => const CoachScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => const MealScanScreen(),
      ),
      GoRoute(
        path: '/analysis',
        builder: (context, state) => const MealAnalysisScreen(),
      ),
      GoRoute(
        path: '/meal-result',
        builder: (context, state) => const MealResultScreen(),
      ),
    ],
  );
});
