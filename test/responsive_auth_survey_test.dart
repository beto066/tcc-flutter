import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/pages/login_page.dart';
import 'package:tccflutter/pages/register_page.dart';
import 'package:tccflutter/widgets/molecules/survey_dialog.dart';

void main() {
  Future<void> setLandscapeSize(WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(800, 280);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Widget appWith(Widget child) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      );

  testWidgets('login fits and can scroll in landscape', (tester) async {
    await setLandscapeSize(tester);
    await tester.pumpWidget(appWith(const LoginPage()));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
    final scrollView = find.byType(SingleChildScrollView);
    expect(scrollView, findsOneWidget);
    expect(
      find.descendant(of: scrollView, matching: find.byType(Form)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: scrollView, matching: find.byType(Image)),
      findsNothing,
    );
    final formScroll = tester.state<ScrollableState>(
      find.descendant(of: scrollView, matching: find.byType(Scrollable)).first,
    );
    expect(formScroll.position.maxScrollExtent, greaterThan(0));
    expect(tester.takeException(), isNull);
  });

  testWidgets('registration fits and can scroll in landscape', (tester) async {
    await setLandscapeSize(tester);
    await tester.pumpWidget(appWith(const RegisterPage()));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(4));
    final scrollView = find.byType(SingleChildScrollView);
    expect(scrollView, findsOneWidget);
    expect(
      find.descendant(of: scrollView, matching: find.byType(Form)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: scrollView, matching: find.byType(Image)),
      findsNothing,
    );
    final formScroll = tester.state<ScrollableState>(
      find.descendant(of: scrollView, matching: find.byType(Scrollable)).first,
    );
    expect(formScroll.position.maxScrollExtent, greaterThan(0));
    expect(tester.takeException(), isNull);
  });

  testWidgets('survey dialog is scrollable in landscape', (tester) async {
    await setLandscapeSize(tester);
    await tester.pumpWidget(
      appWith(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => SurveyDialog.showSurveyDialog(context, Patient()),
            child: const Text('Open survey'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open survey'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    final dialog = find.byType(AlertDialog);
    final scrollable = tester.state<ScrollableState>(
      find.descendant(
        of: dialog,
        matching: find.byType(Scrollable),
      ),
    );
    expect(scrollable.position.maxScrollExtent, greaterThan(0));
    expect(tester.getRect(dialog).bottom, lessThanOrEqualTo(280));
    expect(tester.takeException(), isNull);
  });
}
