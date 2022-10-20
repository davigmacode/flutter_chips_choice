import 'package:flutter/widgets.dart';
import 'chip.dart';

/// Choice item
class C2Choice<T> {
  /// Value to return
  final T value;

  /// Represent as primary text
  final String label;

  /// Typically used as profile image.
  ///
  /// If the avatar is to have the user's initials, use [avatarText] instead.
  final ImageProvider? avatarImage;

  /// The primary content of the chip avatar.
  ///
  /// Typically a [Text] widget.
  final Widget? avatarText;

  /// Tooltip string to be used for the body area (where the label and avatar are) of the chip.
  final String? tooltip;

  /// This prop is useful for choice builder
  final dynamic meta;

  /// Individual choice unselected item style
  final C2ChipStyle? style;

  /// Called when the user taps the [deleteIcon] to delete the chip.
  ///
  /// If null, the delete button will not appear on the chip.
  ///
  /// The chip will not automatically remove itself: this just tells the app
  /// that the user tapped the delete button.
  final VoidCallback? delete;

  /// Callback to select choice
  /// autofill by the system
  /// used in choice builder
  final Function(bool selected)? select;

  /// Whether the choice is selected or not
  /// autofill by the system
  /// used in choice builder
  final bool selected;

  /// Whether the choice is disabled or not
  final bool disabled;

  /// Whether the choice is hidden or displayed
  final bool hidden;

  /// Default Constructor
  const C2Choice({
    required this.value,
    required this.label,
    this.avatarImage,
    this.avatarText,
    this.tooltip,
    this.meta,
    this.style,
    this.delete,
    this.select,
    this.selected = false,
    this.disabled = false,
    this.hidden = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C2Choice &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          label == other.label &&
          avatarImage == other.avatarImage &&
          avatarText == other.avatarText &&
          tooltip == other.tooltip &&
          delete == other.delete &&
          disabled == other.disabled &&
          hidden == other.hidden &&
          selected == other.selected;

  @override
  int get hashCode => Object.hash(
        value,
        label,
        avatarImage,
        avatarText,
        tooltip,
        delete,
        disabled,
        hidden,
        selected,
      );

  /// Helper to create choice items from any list
  static List<C2Choice<R>> listFrom<R, E>({
    required List<E> source,
    required R Function(int index, E item) value,
    required String Function(int index, E item) label,
    _C2ChoiceProp<E, ImageProvider>? avatarImage,
    _C2ChoiceProp<E, Widget>? avatarText,
    _C2ChoiceProp<E, String>? tooltip,
    _C2ChoiceProp<E, bool>? disabled,
    _C2ChoiceProp<E, bool>? hidden,
    _C2ChoiceProp<E, dynamic>? meta,
    _C2ChoiceProp<E, C2ChipStyle>? style,
    _C2ChoiceProp<E, VoidCallback>? delete,
  }) {
    return source
        .asMap()
        .map((index, item) {
          return MapEntry(
            index,
            C2Choice<R>(
              value: value.call(index, item),
              label: label.call(index, item),
              avatarImage: avatarImage?.call(index, item),
              avatarText: avatarText?.call(index, item),
              tooltip: tooltip?.call(index, item),
              disabled: disabled?.call(index, item) ?? false,
              hidden: hidden?.call(index, item) ?? false,
              meta: meta?.call(index, item),
              style: style?.call(index, item),
              delete: delete?.call(index, item),
            ),
          );
        })
        .values
        .toList()
        .cast<C2Choice<R>>();
  }

  /// Creates a copy of this [C2Choice] but with
  /// the given fields replaced with the new values.
  C2Choice<T> copyWith({
    T? value,
    String? label,
    ImageProvider? avatarImage,
    Widget? avatarText,
    String? tooltip,
    bool? disabled,
    bool? hidden,
    dynamic meta,
    C2ChipStyle? style,
    VoidCallback? delete,
    Function(bool selected)? select,
    bool? selected,
  }) {
    return C2Choice<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      avatarImage: avatarImage ?? this.avatarImage,
      avatarText: avatarText ?? this.avatarText,
      tooltip: tooltip ?? this.tooltip,
      disabled: disabled ?? this.disabled,
      hidden: hidden ?? this.hidden,
      meta: meta ?? this.meta,
      style: style ?? this.style,
      delete: delete ?? this.delete,
      select: select ?? this.select,
      selected: selected ?? this.selected,
    );
  }

  /// Creates a copy of this [S2Choice] but with
  /// the given fields replaced with the new values.
  C2Choice<T> merge(C2Choice<T>? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      value: other.value,
      label: other.label,
      avatarImage: other.avatarImage,
      avatarText: other.avatarText,
      tooltip: other.tooltip,
      disabled: other.disabled,
      hidden: other.hidden,
      meta: other.meta,
      style: other.style,
      delete: other.delete,
      select: other.select,
      selected: other.selected,
    );
  }
}

/// Builder for option prop
typedef R? _C2ChoiceProp<E, R>(int index, E item);
