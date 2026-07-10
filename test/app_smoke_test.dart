import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthos_ai/core/widgets/glass_card.dart';

void main() {
  testWidgets('GlassCard renders child', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GlassCard(
            child: Text('HealthOS'),
          ),
        ),
      ),
    );

    expect(find.text('HealthOS'), findsOneWidget);
  });
}
