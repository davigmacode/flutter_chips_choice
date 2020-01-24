library chips_choice;

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show FilterChip, ThemeData, Theme;

/// Easy way to provide a single or multiple choice chips.
class ChipsChoice<T> extends StatelessWidget {

  /// List of option item
  final List<ChipsChoiceOption<T>> options;

  /// Choice item config
  final ChipsChoiceItemConfig itemConfig;

  /// Builder for custom choice item
  final ChipsChoiceBuilder<T> itemBuilder;

  /// Whether the chips is wrapped or scrollable
  final bool isWrapped;

  /// List padding
  final EdgeInsetsGeometry padding;

  final T _value;
  final List<T> _values;
  final ChipsChoiceChanged<T> _onChangedSingle;
  final ChipsChoiceChanged<List<T>> _onChangedMultiple;
  final bool _isMultiChoice;

  /// Costructor for single choice
  ChipsChoice.single({
    Key key,
    @required T value,
    @required this.options,
    @required ChipsChoiceChanged<T> onChanged,
    this.itemConfig = const ChipsChoiceItemConfig(),
    this.itemBuilder,
    this.isWrapped = false,
    this.padding,
  }) : assert(onChanged != null),
    assert(isWrapped != null),
    _isMultiChoice = false,
    _value = value,
    _values = null,
    _onChangedMultiple = null,
    _onChangedSingle = onChanged,
    super(key: key);

  /// Constructor for multiple choice
  ChipsChoice.multiple({
    Key key,
    @required List<T> value,
    @required this.options,
    @required ChipsChoiceChanged<List<T>> onChanged,
    this.itemConfig = const ChipsChoiceItemConfig(),
    this.itemBuilder,
    this.isWrapped = false,
    this.padding,
  }) : assert(onChanged != null),
    assert(isWrapped != null),
    _isMultiChoice = true,
    _value = null,
    _values = value ?? [],
    _onChangedSingle = null,
    _onChangedMultiple = onChanged,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWrapped == true
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
        spacing: itemConfig.spacing, // gap between adjacent chips
        runSpacing: itemConfig.runSpacing, // gap between lines
        children: _choiceItems,
      ),
    );
  }

  List<Widget> get _choiceItems {
    return List<Widget>
      .generate(options.length, _choiceItemsGenerator)
      .where((e) => e != null).toList();
  }

  Widget _choiceItemsGenerator(int i) {
    ChipsChoiceOption<T> item = options[i];
    bool selected = _isMultiChoice
      ? _values.contains(item.value)
      : _value == item.value;
    return item.hidden == false
      ? itemBuilder?.call(item, selected, _onSelect) ?? _ChipsChoiceItem(
          item: item,
          config: itemConfig,
          selected: selected,
          onSelect: _onSelect,
          isWrapped: isWrapped,
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

// Default choice item
class _ChipsChoiceItem<T> extends StatelessWidget {

  final ChipsChoiceOption<T> item;
  final ChipsChoiceItemConfig config;
  final Function onSelect;
  final bool selected;
  final bool isWrapped;

  _ChipsChoiceItem({
    Key key,
    @required this.item,
    @required this.config,
    @required this.onSelect,
    @required this.selected,
    this.isWrapped = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Color _selectedColor = config.selectedColor ?? _theme.primaryColor;
    Color _unselectedColor = config.unselectedColor ?? _theme.unselectedWidgetColor;

    return Padding(
      padding: config.margin ?? isWrapped ? EdgeInsets.all(0) : EdgeInsets.all(5),
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
        backgroundColor: Color(0x00000000),
        selectedColor: Color(0x00000000),
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

/// Choice option
class ChipsChoiceOption<T> {

  /// Value to return
  final T value;

  /// Represent as primary text
  final String label;

  /// Represent as chips avatar
  final Widget avatar;

  /// Whether the choice is disabled or not
  final bool disabled;

  /// Whether the choice is hidden or displayed
  final bool hidden;

  /// Default Constructor
  ChipsChoiceOption({
    @required this.value,
    @required this.label,
    this.avatar,
    this.disabled = false,
    this.hidden = false,
  }) : assert(disabled != null),
    assert(hidden != null);

  /// Helper to create option list from any list
  static List<ChipsChoiceOption<R>> listFrom<R, E>({
    @required List<E> source,
    @required _ChipsChoiceOptionProp<E, R> value,
    @required _ChipsChoiceOptionProp<E, String> label,
    _ChipsChoiceOptionProp<E, Widget> avatar,
    _ChipsChoiceOptionProp<E, bool> disabled,
    _ChipsChoiceOptionProp<E, bool> hidden,
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

/// Choice item configuration
class ChipsChoiceItemConfig {

  /// whether the chips use checkmark or not
  final bool showCheckmark;

  /// Selected item color
  final Color selectedColor;

  /// Unselected item color
  final Color unselectedColor;

  /// choice item margin
  final EdgeInsetsGeometry margin;

  /// How much space to place between children in a run in the main axis.
  /// When [ChipsChoice.isWrapped] is [true]
  final double spacing;

  /// How much space to place between the runs themselves in the cross axis.
  /// When [ChipsChoice.isWrapped] is [true]
  final double runSpacing;

  /// Chips elevation
  final double elevation;

  /// Longpress chips elevation
  final double pressElevation;

  /// Chips shape builder
  final ChipsChoiceShapeBuilder shapeBuilder;

  /// Default Constructor
  const ChipsChoiceItemConfig({
    this.showCheckmark = true,
    this.selectedColor,
    this.unselectedColor,
    this.margin,
    this.spacing = 10.0,
    this.runSpacing = 0,
    this.elevation = 0,
    this.pressElevation = 0,
    this.shapeBuilder,
  });
}

/// Builder for option prop
typedef R _ChipsChoiceOptionProp<T, R>(int index, T item);

/// Builder for chips shape border
typedef ShapeBorder ChipsChoiceShapeBuilder(bool selected);

/// Callback when the value changed
typedef void ChipsChoiceChanged<T>(T values);

/// Builder for custom choice item
typedef Widget ChipsChoiceBuilder<T>(
  ChipsChoiceOption<T> item,
  bool selected,
  Function(T value, bool selected) onSelect,
);