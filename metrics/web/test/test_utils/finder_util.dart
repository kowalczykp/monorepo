import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A utility class needed to find widgets in the widget tree under tests.
class FinderUtil {
  /// Finds the [NetworkImage] in the widget tree under tests using the given [tester].
  static NetworkImage findNetworkImageWidget(WidgetTester tester) {
    final imageWidget = tester.widget<Image>(find.byType(Image));

    return imageWidget.image as NetworkImage;
  }

  /// Finds [BoxDecoration] in the widget tree under tests using the given [tester].
  static BoxDecoration findBoxDecoration(WidgetTester tester) {
    final containerWidget = tester.widget<Container>(find.byType(Container));

    return containerWidget.decoration as BoxDecoration;
  }
}
