import 'package:cinemapedia/ui/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Full screen loader', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FullScreenLoader()));
    expect(find.text('Please wait'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
  });
}
