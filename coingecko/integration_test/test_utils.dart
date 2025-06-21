import 'package:coingecko/main.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUtils {
  static Future<void> triggerFrameAtInterval(
    WidgetTester tester, {
    Duration duration = const Duration(seconds: 10),
    Duration interval = const Duration(milliseconds: 300),
  }) async {
    final end = DateTime.now().add(duration);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(interval);
    }
    return;
  }

  static Future<void> launchMainScreen(WidgetTester tester) async {
    await tester.pump();
    await tester.pumpWidget(const MainApp());
    await TestUtils.triggerFrameAtInterval(
      tester,
      duration: const Duration(seconds: 10),
    );
  }
}
