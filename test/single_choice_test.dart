import 'package:flutter_test/flutter_test.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

void main() {
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

  testWidgets(
    'Choice items and the initial value displayed correctly',
    (WidgetTester tester) async {
      int? selectedValue;

      final c2Widget = ChipsChoice<int>.single(
        value: selectedValue,
        onChanged: (val) => selectedValue = val,
        choiceItems: C2Choice.listFrom<int, String>(
          source: options,
          value: (i, v) => i,
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

      // expect available choice items displayed correctly
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

      // select a choice options[4] = Sports
      final int selectionValue = 4;
      final selectionFinder = find.descendant(
        of: c2Finder,
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is C2Chip &&
              widget.key == ValueKey(selectionValue) &&
              widget.selected == false,
        ),
      );
      expect(
        selectionFinder,
        findsOneWidget,
        reason: 'Choice to select is displayed',
      );

      // Tap the widget
      await tester.tap(selectionFinder);
      // Rebuild the widget after the state has changed.
      await tester.pumpAndSettle();

      // expect selected choice items displayed correctly
      final selectedFinder = find.descendant(
        of: c2Finder,
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is C2Chip &&
              widget.key == ValueKey(selectionValue) &&
              widget.selected == true,
        ),
      );
      expect(
        selectedFinder,
        findsOneWidget,
        reason: 'New selected choice item is correctly displayed',
      );

      expect(selectedValue, selectionValue);
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
        body: child,
      ),
    );
  }
}
