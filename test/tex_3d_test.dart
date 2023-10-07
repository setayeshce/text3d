import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_3d/text_3d.dart';

void main() {
  // This group is for basic instantiation tests
  group('ThreeDText instantiation', () {
    testWidgets('should instantiate with standard style without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ThreeDText(
          text: 'Test',
          textStyle: TextStyle(fontSize: 24, color: Colors.blue),
          style: ThreeDStyle.standard,
        ),
      ));
    });

    testWidgets('should instantiate with raised style without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ThreeDText(
          text: 'Test',
          textStyle: TextStyle(fontSize: 24, color: Colors.blue),
          style: ThreeDStyle.raised,
        ),
      ));
    });

    // Add similar tests for the other styles...
  });

  // This group can be used to test other properties or behaviors
  group('ThreeDText properties and behaviors', () {
    testWidgets('should handle custom depth without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ThreeDText(
          text: 'Test Depth',
          textStyle: TextStyle(fontSize: 24, color: Colors.red),
          depth: 15.0,
          style: ThreeDStyle.inset,
        ),
      ));
    });
  });
}
