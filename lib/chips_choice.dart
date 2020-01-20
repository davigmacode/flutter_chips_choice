library chips_choice;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Easy way to provide a single or multiple choice chips.
class ChipsChoice<T> extends StatelessWidget {

  /// List of option item
  final List<ChipsChoiceOption<T>> options;

  /// Choice item config
  final ChipsChoiceItemConfig itemConfig;

  /// Builder for custom choice item
  final ChipsChoiceBuilder<T> itemBuilder;

  /// List padding
  final EdgeInsetsGeometry padding;

  final T _value;
  final List<T> _values;
  final ChipsChoiceChanged<T> _onChangedSingle;
  final ChipsChoiceChanged<List<T>> _onChangedMultiple;
  final bool _isMultiChoice;

  ChipsChoice.single({
    Key key,
    @required T value,
    @required this.options,
    @required ChipsChoiceChanged<T> onChanged,
    this.itemConfig = const ChipsChoiceItemConfig(),
    this.itemBuilder,
    this.padding,
  }) : assert(onChanged != null),
    _isMultiChoice = false,
    _value = value,
    _values = null,
    _onChangedMultiple = null,
    _onChangedSingle = onChanged,
    super(key: key);

  ChipsChoice.multiple({
    Key key,
    @required List<T> value,
    @required this.options,
    @required ChipsChoiceChanged<List<T>> onChanged,
    this.itemConfig = const ChipsChoiceItemConfig(),
    this.itemBuilder,
    this.padding,
  }) : assert(onChanged != null && value != null),
    _isMultiChoice = true,
    _value = null,
    _values = value,
    _onChangedSingle = null,
    _onChangedMultiple = onChanged,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemConfig.isWrapped == true
      ? _listWrapped()
      : _listScrollable();
  }

  Widget _listScrollable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: _choiceItems,
      ),
    );
  }

  Widget _listWrapped() {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: Wrap(
        spacing: itemConfig.wrappedSpacing, // gap between adjacent chips
        runSpacing: itemConfig.wrappedRunSpacing, // gap between lines
        children: _choiceItems,
      ),
    );
  }

  List<Widget> get _choiceItems {
    return List<Widget>.generate(
      options.length,
      (i) => _choiceItemBuilder(i),
    ).where((item) => item != null).toList();
  }

  Widget _choiceItemBuilder(int i) {
    ChipsChoiceOption<T> item = options[i];
    bool selected = _isMultiChoice
      ? _values.contains(item.value)
      : _value == item.value;
    return item.hidden == false
      ? itemBuilder?.call(item, itemConfig, selected) ?? _ChipsChoiceItem(
          item: item,
          config: itemConfig,
          selected: selected,
          onSelect: _onSelect,
        )
      : null;
  }

  void _onSelect(T value, bool selected) {
    if (_isMultiChoice) {
      List<T> values = List.from(_values ?? []);
      if (selected) {
        values.add(value);
      } else {
        values.remove(value);
      }
      _onChangedMultiple?.call(values);
    } else {
      _onChangedSingle?.call(value);
    }
  }
}

class _ChipsChoiceItem<T> extends StatelessWidget {

  final ChipsChoiceOption<T> item;
  final ChipsChoiceItemConfig config;
  final Function onSelect;
  final bool selected;

  _ChipsChoiceItem({
    Key key,
    @required this.item,
    @required this.config,
    @required this.onSelect,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Color _selectedColor = config.selectedColor ?? _theme.primaryColor;
    Color _unselectedColor = config.unselectedColor ?? _theme.unselectedWidgetColor;

    return Padding(
      padding: config.margin,
      child: FilterChip(
        label: Text(
          item.label,
          style: TextStyle(
            color: selected ? _selectedColor : _unselectedColor,
          ),
        ),
        avatar: item.avatar,
        shape: config.shapeBuilder?.call(selected) ?? StadiumBorder(
          side: BorderSide(
            color: selected
              ? _selectedColor.withOpacity(.2)
              : _unselectedColor.withOpacity(.2),
          ),
        ),
        elevation: config.elevation,
        pressElevation: config.pressElevation,
        shadowColor: _unselectedColor,
        selectedShadowColor: _selectedColor,
        backgroundColor: Colors.transparent,
        selectedColor: Colors.transparent,
        checkmarkColor: _selectedColor,
        showCheckmark: config.showCheckmark == true,
        selected: selected,
        onSelected: item.disabled == false
          ? (_selected) => onSelect(item.value, _selected)
          : null,
      ),
    );
  }
}

class ChipsChoiceOption<T> {
  final T value;
  final String label;
  final Widget avatar;
  final bool disabled;
  final bool hidden;

  ChipsChoiceOption({
    @required this.value,
    @required this.label,
    this.avatar,
    this.disabled = false,
    this.hidden = false,
  }) : assert(disabled != null),
    assert(hidden != null);

  static List<ChipsChoiceOption<R>> listFrom<S, R>({
    @required List<S> source,
    @required ChipsChoiceOptionProp<S, R> value,
    @required ChipsChoiceOptionProp<S, String> label,
    ChipsChoiceOptionProp<S, Widget> avatar,
    ChipsChoiceOptionProp<S, bool> disabled,
    ChipsChoiceOptionProp<S, bool> hidden,
  }) => source
    .asMap()
    .map((index, item) => MapEntry(index, ChipsChoiceOption<R>(
      value: value?.call(index, item),
      label: label?.call(index, item),
      avatar: avatar?.call(index, item),
      disabled: disabled?.call(index, item) ?? false,
      hidden: hidden?.call(index, item) ?? false,
    )))
    .values
    .toList()
    .cast<ChipsChoiceOption<R>>();
}

class ChipsChoiceItemConfig {
  final bool isWrapped;
  final bool showCheckmark;
  final Color selectedColor;
  final Color unselectedColor;
  final EdgeInsetsGeometry margin;
  final double wrappedSpacing;
  final double wrappedRunSpacing;
  final double elevation;
  final double pressElevation;
  final ChipsChoiceShapeBuilder shapeBuilder;

  const ChipsChoiceItemConfig({
    this.isWrapped = false,
    this.showCheckmark = true,
    this.selectedColor,
    this.unselectedColor,
    this.margin = const EdgeInsets.all(5),
    this.wrappedSpacing = 10.0,
    this.wrappedRunSpacing = 0,
    this.elevation = 0,
    this.pressElevation = 0,
    this.shapeBuilder,
  });
}

typedef ShapeBorder ChipsChoiceShapeBuilder(bool selected);
typedef R ChipsChoiceOptionProp<T, R>(int index, T item);
typedef void ChipsChoiceChanged<T>(T values);
typedef Widget ChipsChoiceBuilder<T>(
  ChipsChoiceOption<T> item,
  ChipsChoiceItemConfig config,
  bool selected
);