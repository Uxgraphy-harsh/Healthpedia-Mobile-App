// Basic smoke test for Healthpedia app.
import 'package:flutter_test/flutter_test.dart';

import 'package:healthpedia_frontend/main.dart';

void main() {
  testWidgets('App renders SplashScreen smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const HealthpediaApp());

    // The splash screen should be rendered without errors.
    // More specific widget tests will be added per-screen.
    expect(tester.takeException(), isNull);
  });
}
