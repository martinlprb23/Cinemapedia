import 'package:cinemapedia/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Custom appbar ...', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: CustomAppBar()),
      ),
    );

    expect(find.text('Cinemapedia'), findsOneWidget);

    // final element = tester.element(find.byType(CustomAppBar));
    //final container = ProviderScope.containerOf(element);

    // await tester.tap(find.byType(IconButton));
    // await tester.pumpAndSettle();

    // expect(
    //   container.read(searcherMoviesprovider),
    //   'some value',
    // );
  });
}
