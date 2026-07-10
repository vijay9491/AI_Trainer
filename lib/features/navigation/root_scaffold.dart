import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScaffold extends StatelessWidget {
  const RootScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  static const _tabs = ['/dashboard', '/timeline', '/coach', '/profile'];

  int _indexFromLocation(String location) {
    if (location.startsWith('/timeline')) return 1;
    if (location.startsWith('/coach')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_tabs[index]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.timeline_rounded), label: 'Timeline'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_rounded), label: 'Coach'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
