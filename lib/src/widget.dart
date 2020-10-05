import 'package:chips_choice/src/model/choice_style.dart';
import 'package:flutter/material.dart';
import 'model/wrap_config.dart';
import 'model/choice_style.dart';
import 'model/choice_item.dart';
import 'model/types.dart';
import 'chip.dart';

/// Easy way to provide a single or multiple choice chips.
class ChipsChoice<T> extends StatelessWidget {

  /// List of option item
  final List<C2Choice<T>> choiceItems;

  /// Choice unselected item style
  final C2Style choiceStyle;

  /// Choice selected item style
  final C2Style choiceActiveStyle;

  /// Builder for custom choice item
  final C2Builder<T> choiceBuilder;

  /// Builder for custom choice item label
  final C2Builder<T> choiceLabelBuilder;

  /// Builder for custom choice item label
  final C2Builder<T> choiceAvatarBuilder;

  /// Whether the chips is wrapped or scrollable
  final bool wrapped;

  /// If [wrapped], determines how wrap will align the objects
  final C2WrapConfig wrapConfig;

  /// List padding
  final EdgeInsetsGeometry padding;

  final T _value;
  final List<T> _values;
  final C2Changed<T> _onChangedSingle;
  final C2Changed<List<T>> _onChangedMultiple;
  final bool _isMultiChoice;

  /// Costructor for single choice
  ChipsChoice.single({
    Key key,
    @required T value,
    @required C2Changed<T> onChanged,
    @required this.choiceItems,
    this.choiceStyle = const C2Style(),
    this.choiceActiveStyle = const C2Style(),
    this.choiceBuilder,
    this.choiceLabelBuilder,
    this.choiceAvatarBuilder,
    this.wrapped = false,
    this.wrapConfig = const C2WrapConfig(),
    this.padding,
  }) : assert(onChanged != null),
    assert(choiceItems != null),
    assert(wrapped != null),
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
    @required C2Changed<List<T>> onChanged,
    @required this.choiceItems,
    this.choiceStyle = const C2Style(),
    this.choiceActiveStyle = const C2Style(),
    this.choiceBuilder,
    this.choiceLabelBuilder,
    this.choiceAvatarBuilder,
    this.wrapped = false,
    this.wrapConfig = const C2WrapConfig(),
    this.padding,
  }) : assert(onChanged != null),
    assert(choiceItems != null),
    assert(wrapped != null),
    _isMultiChoice = true,
    _value = null,
    _values = value ?? [],
    _onChangedSingle = null,
    _onChangedMultiple = onChanged,
    super(key: key);

  /// default padding for scrollable list
  static final EdgeInsetsGeometry defaultScrollablePadding = const EdgeInsets.symmetric(horizontal: 10);

  /// default padding for wrapped list
  static final EdgeInsetsGeometry defaultWrappedPadding = const EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return wrapped == true
      ? _listWrapped(context)
      : _listScrollable(context);
  }

  Widget _listScrollable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? defaultScrollablePadding,
      child: Row(
        children: _choiceItems(context),
      ),
    );
  }

  Widget _listWrapped(BuildContext context) {
    return Padding(
      padding: padding ?? defaultWrappedPadding,
      child: Wrap(
        alignment: wrapConfig.alignment,
        spacing: wrapConfig.spacing, // gap between adjacent chips
        runSpacing: wrapConfig.runSpacing, // gap between lines
        children: _choiceItems(context),
      ),
    );
  }

  List<Widget> _choiceItems(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return List<Widget>
      .generate(choiceItems.length, _choiceItemsGenerator(theme))
      .where((e) => e != null).toList();
  }

  Widget Function(int) _choiceItemsGenerator(ThemeData theme) {
    return (int i) {
      final C2Choice<T> item = choiceItems[i].copyWith(
        selected: _isMultiChoice
          ? _values.contains(choiceItems[i].value)
          : _value == choiceItems[i].value,
        select: _select(choiceItems[i].value),
      );
      return item.hidden == false
        ? choiceBuilder?.call(item) ?? C2Chip(
            data: item,
            style: choiceStyle.copyWith(
              color: choiceStyle.color ?? theme.unselectedWidgetColor
            ),
            activeStyle: choiceActiveStyle.copyWith(
              color: choiceActiveStyle.color ?? theme.primaryColor
            ),
            label: choiceLabelBuilder?.call(item),
            avatar: choiceAvatarBuilder?.call(item),
            isWrapped: wrapped,
          )
        : null;
    };
  }

  Function(bool selected) _select(T value) {
    return (bool selected) {
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
    };
  }
}