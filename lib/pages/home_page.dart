import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/stores/patient_store.dart';
import 'package:tccflutter/widgets/atoms/associative_label.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';
import 'package:tccflutter/widgets/molecules/bottom_links.dart';
import 'package:tccflutter/widgets/molecules/chart.dart';
import 'package:tccflutter/util/training_result_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Map<String, double>? statistics;
  double? countNotes;
  double? countPatients;
  double? countWeeklyNotes;

  String? statisticsErrorMessage;
  String? patientsErrorMessage;

  void _redirectToPatients() {
    Navigator.of(context).pushNamed('Patients');
  }

  void _redirectToNotes() {
    Navigator.of(context).pushNamed('Notes');
  }

  void _redirectToConfig() {
    Navigator.of(context).pushNamed('Configurations');
  }

  Future<Map<String, double>> _fetchStatistics() async {
    final localization = AppLocalizations.of(context)!;
    try {
      statisticsErrorMessage = null;

      if (statistics == null) {
        statistics = await NoteStore().fetchStatistics();
      } else {
        statistics = NoteStore().statistics ?? {};
      }

      return statistics!.map((key, value) {
        final normalizedKey = key.trim().toLowerCase();
        final localizedKey = normalizedKey == 'average' ||
                normalizedKey == 'media' ||
                normalizedKey == 'promedio'
            ? localization.average_short
            : localizedTrainingStatisticLabel(key, localization);
        return MapEntry(localizedKey, value);
      });
    } on UnauthorizedException {
      await _logout();
      return {};
    } catch (e) {
      statisticsErrorMessage = e.toString();
      return {};
    }
  }

  Future<double?> _fetchCountPatients() async {
    if (countPatients != null) {
      return countPatients;
    }

    return PatientStore().fetchCountPatients();
  }

  Future<double?> _fetchCountNotes() async {
    if (countNotes != null) {
      return countNotes;
    }

    return NoteStore().fetchCountNotes();
  }

  Future<double?> _fetchWeeklyCountNotes() async {
    if (countWeeklyNotes != null) {
      return countWeeklyNotes;
    }

    return NoteStore().fetchCountWeeklyNotes();
  }

  Future<void> _logout() async {
    final navigator = Navigator.of(context);
    await AuthStore().logout();

    if (!Navigator.of(context).mounted) return;

    await navigator.popAndPushNamed('Login');
  }

  Widget _buildTrainingChart(
    BuildContext context, {
    required AppLocalizations localization,
    required Color inversePrimary,
    required double chartHeight,
  }) {
    return ConstrainedBox(
      key: const ValueKey('home-training-chart'),
      constraints: BoxConstraints(
        minHeight: chartHeight,
        maxHeight: chartHeight,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: inversePrimary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              localization.home_training_chart_title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              localization.home_training_chart_description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Expanded(
              child: FutureBuilder<Map<String, double>>(
                future: _fetchStatistics(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && statisticsErrorMessage == null) {
                    final allZero =
                        snapshot.data!.values.every((value) => value == 0);

                    if (allZero) {
                      return Center(child: Text(localization.no_data));
                    }

                    return Chart(
                      inversePrimary: inversePrimary,
                      statistics: snapshot.data!,
                    );
                  }
                  if (snapshot.hasError || statisticsErrorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        '${localization.error_prefix}: '
                        '${statisticsErrorMessage ?? snapshot.error}',
                      ),
                    );
                  }

                  return const Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(
    BuildContext context, {
    required String label,
    required Future<double?> future,
  }) {
    final localization = AppLocalizations.of(context)!;

    return FutureBuilder<double?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AssociativeLabel(
            label: label,
            data: '${snapshot.data!.toInt()}',
          );
        }
        if (snapshot.hasError) {
          return Text(
            '${localization.error_prefix}: ${snapshot.error}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          );
        }
        return AssociativeLabel(label: label, data: '?');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final inversePrimary = Theme.of(context).colorScheme.inversePrimary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final chartHeight =
            (constraints.maxHeight * (isLandscape ? 0.42 : 0.34))
                .clamp(140.0, isLandscape ? 220.0 : 320.0)
                .toDouble();
        final metrics = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMetric(
              context,
              label: localization.weekly_notes,
              future: _fetchWeeklyCountNotes(),
            ),
            const SizedBox(height: 8),
            _buildMetric(
              context,
              label: localization.patients,
              future: _fetchCountPatients(),
            ),
            const SizedBox(height: 8),
            _buildMetric(
              context,
              label: localization.notes_quantity,
              future: _fetchCountNotes(),
            ),
          ],
        );

        return SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 24 : 12,
                  vertical: isLandscape ? 8 : 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localization.home,
                      style: TextStyle(
                        fontSize: (constraints.maxHeight * 0.05).clamp(18, 30),
                      ),
                    ),
                    if (isLandscape)
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildTrainingChart(
                              context,
                              localization: localization,
                              inversePrimary: inversePrimary,
                              chartHeight: chartHeight,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 2,
                            child: ConstrainedBox(
                              key: const ValueKey('home-metrics'),
                              constraints: BoxConstraints(
                                minHeight: chartHeight,
                                maxHeight: chartHeight,
                              ),
                              child: metrics,
                            ),
                          ),
                        ],
                      )
                    else ...[
                      _buildTrainingChart(
                        context,
                        localization: localization,
                        inversePrimary: inversePrimary,
                        chartHeight: chartHeight,
                      ),
                      Padding(
                        key: const ValueKey('home-metrics'),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: metrics,
                      ),
                    ],
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        SizedBox(
                          width:
                              isLandscape ? 360 : constraints.maxWidth * 0.85,
                          child: ButtonTile(
                            localization.patients,
                            padding: 8,
                            onTap: _redirectToPatients,
                          ),
                        ),
                        const SizedBox(height: 8),
                        BottomLinks(
                          logout: _logout,
                          toConfig: _redirectToConfig,
                          toNotes: _redirectToNotes,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
