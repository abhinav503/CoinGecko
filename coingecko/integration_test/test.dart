import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:coingecko/main.dart' as app;
import 'test_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    app.main(["testEnv"]);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group("CoinGecko", () {
    testWidgets("Launch Home Screen ", (WidgetTester tester) async {
      await TestUtils.launchMainScreen(tester);
      await tester.tap(find.byKey(const Key("custom_tabbar_text_0")));
      await TestUtils.triggerFrameAtInterval(
        tester,
        duration: const Duration(seconds: 5),
      );
      await tester.tap(find.byKey(const Key("custom_tabbar_text_1")));
      await TestUtils.triggerFrameAtInterval(
        tester,
        duration: const Duration(seconds: 5),
      );
      await tester.tap(find.byKey(const Key("custom_tabbar_text_0")));
      await TestUtils.triggerFrameAtInterval(
        tester,
        duration: const Duration(seconds: 5),
      );
      
      // Ensure proper disposal
      await tester.pumpAndSettle();
    });

    testWidgets("Launch Coin Details Screen ", (WidgetTester tester) async {
      await TestUtils.launchMainScreen(tester);
      await tester.tap(find.byKey(const Key("coin_item_widget_0")));
      await TestUtils.triggerFrameAtInterval(
        tester,
        duration: const Duration(seconds: 8),
      );

      // Ensure proper disposal
      await tester.pumpAndSettle();
    });
  });

  tearDownAll(() async {
    // Ensure proper cleanup
    await Future.delayed(const Duration(milliseconds: 100));
  });
}
