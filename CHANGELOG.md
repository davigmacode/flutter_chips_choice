## 3.0.0

* Changed default chip to `flexi_chip`
* C2Chip is alias to `FlexiChip` now
* C2ChoiceStyle changed to C2ChipStyle and alias to `FlexiChipStyle`
* Removed `ChipsChoice.choiceActiveStyle` and `C2Choice.activeStyle` since the C2ChipStyle can be an event driven properties
* Removed `C2ChoiceStyle.useCheckmark`, changed to `ChipsChoice.choiceCheckmark`
* Removed `ChipsChoice.choiceAvatarBuilder`
* Added `ChipsChoice.choiceLeadingBuilder`
* Added `ChipsChoice.choiceTrailingBuilder`
* Added `ChipsChoice.choiceOnDelete`
* Added `C2Choice.avatarImage`
* Added `C2Choice.avatarText`
* Fixed issue #26, add leading and trailing widget
* Improved performance
* More flexibility on styling

## 2.1.1

* Hotfix static analysis error

## 2.1.0

* Improve performance
* Fixed chip run spacing
* Fixed tooltip error

## 2.1.0-nullsafety.1

* Improve performance
* Value of multiple choice cannot be null
* Fixed issue #37
* Fixed wrapped chips run spacing on web
* Improve async choices loader with asyncMemoizer
* Provide `C2ChoiceMemoizer<T>` which is an alias to `AsyncMemoizer<List<C2Choice<T>>>`

## 2.1.0-nullsafety.0

* Support sound null safety
* The chip widget respective to app theme
* Introduce chip appearance (elevated, outlined, flatten)
* Configurable scrollController

## 2.0.1

* Fixed issue #11

## 2.0.0

* The `options` parameter is changed to `choiceItems`
* The `ChipsChoiceOption` class is changed to `C2Choice`,
* Removed the `avatar` parameter from choice item class, instead use `ChipsChoice.choiceAvatarBuilder`
* The `ChipsChoice.isWrapped` parameter is changed to `ChipsChoice.wrapped`
* The `ChipsChoice.itemBuilder` parameter is changed to `ChipsChoice.choiceBuilder`
* The `ChipsChoice.wrapAlignment` parameter is changed to `ChipsChoice.alignment`
* The `ChipsChoice.itemConfig` parameter and `ChipsChoiceItemConfig` class is removed, instead use `C2ChoiceStyle` class with `ChipsChoice.choiceStyle` and `ChipsChoice.choiceActiveStyle`
* Easily configure unselected and selected choice style using `ChipsChoice.choiceStyle` and `ChipsChoice.choiceActiveStyle`
* Individual choice style using `C2Choice.style` and `C2Choice.activeStyle`
* Added parameter `ChipsChoice.choiceLoader` to easily load async choice items
* Added `ChipsChoice.choiceLabelBuilder`, `ChipsChoice.choiceAvatarBuilder`, `ChipsChoice.choiceBuilder`, `ChipsChoice.spinnerBuilder`, `ChipsChoice.placeholderBuilder`, `ChipsChoice.errorBuilder`,
* Added `ChipsChoice.direction`, `ChipsChoice.verticalDirection`, `ChipsChoice.textDirection`, `ChipsChoice.clipBehavior`, `ChipsChoice.scrollPhysics`, `ChipsChoice.mainAxisSize`, `ChipsChoice.mainAxisAlignment`, `ChipsChoice.crossAxisAlignment`, `ChipsChoice.alignment`, `ChipsChoice.runAlignment`, `ChipsChoice.wrapCrossAlignment`, `ChipsChoice.spacing`, `ChipsChoice.runSpacing`, `ChipsChoice.placeholder`, `ChipsChoice.placeholderStyle`, `ChipsChoice.placeholderAlign`, `ChipsChoice.errorStyle`, `ChipsChoice.errorAlign`, `ChipsChoice.spinnerSize`, `ChipsChoice.spinnerColor`, `ChipsChoice.spinnerThickness`
* Changed `FilterChip` to `RawChip`

## 1.4.1

* Added wrap alignment parameter, thanks to @deandreamatias
* Added support for setting materialTapTargetSize on chips - directly affecting the ability to reduce padding of chips, thanks to @noliran
* Fixed a bug preventing us from setting a custom margin, thanks to @noliran
* Added `itemConfig.shapeBuilder` to example

## 1.2.0

* Add `labelStyle` to `ChipsChoiceItemConfig`

## 1.1.0

* Improve performance, since `Theme.of(context)` in default choice widget is moved outside, so this only fired once
* `ChipsChoiceBuilder` parameter `select` function now only need one parameter `bool selected`
* Add `meta` to `ChipsChoiceOption`, this useful with custom choice widget
* Add more option to `ChipsChoiceItemConfig`
* Add more usage example

## 1.0.0

* Initial release
* Select single or multiple choice
* Display in scrollable or wrapped List
* Customizable choice input
* Build choice option from any List
