import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/pages/home_page.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';

void main() {
  testWidgets('home places metrics beside the chart in landscape', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(800, 360);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: HomePage()),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    final chart =
        tester.getRect(find.byKey(const ValueKey('home-training-chart')));
    final metrics = tester.getRect(find.byKey(const ValueKey('home-metrics')));
    final button = tester.getRect(find.byType(ButtonTile));
    expect(chart.left, lessThan(metrics.left));
    expect((chart.top - metrics.top).abs(), lessThan(1));
    expect(chart.height, inInclusiveRange(140, 220));
    expect(button.top, greaterThan(chart.bottom));
    final exception = tester.takeException();
    expect(exception, isNull, reason: '$exception');
  });
}
