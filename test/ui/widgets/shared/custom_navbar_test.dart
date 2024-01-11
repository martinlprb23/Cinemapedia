import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinemapedia/ui/widgets/shared/custom_navbar.dart';

void main() {
  testWidgets('custom navbar ...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CustomBottomNav(currentIndex: 1),
    ));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    await tester.pump();
  });
}
