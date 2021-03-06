import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/text_field_theme_data.dart';
import 'package:metrics/common/presentation/widgets/metrics_text_form_field.dart';

import '../../../test_utils/metrics_themed_testbed.dart';

void main() {
  group("MetricsTextFormField", () {
    const metricsThemeData = MetricsThemeData(
      textFieldTheme: TextFieldThemeData(
        focusColor: Colors.grey,
        hoverBorderColor: Colors.lightBlue,
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );

    final themeData = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black87, fontSize: 16.0),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );

    String defaultValidator(String value) => null;

    testWidgets(
      "applies the given controller to the text form field",
      (tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          controller: controller,
        ));

        final textField = tester.widget<TextFormField>(
          find.byType(TextFormField),
        );

        expect(textField.controller, equals(controller));
      },
    );

    testWidgets(
      "applies the given validator to the text form field",
      (tester) async {
        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          validator: defaultValidator,
        ));

        final textField = tester.widget<TextFormField>(
          find.byType(TextFormField),
        );

        expect(textField.validator, equals(defaultValidator));
      },
    );

    testWidgets(
      "calls the given on changed callback when the text changes",
      (tester) async {
        bool onChangedCalled = false;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          onChanged: (_) {
            onChangedCalled = true;
          },
        ));

        await tester.enterText(find.byType(TextFormField), 'text');

        expect(onChangedCalled, isTrue);
      },
    );

    testWidgets(
      "displays the given label for the text form field",
      (tester) async {
        const label = 'Label';

        await tester.pumpWidget(const _MetricsTextFormFieldTestbed(
          label: label,
        ));

        final finder = find.text(label);

        expect(finder, findsOneWidget);
      },
    );

    testWidgets(
      "does not display the given label for the text form field if it is null",
      (tester) async {
        await tester.pumpWidget(const _MetricsTextFormFieldTestbed(
          label: null,
        ));

        final finder = find.descendant(
          of: find.byType(Column),
          matching: find.byType(Text),
        );

        expect(finder, findsNothing);
      },
    );

    testWidgets(
      "applies the given hint text as the text form field hint",
      (tester) async {
        const hint = 'Hint';

        await tester.pumpWidget(const _MetricsTextFormFieldTestbed(
          hint: hint,
        ));

        final textField = tester.widget<TextField>(find.byType(TextField));
        final hintText = textField.decoration.hintText;

        expect(hintText, equals(hint));
      },
    );

    testWidgets(
      "applies the given prefix icon as the text form field prefix icon",
      (tester) async {
        const searchIcon = Icon(Icons.search);

        await tester.pumpWidget(const _MetricsTextFormFieldTestbed(
          prefixIcon: searchIcon,
        ));

        final textField = tester.widget<TextField>(find.byType(TextField));
        final prefixIcon = textField.decoration.prefixIcon;

        expect(prefixIcon, equals(searchIcon));
      },
    );

    testWidgets(
      "applies the given suffix icon as the text form field suffix icon",
      (tester) async {
        const lockIcon = Icon(Icons.lock);

        await tester.pumpWidget(const _MetricsTextFormFieldTestbed(
          suffixIcon: lockIcon,
        ));

        final textField = tester.widget<TextField>(find.byType(TextField));
        final suffixIcon = textField.decoration.suffixIcon;

        expect(suffixIcon, equals(lockIcon));
      },
    );

    testWidgets(
      "applies the text style from the text field theme",
      (tester) async {
        final themeStyle = metricsThemeData.textFieldTheme.textStyle;

        await tester.pumpWidget(const _MetricsTextFormFieldTestbed(
          metricsThemeData: metricsThemeData,
        ));

        final textField = tester.widget<TextField>(find.byType(TextField));
        final textStyle = textField.style;

        expect(textStyle, equals(themeStyle));
      },
    );

    testWidgets(
      "applies the label style from the input decoration theme to the given label",
      (tester) async {
        const label = 'Label';
        final themeLabelStyle = themeData.inputDecorationTheme.labelStyle;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          themeData: themeData,
          label: label,
        ));

        final labelText = tester.widget<Text>(find.text(label));
        final style = labelText.style;

        expect(style, equals(themeLabelStyle));
      },
    );

    testWidgets(
      "applies the hover border color from theme to the hovered text form field",
      (tester) async {
        final themeHoverBorderColor =
            metricsThemeData.textFieldTheme.hoverBorderColor;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          themeData: themeData,
          metricsThemeData: metricsThemeData,
        ));

        final mouseRegion = tester.widget<MouseRegion>(find.ancestor(
          of: find.byType(TextFormField),
          matching: find.byType(MouseRegion),
        ));
        const pointerEnterEvent = PointerEnterEvent();
        mouseRegion.onEnter(pointerEnterEvent);
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        final borderColor = textField.decoration.border.borderSide.color;

        expect(borderColor, equals(themeHoverBorderColor));
      },
    );

    testWidgets(
      "does not apply the hover border color from theme to the hovered text form field when it is focused",
      (tester) async {
        final themeHoverBorderColor =
            metricsThemeData.textFieldTheme.hoverBorderColor;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          themeData: themeData,
          metricsThemeData: metricsThemeData,
        ));

        await tester.tap(find.byType(TextField));
        await tester.pump();

        final mouseRegion = tester.widget<MouseRegion>(find.ancestor(
          of: find.byType(TextFormField),
          matching: find.byType(MouseRegion),
        ));
        const pointerEnterEvent = PointerEnterEvent();
        mouseRegion.onEnter(pointerEnterEvent);
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        final borderColor = textField.decoration.border.borderSide.color;

        expect(borderColor, isNot(equals(themeHoverBorderColor)));
      },
    );

    testWidgets(
      "applies the default border from theme to the text form field when it is not hovered",
      (tester) async {
        final themeBorder = themeData.inputDecorationTheme.border;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          themeData: themeData,
          metricsThemeData: metricsThemeData,
        ));

        final mouseRegion = tester.widget<MouseRegion>(find.ancestor(
          of: find.byType(TextFormField),
          matching: find.byType(MouseRegion),
        ));
        const pointerExitEvent = PointerExitEvent();
        mouseRegion.onExit(pointerExitEvent);
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        final border = textField.decoration.border;

        expect(border, equals(themeBorder));
      },
    );

    testWidgets(
      "applies the focus color from theme to the focused text form field",
      (tester) async {
        final themeFocusColor = metricsThemeData.textFieldTheme.focusColor;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          themeData: themeData,
          metricsThemeData: metricsThemeData,
        ));

        await tester.tap(find.byType(TextField));
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        final fillColor = textField.decoration.fillColor;

        expect(fillColor, equals(themeFocusColor));
      },
    );

    testWidgets(
      "applies the default fill color from theme to the text form field when it is not focused",
      (tester) async {
        const label = 'Label';
        final themeFillColor = themeData.inputDecorationTheme.fillColor;

        await tester.pumpWidget(_MetricsTextFormFieldTestbed(
          themeData: themeData,
          metricsThemeData: metricsThemeData,
          label: label,
        ));

        await tester.tap(find.text(label));
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        final fillColor = textField.decoration.fillColor;

        expect(fillColor, equals(themeFillColor));
      },
    );
  });
}

/// A testbed widget used to test the [MetricsTextFormField] widget.
class _MetricsTextFormFieldTestbed extends StatelessWidget {
  /// A [MetricsThemeData] used in tests.
  final MetricsThemeData metricsThemeData;

  /// A [ThemeData] used in tests.
  final ThemeData themeData;

  /// A controller to apply to the text field.
  final TextEditingController controller;

  /// A validation for the text field.
  final FormFieldValidator<String> validator;

  /// A callback for value changes for the text field.
  final ValueChanged<String> onChanged;

  /// A prefix icon for the text field under tests.
  final Widget prefixIcon;

  /// A suffix icon for the text field under tests.
  final Widget suffixIcon;

  /// A text to apply to the text field as a hint.
  final String hint;

  /// A text to apply to the text field as a label.
  final String label;

  /// Creates a new instance of the Metrics text form field testbed.
  ///
  /// The [metricsThemeData] defaults to the default [MetricsThemeData] instance.
  const _MetricsTextFormFieldTestbed({
    Key key,
    this.metricsThemeData = const MetricsThemeData(),
    this.themeData,
    this.controller,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.hint,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsThemedTestbed(
      metricsThemeData: metricsThemeData,
      themeData: themeData,
      body: MetricsTextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hint: hint,
        label: label,
      ),
    );
  }
}
