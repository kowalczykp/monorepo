import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/graphs/circle_percentage.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/dashboard/presentation/view_models/percent_view_model.dart';
import 'package:metrics/dashboard/presentation/widgets/no_data_placeholder.dart';
import 'package:metrics/dashboard/presentation/widgets/strategy/metric_value_theme_strategy.dart';
import 'package:metrics/dashboard/presentation/widgets/themed_circle_percentage.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/metrics_themed_testbed.dart';

void main() {
  group("ThemedCirclePercentage", () {
    testWidgets(
      "can't be with null percent value",
      (tester) async {
        await tester.pumpWidget(
          const _ThemedCirclePercentageTestbed(percent: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "applies the colors from the MetricWidgetThemeData given by theme strategy",
      (tester) async {
        const metricWidgetTheme = MetricWidgetThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.blue,
          backgroundColor: Colors.white,
        );
        final themeStrategy = CirclePercentageThemeStrategyMock();

        when(themeStrategy.getWidgetTheme(any, any))
            .thenReturn(metricWidgetTheme);

        await tester.pumpWidget(_ThemedCirclePercentageTestbed(
          strategy: themeStrategy,
        ));

        final circlePercentageWidget =
            tester.widget<CirclePercentage>(find.byType(CirclePercentage));

        expect(
          circlePercentageWidget.valueColor,
          metricWidgetTheme.primaryColor,
        );
        expect(
          circlePercentageWidget.strokeColor,
          metricWidgetTheme.accentColor,
        );
        expect(
          circlePercentageWidget.backgroundColor,
          metricWidgetTheme.backgroundColor,
        );
      },
    );

    testWidgets(
      "can't be created with null themeStrategy",
      (tester) async {
        await tester.pumpWidget(const _ThemedCirclePercentageTestbed(
          strategy: null,
        ));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "displays the no data placeholder if percent value is null",
      (tester) async {
        const percent = PercentViewModel(null);

        await tester.pumpWidget(const _ThemedCirclePercentageTestbed(
          percent: percent,
        ));

        expect(find.byType(NoDataPlaceholder), findsOneWidget);
      },
    );
  });
}

/// A testbed class required for testing the [ThemedCirclePercentage].
class _ThemedCirclePercentageTestbed extends StatelessWidget {
  /// A [MetricValueThemeStrategy] used to chose the theme to use in widget.
  final MetricValueThemeStrategy strategy;

  /// A [PercentViewModel] instance to display.
  final PercentViewModel percent;

  /// Creates this testbed instance with the given [percent] value and theme [strategy].
  ///
  /// The [percent] defaults to the [PercentViewModel] instance with value equals to `1.0`.
  /// The [strategy] defaults to the [MetricValueThemeStrategy].
  const _ThemedCirclePercentageTestbed({
    Key key,
    this.percent = const PercentViewModel(1.0),
    this.strategy = const MetricValueThemeStrategy(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsThemedTestbed(
      body: ThemedCirclePercentage(
        percent: percent,
        themeStrategy: strategy,
      ),
    );
  }
}

class CirclePercentageThemeStrategyMock extends Mock
    implements MetricValueThemeStrategy {}
