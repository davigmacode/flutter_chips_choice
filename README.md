![Pub Version](https://img.shields.io/pub/v/chips_choice) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_chips_choice)

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="195" height="55"></a>

Lite version of [smart_select](https://pub.dev/packages/smart_select) package, zero dependencies, an easy way to provide a single or multiple choice chips.

## What's New in Version 2.x.x

- Added parameter `ChipsChoice.choiceloader` to easily load async choice items
- Easily configure unselected and selected choice style using `ChipsChoice.choiceStyle` and `ChipsChoice.choiceActiveStyle`
- Individual choice style using `C2Choice.style` and `C2Choice.activeStyle`
- Added scroll and text direction configuration
- Added more custom builder
- And many more configurations that can be seen in the [API Reference](https://pub.dev/documentation/chips_choice/latest/) and [example](https://pub.dev/packages/chips_choice#-example-tab-)

## Migration from 1.4.1 to 2.0.0

- The `options` parameter is changed to `choiceItems`
- The `ChipsChoiceOption` class is changed to `C2Choice`,
- Removed the `avatar` parameter from choice item class, instead use `ChipsChoice.choiceAvatarBuilder`
- The `ChipsChoice.isWrapped` parameter is changed to `ChipsChoice.wrapped`
- The `ChipsChoice.itemBuilder` parameter is changed to `ChipsChoice.choiceBuilder`
- The `ChipsChoice.wrapAlignment` parameter is changed to `ChipsChoice.alignment`
- The `ChipsChoice.itemConfig` parameter and `ChipsChoiceItemConfig` class is removed, instead use `C2ChoiceStyle` class with `ChipsChoice.choiceStyle` and `ChipsChoice.choiceActiveStyle`

## Demo

### Preview

![Demo Preview](https://github.com/davigmacode/flutter_chips_choice/raw/master/demo/screens/screencast.gif)

### Download

[![Demo App](https://github.com/davigmacode/flutter_chips_choice/raw/master/demo/build/qr-apk.png "ChipsChoice Demo App")](https://github.com/davigmacode/flutter_chips_choice/raw/master/demo/build/ChipsChoice.apk)


## Features

* Select single or multiple choice
* Display in scrollable or wrapped list
* Build choice items from any `List`
* Customizable choice widget

## Usage

For a complete usage, please see the [example](https://pub.dev/packages/chips_choice#-example-tab-).

To read more about classes and other references used by `chips_choice`, see the [API Reference](https://pub.dev/documentation/chips_choice/latest/).

### Single Choice

```dart
// available configuration for single choice
ChipsChoice<T>.single({

  // The current value of the single choice widget.
  @required T value,

  // Called when single choice value changed
  @required C2Changed<T> onChanged,

  // choice item list
  @required List<C2Choice<T>> choiceItems,

  // Async loader of choice items
  C2ChoiceLoader<T> choiceLoader,

  // other available configuration
  // explained below
  ...,
  ...,

})
```
Simple usage
```dart
int tag = 1;
List<String> options = [
  'News', 'Entertainment', 'Politics',
  'Automotive', 'Sports', 'Education',
  'Fashion', 'Travel', 'Food', 'Tech',
  'Science',
];

@override
Widget build(BuildContext context) {
  return ChipsChoice<int>.single(
    value: tag,
    onChanged: (val) => setState(() => tag = val),
    choiceItems: C2Choice.listFrom<int, String>(
      source: options,
      value: (i, v) => i,
      label: (i, v) => v,
    ),
  );
}
```

### Multiple Choice
```dart
// available configuration for multiple choice
ChipsChoice<T>.multiple({

  // The current value of the multiple choice widget.
  @required List<T> value,

  // Called when multiple choice value changed
  @required C2Changed<List<T>> onChanged,

  // choice item list
  @required List<C2Choice<T>> choiceItems,

  // Async loader of choice items
  C2ChoiceLoader<T> choiceLoader,

  // other available configuration
  // explained below
  ...,
  ...,

})
```
Simple usage
```dart
List<String> tags = [];
List<String> options = [
  'News', 'Entertainment', 'Politics',
  'Automotive', 'Sports', 'Education',
  'Fashion', 'Travel', 'Food', 'Tech',
  'Science',
];

@override
Widget build(BuildContext context) {
  return ChipsChoice<String>.multiple(
    value: tags,
    onChanged: (val) => setState(() => tags = val),
    choiceItems: C2Choice.listFrom<String, String>(
      source: options,
      value: (i, v) => v,
      label: (i, v) => v,
    ),
  );
}
```

### Style Configuration
```dart
// available configuration for single and multiple choice
ChipsChoice<T>.[single|multiple]({

  // other available configuration
  // explained below
  ...,
  ...,

  // Choice unselected item style
  C2ChoiceStyle choiceStyle,

  // Choice selected item style
  C2ChoiceStyle choiceActiveStyle,

  // other available configuration
  // explained below
  ...,
  ...,

})
```

```dart
// Choice item style configuration
C2ChoiceStyle( {

  // Item color
  Color color,

  // choice item margin
  EdgeInsetsGeometry margin,

  // The padding between the contents of the chip and the outside [shape].
  //
  // Defaults to 4 logical pixels on all sides.
  EdgeInsetsGeometry padding,

  // Chips elevation
  double elevation,

  // Longpress chips elevation
  double pressElevation,

  // whether the chips use checkmark or not
  bool showCheckmark,

  // Chip label style
  TextStyle labelStyle,

  // Chip label padding
  EdgeInsetsGeometry labelPadding,

  // Chip brightness
  Brightness brightness,

  // Chip border color
  Color borderColor,

  // Chip border opacity,
  // only effect when [brightness] is [Brightness.light]
  double borderOpacity,

  // The width of this side of the border, in logical pixels.
  double borderWidth,

  // The radii for each corner.
  BorderRadiusGeometry borderRadius,

  // The style of this side of the border.
  //
  // To omit a side, set [style] to [BorderStyle.none].
  // This skips painting the border, but the border still has a [width].
  BorderStyle borderStyle,

  // Chips shape border
  ShapeBorder borderShape;

  // Chip border color
  Color avatarBorderColor,

  // The width of this side of the border, in logical pixels.
  double avatarBorderWidth,

  // The radii for each corner.
  BorderRadiusGeometry avatarBorderRadius,

  // The style of this side of the border.
  //
  // To omit a side, set [style] to [BorderStyle.none].
  // This skips painting the border, but the border still has a [width].
  BorderStyle avatarBorderStyle,

  // Chips shape border
  ShapeBorder avatarBorderShape,

  // Chips clip behavior
  Clip clipBehavior,

  // Configures the minimum size of the tap target.
  MaterialTapTargetSize materialTapTargetSize,

  // Color to be used for the chip's background indicating that it is disabled.
  //
  // It defaults to [Colors.black38].
  Color disabledColor,

})
```

### Custom Builder

```dart
// available configuration for single and multiple choice
ChipsChoice<T>.[single|multiple]({

  // other available configuration
  // explained below
  ...,
  ...,

  // Builder for custom choice item label
  C2Builder<T> choiceLabelBuilder,

  /// Builder for custom choice item label
  C2Builder<T> choiceAvatarBuilder,

  // Builder for custom choice item
  C2Builder<T> choiceBuilder,

  // Builder for spinner widget
  WidgetBuilder spinnerBuilder,

  /// Builder for placeholder widget
  WidgetBuilder placeholderBuilder,

  // Builder for error widget
  WidgetBuilder errorBuilder,

  // other available configuration
  // explained below
  ...,
  ...,

})
```

### Container Configuration

```dart
// available configuration for single and multiple choice
ChipsChoice<T>.[single|multiple]({

  // other available configuration
  // explained below
  ...,
  ...,

  // Whether the chips is wrapped or scrollable
  bool wrapped,

  // Container padding
  EdgeInsetsGeometry padding,

  // The direction to use as the main axis.
  Axis direction,

  // Determines the order to lay children out vertically and how to interpret start and end in the vertical direction.
  VerticalDirection verticalDirection,

  // Determines the order to lay children out horizontally and how to interpret start and end in the horizontal direction.
  TextDirection textDirection,

  // if [wrapped] is [false], How the scroll view should respond to user input.
  ScrollPhysics scrollPhysics,

  // if [wrapped] is [false], How much space should be occupied in the main axis.
  MainAxisSize mainAxisSize,

  // if [wrapped] is [false], How the children should be placed along the main axis.
  MainAxisAlignment mainAxisAlignment,

  // if [wrapped] is [false], How the children should be placed along the cross axis.
  CrossAxisAlignment crossAxisAlignment,

  // if [wrapped] is [true], how the children within a run should be aligned relative to each other in the cross axis.
  WrapCrossAlignment wrapCrossAlignment,

  // if [wrapped] is [true], determines how wrap will align the objects
  WrapAlignment alignment,

  // if [wrapped] is [true], how the runs themselves should be placed in the cross axis.
  WrapAlignment runAlignment,

  // if [wrapped] is [true], how much space to place between children in a run in the main axis.
  double spacing,

  // if [wrapped] is [true], how much space to place between the runs themselves in the cross axis.
  double runSpacing,

  // Clip behavior
  Clip clipBehavior,

  // String to display when choice items is empty
  String placeholder,

  // placeholder text style
  TextStyle placeholderStyle,

  // placeholder text align
  TextAlign placeholderAlign,

  // error text style
  TextStyle errorStyle,

  // error text align
  TextAlign errorAlign,

  // spinner size
  double spinnerSize,

  // spinner color
  Color spinnerColor,

  // spinner thickness
  double spinnerThickness,

  // other available configuration
  // explained below
  ...,
  ...,

})
```

### Build Choice List

`choiceItems` property is `List<C2Choice<T>>`, it can be input directly as in the example below, more info about `C2Choice` can be found on the [API Reference](https://pub.dev/documentation/chips_choice/latest/chips_choice/C2Choice-class.html)

```dart
ChipsChoice<T>.[single|multiple](
  ...,
  ...,
  choiceItems: <C2Choice<T>>[
    C2Choice<T>(value: 1, label: 'Entertainment'),
    C2Choice<T>(value: 2, label: 'Education'),
    C2Choice<T>(value: 3, label: 'Fashion'),
  ],
);
```

`choiceItems` also can be created from any list using helper provided by this package, like the example below

```dart
List<Map<String, String>> days = [
  { 'value': 'mon', 'title': 'Monday' },
  { 'value': 'tue', 'title': 'Tuesday' },
  { 'value': 'wed', 'title': 'Wednesday' },
  { 'value': 'thu', 'title': 'Thursday' },
  { 'value': 'fri', 'title': 'Friday' },
  { 'value': 'sat', 'title': 'Saturday' },
  { 'value': 'sun', 'title': 'Sunday' },
];

ChipsChoice<T>.[single|multiple](
  ...,
  ...,
  choiceItems: C2Choice.listFrom<T, Map<String, String>>(
    source: days,
    value: (index, item) => item['value'],
    label: (index, item) => item['title'],
  ),
);
```
Use `choiceLoader` to easily load choice items from async function
```dart
import 'package:dio/dio.dart';

String value;

Future<List<C2Choice<String>>> getChoices() async {
  String url = "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
  Response res = await Dio().get(url);
  return C2Choice.listFrom<String, dynamic>(
    source: res.data['results'],
    value: (index, item) => item['email'],
    label: (index, item) => item['name']['first'] + ' ' + item['name']['last'],
    meta: (index, item) => item,
  )..insert(0, C2Choice<String>(value: 'all', label: 'All'));
}

@override
Widget build(BuildContext context) {
  return ChipsChoice<String>.single(
    value: value,
    onChanged: (val) => setState(() => value = val),
    choiceItems: null,
    choiceLoader: getChoices,
  );
}
```

## License

```
Copyright (c) 2020 Irfan Vigma Taufik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
