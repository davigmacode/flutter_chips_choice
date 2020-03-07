# chips_choice

Lite version of [smart_select](https://pub.dev/packages/smart_select) package, zero dependencies, an easy way to provide a single or multiple choice chips.

## Demo

### Preview

![Demo Preview](https://github.com/davigmacode/flutter_chips_choice/raw/master/example/art/screencast.gif)

### Download

[![Demo App](https://github.com/davigmacode/flutter_chips_choice/raw/master/example/art/qr-apk.png "ChipsChoice Demo App")](https://github.com/davigmacode/flutter_chips_choice/blob/master/example/art/ChipsChoice.apk?raw=true)


## Features

* Select single or multiple choice
* Display in scrollable or wrapped List
* Build choice option from any List
* Customizable choice widget

## Usage

For a complete usage, please see the [example](https://pub.dev/packages/chips_choice#-example-tab-).

To read more about classes and other references used by `chips_choice`, see the [documentation](https://pub.dev/documentation/chips_choice/latest/).

### Single Choice

```
int tag = 1;
List<String> options = [
  'News', 'Entertainment', 'Politics',
  'Automotive', 'Sports', 'Education',
  'Fashion', 'Travel', 'Food', 'Tech',
  'Science',
];

// ChipsChoice<T>.single
ChipsChoice<int>.single(
  value: tag,
  options: ChipsChoiceOption.listFrom<int, String>(
    source: options,
    value: (i, v) => i,
    label: (i, v) => v,
  ),
  onChanged: (val) => setState(() => tag = val),
);

```

### Multiple Choice

```
List<String> tags = [];
List<String> options = [
  'News', 'Entertainment', 'Politics',
  'Automotive', 'Sports', 'Education',
  'Fashion', 'Travel', 'Food', 'Tech',
  'Science',
];

// ChipsChoice<T>.multiple
ChipsChoice<String>.multiple(
  value: tags,
  options: ChipsChoiceOption.listFrom<String, String>(
    source: options,
    value: (i, v) => v,
    label: (i, v) => v,
  ),
  onChanged: (val) => setState(() => tags = val),
);
```

### Build Options List

`options` property is `List<ChipsChoiceOption<T>>`, it can be input directly as in the example below, more info about `ChipsChoiceOption` can be found on the [API Reference](https://pub.dev/documentation/chips_choice/latest/chips_choice/ChipsChoiceOption-class.html)

```
ChipsChoice<T>.single/multiple(
  ...,
  ...,
  options: <ChipsChoiceOption<T>>[
    ChipsChoiceOption<T>(value: 1, label: 'Entertainment'),
    ChipsChoiceOption<T>(value: 2, label: 'Education'),
    ChipsChoiceOption<T>(value: 3, label: 'Fashion'),
  ],
);
```

`options` also can be created from any list using helper provided by this package, like the example below

```
List<Map<String, String>> days = [
  { 'value': 'mon', 'title': 'Monday' },
  { 'value': 'tue', 'title': 'Tuesday' },
  { 'value': 'wed', 'title': 'Wednesday' },
  { 'value': 'thu', 'title': 'Thursday' },
  { 'value': 'fri', 'title': 'Friday' },
  { 'value': 'sat', 'title': 'Saturday' },
  { 'value': 'sun', 'title': 'Sunday' },
];

ChipsChoice<T>.single/multiple(
  ...,
  ...,
  options: ChipsChoiceOption.listFrom<T, Map<String, String>>(
    source: days,
    value: (index, item) => item['value'],
    label: (index, item) => item['title'],
  ),
);
```

### Scrollable or Wrapped List

```
ChipsChoice<T>.single/multiple(
  ...,
  ...,
  isWrapped: false/true,
);
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
