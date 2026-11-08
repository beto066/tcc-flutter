import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/pages/note_pad_page.dart';

void main() {
  Widget createApp() => MaterialApp(
        locale: const Locale('pt', 'BR'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: NotePadPage(patient: Patient()),
        ),
      );

  testWidgets('does not add empty or whitespace-only text', (tester) async {
    await tester.pumpWidget(createApp());

    await tester.tap(find.byTooltip('Adicionar texto'));
    await tester.pumpAndSettle();

    expect(find.text('O campo não pode ficar vazio'), findsOneWidget);
    expect(find.text('Digite o texto'), findsOneWidget);
    expect(find.byType(InputDecorator), findsOneWidget);
    expect(tester.widget<TextFormField>(find.byType(TextFormField)).validator,
        isNull);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Adicionar texto'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.tap(find.byTooltip('Adicionar texto'));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('adds trimmed text and keeps focus in the input', (tester) async {
    await tester.pumpWidget(createApp());

    await tester.enterText(find.byType(TextFormField), '  Anotação  ');
    final inputFocus = FocusManager.instance.primaryFocus;
    await tester.tap(find.byTooltip('Adicionar texto'));
    await tester.pumpAndSettle();

    expect(find.text('Anotação'), findsOneWidget);
    expect(FocusManager.instance.primaryFocus, same(inputFocus));
  });

  testWidgets('list action adds text and keeps focus in the input', (
    tester,
  ) async {
    await tester.pumpWidget(createApp());

    await tester.enterText(find.byType(TextFormField), 'Texto pela lista');
    final inputFocus = FocusManager.instance.primaryFocus;
    await tester.tap(find.text('Adicionar texto'));
    await tester.pumpAndSettle();

    expect(find.text('Texto pela lista'), findsOneWidget);
    expect(FocusManager.instance.primaryFocus, same(inputFocus));
  });
}
