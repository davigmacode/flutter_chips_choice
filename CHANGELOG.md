## [1.4.1] - 2020-10-01

* Added wrap alignment parameter, thanks to @deandreamatias
* Added support for setting materialTapTargetSize on chips - directly affecting the ability to reduce padding of chips, thanks to @noliran
* Fixed a bug preventing us from setting a custom margin, thanks to @noliran
* Added `itemConfig.shapeBuilder` to example

## [1.2.0] - 2020-04-05

* Add `labelStyle` to `ChipsChoiceItemConfig`

## [1.1.0] - 2020-03-07

* Improve performance, since `Theme.of(context)` in default choice widget is moved outside, so this only fired once
* `ChipsChoiceBuilder` parameter `select` function now only need one parameter `bool selected`
* Add `meta` to `ChipsChoiceOption`, this useful with custom choice widget
* Add more option to `ChipsChoiceItemConfig`
* Add more usage example

## [1.0.0] - 2020-01-24

* Initial release
* Select single or multiple choice
* Display in scrollable or wrapped List
* Customizable choice input
* Build choice option from any List
