import 'package:flutter_test/flutter_test.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

void main() {
  List<String> value = [];
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  setUp(() {
    value = [];
  });

  testWidgets(
    'Choice items and the initial value displayed correctly',
    (WidgetTester tester) async {
      final c2Widget = ChipsChoice<String>.multiple(
        value: value,
        onChanged: (value) => value = value,
        choiceItems: C2Choice.listFrom<String, String>(
          source: options,
          value: (i, v) => v.toLowerCase(),
          label: (i, v) => v,
        ),
      );

      await tester.pumpWidget(Bootstrap(child: c2Widget));
      await tester.pumpAndSettle();

      final c2Finder = find.byWidget(c2Widget);
      expect(
        c2Finder,
        findsOneWidget,
        reason: 'ChipsChoice widget is displayed',
      );

      // expect the choice items displayed correctly
      final choiceFinder = find.descendant(
        of: c2Finder,
        matching: find.byWidgetPredicate(
          (widget) => widget is C2Chip && widget.selected == false,
        ),
      );
      expect(
        choiceFinder,
        findsNWidgets(11),
        reason: 'List of choice items is displayed',
      );
    },
  );
}

class Bootstrap extends StatelessWidget {
  final Widget child;

  const Bootstrap({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChipsChoice Test',
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
