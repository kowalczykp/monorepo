import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/button/theme/attention_level/metrics_button_attention_level.dart';
import 'package:metrics/common/presentation/button/theme/style/metrics_button_style.dart';
import 'package:metrics/common/presentation/button/theme/theme_data/metrics_button_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/build_results_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/delete_dialog_theme_data.dart';
import 'package:metrics/common/presentation/dropdown/theme/theme_data/dropdown_item_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/dropdown_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/login_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_circle_percentage_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/project_group_card_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/project_group_dialog_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/text_field_theme_data.dart';
import 'package:test/test.dart';

void main() {
  group("MetricsThemeData", () {
    test(
      "creates a theme with the default theme data for metric widgets if the parameters is not specified",
      () {
        const themeData = MetricsThemeData();

        expect(themeData.metricCirclePercentageThemeData, isNotNull);
        expect(themeData.metricWidgetTheme, isNotNull);
        expect(themeData.inactiveWidgetTheme, isNotNull);
        expect(themeData.buildResultTheme, isNotNull);
        expect(themeData.deleteDialogTheme, isNotNull);
        expect(themeData.projectGroupDialogTheme, isNotNull);
        expect(themeData.projectGroupCardTheme, isNotNull);
        expect(themeData.addProjectGroupCardTheme, isNotNull);
        expect(themeData.metricsButtonTheme, isNotNull);
        expect(themeData.textFieldTheme, isNotNull);
        expect(themeData.dropdownTheme, isNotNull);
        expect(themeData.dropdownItemTheme, isNotNull);
        expect(themeData.loginTheme, isNotNull);
      },
    );

    test(
      "creates a theme with the default metric widgets theme data if nulls are passed",
      () {
        const themeData = MetricsThemeData(
          metricCirclePercentageThemeData: null,
          metricWidgetTheme: null,
          inactiveWidgetTheme: null,
          buildResultTheme: null,
          projectGroupCardTheme: null,
          addProjectGroupCardTheme: null,
          deleteDialogTheme: null,
          projectGroupDialogTheme: null,
          metricsButtonTheme: null,
          textFieldTheme: null,
          dropdownTheme: null,
          dropdownItemTheme: null,
          loginTheme: null,
        );

        expect(themeData.metricCirclePercentageThemeData, isNotNull);
        expect(themeData.metricWidgetTheme, isNotNull);
        expect(themeData.inactiveWidgetTheme, isNotNull);
        expect(themeData.buildResultTheme, isNotNull);
        expect(themeData.projectGroupCardTheme, isNotNull);
        expect(themeData.addProjectGroupCardTheme, isNotNull);
        expect(themeData.deleteDialogTheme, isNotNull);
        expect(themeData.projectGroupDialogTheme, isNotNull);
        expect(themeData.metricsButtonTheme, isNotNull);
        expect(themeData.textFieldTheme, isNotNull);
        expect(themeData.dropdownTheme, isNotNull);
        expect(themeData.dropdownItemTheme, isNotNull);
        expect(themeData.loginTheme, isNotNull);
      },
    );

    test(
      ".copyWith() creates a new theme from existing one",
      () {
        const primaryColor = Colors.red;
        const accentColor = Colors.orange;
        const backgroundColor = Colors.black;

        const metricWidgetTheme = MetricWidgetThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          backgroundColor: backgroundColor,
        );

        const circlePercentageTheme = MetricCirclePercentageThemeData(
          lowPercentTheme: MetricWidgetThemeData(
            primaryColor: primaryColor,
            accentColor: accentColor,
            backgroundColor: backgroundColor,
          ),
        );

        const buildResultsTheme = BuildResultsThemeData(
          successfulColor: primaryColor,
          failedColor: accentColor,
          canceledColor: backgroundColor,
        );

        const projectGroupCardTheme = ProjectGroupCardThemeData(
          primaryColor: primaryColor,
        );

        const addProjectGroupTheme = ProjectGroupCardThemeData(
          primaryColor: primaryColor,
        );

        const deleteDialogTheme = DeleteDialogThemeData(
          backgroundColor: Colors.black,
        );

        const projectGroupDialogTheme = ProjectGroupDialogThemeData(
          backgroundColor: Colors.black,
        );

        const inactiveThemeData = MetricWidgetThemeData(
          primaryColor: primaryColor,
        );

        const metricsButtonTheme = MetricsButtonThemeData(
          buttonAttentionLevel: MetricsButtonAttentionLevel(
            positive: MetricsButtonStyle(color: Colors.green),
          ),
        );

        const textFieldTheme = TextFieldThemeData(focusColor: Colors.black);

        const dropdownTheme = DropdownThemeData(
          backgroundColor: backgroundColor,
        );

        const dropdownItemTheme = DropdownItemThemeData(
          backgroundColor: backgroundColor,
        );

        const loginTheme = LoginThemeData(
          titleTextStyle: TextStyle(color: Colors.red),
        );

        const themeData = MetricsThemeData();

        final copiedTheme = themeData.copyWith(
          metricWidgetTheme: metricWidgetTheme,
          metricCirclePercentageThemeData: circlePercentageTheme,
          buildResultTheme: buildResultsTheme,
          projectGroupCardTheme: projectGroupCardTheme,
          addProjectGroupCardTheme: addProjectGroupTheme,
          deleteDialogTheme: deleteDialogTheme,
          projectGroupDialogTheme: projectGroupDialogTheme,
          inactiveWidgetTheme: inactiveThemeData,
          metricsButtonTheme: metricsButtonTheme,
          textFieldTheme: textFieldTheme,
          dropdownTheme: dropdownTheme,
          dropdownItemTheme: dropdownItemTheme,
          loginTheme: loginTheme,
        );

        expect(
          copiedTheme.metricCirclePercentageThemeData,
          equals(circlePercentageTheme),
        );
        expect(copiedTheme.metricWidgetTheme, equals(metricWidgetTheme));
        expect(copiedTheme.inactiveWidgetTheme, equals(inactiveThemeData));
        expect(copiedTheme.buildResultTheme, equals(buildResultsTheme));
        expect(
          copiedTheme.projectGroupCardTheme,
          equals(projectGroupCardTheme),
        );
        expect(
          copiedTheme.addProjectGroupCardTheme,
          equals(addProjectGroupTheme),
        );
        expect(
          copiedTheme.deleteDialogTheme,
          equals(deleteDialogTheme),
        );
        expect(
          copiedTheme.projectGroupDialogTheme,
          equals(projectGroupDialogTheme),
        );
        expect(copiedTheme.metricsButtonTheme, equals(metricsButtonTheme));
        expect(copiedTheme.textFieldTheme, equals(textFieldTheme));
        expect(copiedTheme.dropdownTheme, equals(dropdownTheme));
        expect(copiedTheme.dropdownItemTheme, equals(dropdownItemTheme));
        expect(copiedTheme.loginTheme, equals(loginTheme));
      },
    );

    test(
      ".copyWith() creates a new instance with the same fields if called without params",
      () {
        const themeData = MetricsThemeData();
        final copiedTheme = themeData.copyWith();

        expect(themeData, isNot(copiedTheme));
        expect(
          themeData.metricWidgetTheme,
          equals(copiedTheme.metricWidgetTheme),
        );
        expect(
          themeData.metricCirclePercentageThemeData,
          equals(copiedTheme.metricCirclePercentageThemeData),
        );
        expect(
          themeData.buildResultTheme,
          equals(copiedTheme.buildResultTheme),
        );
        expect(
          themeData.projectGroupCardTheme,
          equals(copiedTheme.projectGroupCardTheme),
        );
        expect(
          themeData.addProjectGroupCardTheme,
          equals(copiedTheme.addProjectGroupCardTheme),
        );
        expect(
          themeData.deleteDialogTheme,
          equals(copiedTheme.deleteDialogTheme),
        );
        expect(
          themeData.projectGroupDialogTheme,
          equals(copiedTheme.projectGroupDialogTheme),
        );
        expect(
          themeData.inactiveWidgetTheme,
          equals(copiedTheme.inactiveWidgetTheme),
        );
        expect(
          themeData.metricsButtonTheme,
          equals(copiedTheme.metricsButtonTheme),
        );
        expect(themeData.textFieldTheme, equals(themeData.textFieldTheme));
        expect(themeData.dropdownTheme, equals(copiedTheme.dropdownTheme));
        expect(
          themeData.dropdownItemTheme,
          equals(copiedTheme.dropdownItemTheme),
        );
        expect(themeData.loginTheme, equals(copiedTheme.loginTheme));
      },
    );
  });
}
