import 'package:flutter/material.dart';

/// Type of what the choice state can do
enum C2ChipType {
  /// indicates the choices try to loading items at the first time
  elevated,

  /// indicates the choices try to refreshing items
  outlined,

  /// indicates the choices try to appending items
  flatten,
}

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

  /// The Chip Appearance
  final C2ChipType appearance;

  /// Whether the chip appearance is raised or not
  bool get isElevated => appearance == C2ChipType.elevated;

  /// Whether the chip appearance is outlined or not
  bool get isOutlined => appearance == C2ChipType.outlined;

  /// Whether the chip appearance is outlined or not
  bool get isFlatten => appearance == C2ChipType.flatten;

  /// If [isOutlined] is [true] this value becomes the border opacity, defaults to `0.3`
  ///
  /// If [isFlatten] is [true] this value becomes the background opacity, defaults to `0.12`
  final double? opacity;

  /// Chips elevation
  final double? elevation;

  /// Long press chips elevation
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
  final OutlinedBorder? borderShape;

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

  /// Whether the brightness is [Brightness.dark] or not
  bool get isDark => brightness == Brightness.dark;

  /// Whether the brightness is [Brightness.dark] or not
  bool get isLight => brightness == Brightness.light;

  double get effectiveBorderOpacity {
    return borderOpacity ?? opacity ?? 0.3;
  }

  double get effectiveBackgroundOpacity {
    return opacity ?? 0.12;
  }

  /// Return the effective border shape
  OutlinedBorder get effectiveBorderShape {
    final BorderSide side = BorderSide(
      color: borderColor ?? Colors.black54,
      width: borderWidth ?? 1.0,
      style: borderStyle ?? BorderStyle.solid,
    );
    return borderRadius == null
        ? StadiumBorder(side: side)
        : RoundedRectangleBorder(
            borderRadius: borderRadius!,
            side: side,
          );
  }

  /// Return the effective avatar shape
  ShapeBorder get effectiveAvatarShape {
    final BorderSide side = BorderSide(
      color: avatarBorderColor ?? Colors.black54,
      width: avatarBorderWidth ?? 1.0,
      style: avatarBorderStyle ?? BorderStyle.none,
    );
    return avatarBorderRadius == null
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            borderRadius: avatarBorderRadius!,
            side: side,
          );
  }

  /// Default Constructor
  const C2ChoiceStyle({
    this.color,
    this.margin,
    this.padding,
    this.appearance = C2ChipType.flatten,
    this.opacity,
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
    C2ChipType? appearance,
    double? opacity,
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
    OutlinedBorder? borderShape,
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
      appearance: appearance ?? this.appearance,
      opacity: opacity ?? this.opacity,
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
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
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
      appearance: other.appearance,
      opacity: other.opacity,
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
