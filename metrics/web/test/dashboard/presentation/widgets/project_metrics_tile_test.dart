import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/graphs/circle_percentage.dart';
import 'package:metrics/base/presentation/widgets/scorecard.dart';
import 'package:metrics/common/presentation/metrics_theme/config/dimensions_config.dart';
import 'package:metrics/dashboard/presentation/view_models/build_number_scorecard_view_model.dart';
import 'package:metrics/dashboard/presentation/view_models/build_result_metric_view_model.dart';
import 'package:metrics/dashboard/presentation/view_models/coverage_view_model.dart';
import 'package:metrics/dashboard/presentation/view_models/performance_sparkline_view_model.dart';
import 'package:metrics/dashboard/presentation/view_models/project_metrics_tile_view_model.dart';
import 'package:metrics/dashboard/presentation/view_models/stability_view_model.dart';
import 'package:metrics/dashboard/presentation/widgets/build_result_bar_graph.dart';
import 'package:metrics/dashboard/presentation/widgets/performance_sparkline_graph.dart';
import 'package:metrics/dashboard/presentation/widgets/project_metrics_tile.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils/dimensions_util.dart';
import '../../../test_utils/metrics_themed_testbed.dart';

void main() {
  group("ProjectMetricsTile", () {
    setUpAll(() {
      DimensionsUtil.setTestWindowSize(width: DimensionsConfig.contentWidth);
    });

    tearDownAll(() {
      DimensionsUtil.clearTestWindowSize();
    });

    final ProjectMetricsTileViewModel testProjectMetrics =
        ProjectMetricsTileViewModel(
      projectName: 'Test project name',
      coverage: const CoverageViewModel(value: 0.3),
      stability: const StabilityViewModel(value: 0.4),
      buildNumberMetric: const BuildNumberScorecardViewModel(numberOfBuilds: 3),
      performanceSparkline: PerformanceSparklineViewModel(
        performance: UnmodifiableListView([]),
      ),
      buildResultMetrics: BuildResultMetricViewModel(
        buildResults: UnmodifiableListView([]),
      ),
    );

    testWidgets(
      "throws an AssertionError if a projectMetrics parameter is null",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ProjectMetricsTileTestbed(
          projectMetrics: null,
        ));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "displays the project name even if it is very long",
      (WidgetTester tester) async {
        const ProjectMetricsTileViewModel metrics = ProjectMetricsTileViewModel(
          projectName:
              'Some very long name to display that may overflow on some screens but should be displayed properly. Also, this project name has a description that placed to the project name, but we still can display it properly with any overflows.',
        );

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(const _ProjectMetricsTileTestbed(
            projectMetrics: metrics,
          ));
        });

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      "displays the ProjectMetricsData even when the project name is null",
      (WidgetTester tester) async {
        const metrics = ProjectMetricsTileViewModel();

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(const _ProjectMetricsTileTestbed(
            projectMetrics: metrics,
          ));
        });

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      "contains coverage circle percentage",
      (WidgetTester tester) async {
        final coveragePercent = testProjectMetrics.coverage;
        final coverageText = '${(coveragePercent.value * 100).toInt()}%';

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(_ProjectMetricsTileTestbed(
            projectMetrics: testProjectMetrics,
          ));
        });
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(CirclePercentage, coverageText),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "contains stability circle percentage",
      (WidgetTester tester) async {
        final stabilityPercent = testProjectMetrics.coverage;
        final stabilityText = '${(stabilityPercent.value * 100).toInt()}%';

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(_ProjectMetricsTileTestbed(
            projectMetrics: testProjectMetrics,
          ));
        });
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(CirclePercentage, stabilityText),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "contains TextMetric with build number metric",
      (WidgetTester tester) async {
        final numberOfBuilds =
            testProjectMetrics.buildNumberMetric.numberOfBuilds;

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(_ProjectMetricsTileTestbed(
            projectMetrics: testProjectMetrics,
          ));
        });

        expect(
          find.widgetWithText(Scorecard, '$numberOfBuilds'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "contains SparklineGraph widgets with performance metric",
      (WidgetTester tester) async {
        await mockNetworkImagesFor(() {
          return tester.pumpWidget(_ProjectMetricsTileTestbed(
            projectMetrics: testProjectMetrics,
          ));
        });

        expect(
          find.byType(PerformanceSparklineGraph),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "contains the bar graph with the build results",
      (WidgetTester tester) async {
        await mockNetworkImagesFor(() {
          return tester.pumpWidget(_ProjectMetricsTileTestbed(
            projectMetrics: testProjectMetrics,
          ));
        });

        expect(find.byType(BuildResultBarGraph), findsOneWidget);
      },
    );
  });
}

/// A testbed class required to test the [ProjectMetricsTile] widget.
class _ProjectMetricsTileTestbed extends StatelessWidget {
  /// The [ProjectMetricsTileViewModel] instance to display.
  final ProjectMetricsTileViewModel projectMetrics;

  /// Creates an instance of this testbed with the given [projectMetrics].
  const _ProjectMetricsTileTestbed({
    Key key,
    this.projectMetrics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsThemedTestbed(
      body: ProjectMetricsTile(
        projectMetricsViewModel: projectMetrics,
      ),
    );
  }
}
