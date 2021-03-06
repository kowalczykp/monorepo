// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_circle_percentage_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/dashboard/presentation/widgets/strategy/metric_value_theme_strategy.dart';
import 'package:test/test.dart';

void main() {
  group("MetricValueThemeStrategy", () {
    final circlePercentageTheme = MetricCirclePercentageThemeData(
      lowPercentTheme: MetricWidgetThemeData(
        primaryColor: Colors.red[100],
        accentColor: Colors.red[200],
        backgroundColor: Colors.red[300],
      ),
      mediumPercentTheme: MetricWidgetThemeData(
        primaryColor: Colors.yellow[100],
        accentColor: Colors.yellow[200],
        backgroundColor: Colors.yellow[300],
      ),
      highPercentTheme: MetricWidgetThemeData(
        primaryColor: Colors.green[100],
        accentColor: Colors.green[200],
        backgroundColor: Colors.green[300],
      ),
    );
    final theme = MetricsThemeData(
      metricCirclePercentageThemeData: circlePercentageTheme,
      inactiveWidgetTheme: MetricWidgetThemeData(
        primaryColor: Colors.grey[100],
        accentColor: Colors.grey[200],
        backgroundColor: Colors.grey[300],
      ),
    );

    final themeStrategy = MetricValueThemeStrategy();

    test(
      "returns low percent theme if the given value is in bounds from 0.01 to 0.5",
      () {
        final lowerBoundTheme = themeStrategy.getWidgetTheme(
          theme,
          0.01,
        );

        final upperBoundTheme = themeStrategy.getWidgetTheme(
          theme,
          0.5,
        );

        expect(lowerBoundTheme, equals(circlePercentageTheme.lowPercentTheme));
        expect(upperBoundTheme, equals(circlePercentageTheme.lowPercentTheme));
      },
    );

    test(
      "returns medium percent theme if the given value is in bounds from 0.51 to 0.79",
      () {
        final lowerBoundTheme = themeStrategy.getWidgetTheme(
          theme,
          0.51,
        );

        final upperBoundTheme = themeStrategy.getWidgetTheme(
          theme,
          0.79,
        );

        expect(
          lowerBoundTheme,
          equals(circlePercentageTheme.mediumPercentTheme),
        );
        expect(
          upperBoundTheme,
          equals(circlePercentageTheme.mediumPercentTheme),
        );
      },
    );

    test(
      "returns high percent theme if the given value is grater or equals to 0.8",
      () {
        final lowerBoundTheme = themeStrategy.getWidgetTheme(
          theme,
          0.8,
        );

        final upperBoundTheme = themeStrategy.getWidgetTheme(
          theme,
          1.0,
        );

        expect(lowerBoundTheme, equals(circlePercentageTheme.highPercentTheme));
        expect(upperBoundTheme, equals(circlePercentageTheme.highPercentTheme));
      },
    );

    test(
      "returns inactive theme if the given value is equals to 0",
      () {
        final widgetTheme = themeStrategy.getWidgetTheme(
          theme,
          0.0,
        );

        expect(widgetTheme, equals(theme.inactiveWidgetTheme));
      },
    );
  });
}
