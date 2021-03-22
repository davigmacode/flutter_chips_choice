import 'package:flutter/material.dart';

/// Choice item style configuration
class C2ChoiceStyle {

  /// Item color
  final Color? color;

  /// choice item margin
  final EdgeInsetsGeometry? margin;

  /// The padding between the contents of the chip and the outside [shape].
  ///
  /// Defaults to 4 logical pixels on all sides.
  final EdgeInsetsGeometry? padding;

  /// Chips elevation
  final double? elevation;

  /// Longpress chips elevation
  final double? pressElevation;

  /// whether the chips use checkmark or not
  final bool? showCheckmark;

  /// Chip label style
  final TextStyle? labelStyle;

  /// Chip label padding
  final EdgeInsetsGeometry? labelPadding;

  /// Chip brightness
  final Brightness? brightness;

  /// Chip border color
  final Color? borderColor;

  /// Chip border opacity,
  /// only effect when [brightness] is [Brightness.light]
  final double? borderOpacity;

  /// The width of this side of the border, in logical pixels.
  final double? borderWidth;

  /// The radii for each corner.
  final BorderRadiusGeometry? borderRadius;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none].
  /// This skips painting the border, but the border still has a [width].
  final BorderStyle? borderStyle;

  /// Chips shape border
  final ShapeBorder? borderShape;

  /// Chip border color
  final Color? avatarBorderColor;

  /// The width of this side of the border, in logical pixels.
  final double? avatarBorderWidth;

  /// The radii for each corner.
  final BorderRadiusGeometry? avatarBorderRadius;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none].
  /// This skips painting the border, but the border still has a [width].
  final BorderStyle? avatarBorderStyle;

  /// Chips shape border
  final ShapeBorder? avatarBorderShape;

  /// Chips clip behavior
  final Clip? clipBehavior;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Color to be used for the chip's background indicating that it is disabled.
  ///
  /// It defaults to [Colors.black38].
  final Color? disabledColor;

  /// Default Constructor
  const C2ChoiceStyle({
    this.color,
    this.margin,
    this.padding,
    this.elevation,
    this.pressElevation,
    this.showCheckmark,
    this.labelStyle,
    this.labelPadding,
    this.brightness,
    this.borderColor,
    this.borderOpacity,
    this.borderWidth,
    this.borderRadius,
    this.borderStyle,
    this.borderShape,
    this.avatarBorderColor,
    this.avatarBorderWidth,
    this.avatarBorderRadius,
    this.avatarBorderStyle,
    this.avatarBorderShape,
    this.clipBehavior,
    this.materialTapTargetSize,
    this.disabledColor,
  });

  /// Creates a copy of this [C2ChoiceStyle] but with
  /// the given fields replaced with the new values.
  C2ChoiceStyle copyWith({
    Color? color,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    double? pressElevation,
    bool? showCheckmark,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? labelPadding,
    Brightness? brightness,
    Color? borderColor,
    double? borderOpacity,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    BorderStyle? borderStyle,
    ShapeBorder? borderShape,
    Color? avatarBorderColor,
    double? avatarBorderWidth,
    BorderRadiusGeometry? avatarBorderRadius,
    BorderStyle? avatarBorderStyle,
    ShapeBorder? avatarBorderShape,
    Clip? clipBehavior,
    MaterialTapTargetSize? materialTapTargetSize,
    Color? disabledColor,
  }) {
    return C2ChoiceStyle(
      color: color ?? this.color,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      pressElevation: pressElevation ?? this.pressElevation,
      showCheckmark: showCheckmark ?? this.showCheckmark,
      labelStyle: labelStyle ?? this.labelStyle,
      labelPadding: labelPadding ?? this.labelPadding,
      brightness: brightness ?? this.brightness,
      borderColor: borderColor ?? this.borderColor,
      borderOpacity: borderOpacity ?? this.borderOpacity,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      borderStyle: borderStyle ?? this.borderStyle,
      borderShape: borderShape ?? this.borderShape,
      avatarBorderColor: avatarBorderColor ?? this.avatarBorderColor,
      avatarBorderWidth: avatarBorderWidth ?? this.avatarBorderWidth,
      avatarBorderRadius: avatarBorderRadius ?? this.avatarBorderRadius,
      avatarBorderStyle: avatarBorderStyle ?? this.avatarBorderStyle,
      avatarBorderShape: avatarBorderShape ?? this.avatarBorderShape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      materialTapTargetSize: materialTapTargetSize ?? this.materialTapTargetSize,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  /// Creates a copy of this [C2ChoiceStyle] but with
  /// the given fields replaced with the new values.
  C2ChoiceStyle merge(C2ChoiceStyle? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      color: other.color,
      margin: other.margin,
      padding: other.padding,
      elevation: other.elevation,
      pressElevation: other.pressElevation,
      showCheckmark: other.showCheckmark,
      labelStyle: other.labelStyle,
      labelPadding: other.labelPadding,
      brightness: other.brightness,
      borderColor: other.borderColor,
      borderOpacity: other.borderOpacity,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      borderStyle: other.borderStyle,
      borderShape: other.borderShape,
      avatarBorderColor: other.avatarBorderColor,
      avatarBorderWidth: other.avatarBorderWidth,
      avatarBorderRadius: other.avatarBorderRadius,
      avatarBorderStyle: other.avatarBorderStyle,
      avatarBorderShape: other.avatarBorderShape,
      clipBehavior: other.clipBehavior,
      materialTapTargetSize: other.materialTapTargetSize,
      disabledColor: other.disabledColor,
    );
  }
}