import 'package:flutter/foundation.dart';

/// Choice option
class C2Choice<T> {

  /// Value to return
  final T value;

  /// Represent as primary text
  final String label;

  /// Tooltip string to be used for the body area (where the label and avatar are) of the chip.
  final String tooltip;

  /// Whether the choice is disabled or not
  final bool disabled;

  /// Whether the choice is hidden or displayed
  final bool hidden;

  /// This prop is useful for choice builder
  final dynamic meta;

  /// Callback to select choice
  final Function(bool selected) select;

  /// Whether the choice is selected or not
  final bool selected;

  /// Default Constructor
  const C2Choice({
    @required this.value,
    @required this.label,
    this.tooltip,
    this.disabled = false,
    this.hidden = false,
    this.meta,
    this.select,
    this.selected = false,
  }) : assert(disabled != null),
    assert(hidden != null);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is C2Choice &&
        runtimeType == other.runtimeType &&
        value == other.value;

  @override
  int get hashCode => value.hashCode;

  /// Helper to create choice items from any list
  static List<C2Choice<R>> listFrom<R, E>({
    @required List<E> source,
    @required _C2ChoiceProp<E, R> value,
    @required _C2ChoiceProp<E, String> label,
    _C2ChoiceProp<E, String> tooltip,
    _C2ChoiceProp<E, bool> disabled,
    _C2ChoiceProp<E, bool> hidden,
    _C2ChoiceProp<E, dynamic> meta,
  }) => source
    .asMap()
    .map((index, item) => MapEntry(index, C2Choice<R>(
      value: value?.call(index, item),
      label: label?.call(index, item),
      tooltip: tooltip?.call(index, item),
      disabled: disabled?.call(index, item) ?? false,
      hidden: hidden?.call(index, item) ?? false,
      meta: meta?.call(index, item),
    )))
    .values
    .toList()
    .cast<C2Choice<R>>();

  /// Creates a copy of this [C2Choice] but with
  /// the given fields replaced with the new values.
  C2Choice<T> copyWith({
    T value,
    String label,
    String tooltip,
    bool disabled,
    bool hidden,
    dynamic meta,
    Function(bool selected) select,
    bool selected,
  }) {
    return C2Choice<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      tooltip: tooltip ?? this.tooltip,
      disabled: disabled ?? this.disabled,
      hidden: hidden ?? this.hidden,
      meta: meta ?? this.meta,
      select: select ?? this.select,
      selected: selected ?? this.selected,
    );
  }

  /// Creates a copy of this [S2Choice] but with
  /// the given fields replaced with the new values.
  C2Choice<T> merge(C2Choice<T> other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      value: other.value,
      label: other.label,
      tooltip: other.tooltip,
      disabled: other.disabled,
      hidden: other.hidden,
      meta: other.meta,
      select: other.select,
      selected: other.selected,
    );
  }
}

/// Builder for option prop
typedef R _C2ChoiceProp<T, R>(int index, T item);
