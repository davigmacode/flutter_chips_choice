import 'package:flutter/material.dart';
import 'model/choice_item.dart';
import 'model/choice_style.dart';

/// Default choice item widget
class C2Chip<T> extends StatelessWidget {

  /// choice item data
  final C2Choice<T> data;

  /// unselected choice style
  final C2Style style;

  /// selected choice style
  final C2Style activeStyle;

  /// label widget
  final Widget label;

  /// avatar widget
  final Widget avatar;

  final bool isWrapped;

  /// default constructor
  const C2Chip({
    Key key,
    @required this.data,
    @required this.style,
    @required this.activeStyle,
    this.label,
    this.avatar,
    this.isWrapped = false,
  }) : super(key: key);

  /// get shape border
  static ShapeBorder getShapeBorder({
    @required Color color,
    double width,
    double radius,
    BorderStyle style,
  }) {
    final BorderSide side = BorderSide(
      color: color,
      width: width ?? 1.0,
      style: style ?? BorderStyle.solid
    );
    return radius == null
      ? StadiumBorder(side: side)
      : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: side,
        );
  }

  /// get shape border
  static ShapeBorder getAvatarShapeBorder({
    @required Color color,
    double width,
    double radius,
    BorderStyle style,
  }) {
    final BorderSide side = BorderSide(
      color: color ?? const Color(0xFF000000),
      width: width ?? 1.0,
      style: style ?? BorderStyle.none
    );
    return radius == null
      ? CircleBorder(side: side)
      : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: side,
        );
  }

  /// default border opacity
  static final double defaultBorderOpacity = .2;

  /// default chip margin in wrapped list
  static final EdgeInsetsGeometry defaultWrappedMargin = const EdgeInsets.all(0);

  /// default chip margin in scrollable list
  static final EdgeInsetsGeometry defaultScrollableMargin = const EdgeInsets.all(5);

  @override
  Widget build(BuildContext context) {
    final bool isDark = data.selected
      ? activeStyle.brightness == Brightness.dark
      : style.brightness == Brightness.dark;

    final Color textColor = isDark
      ? const Color(0xFFFFFFFF)
      : data.selected ? activeStyle.color : style.color;

    final double borderOpacity = data.selected
      ? activeStyle.borderOpacity
      : style.borderOpacity;

    final Color borderColor = isDark
      ? const Color(0x00000000)
      : textColor.withOpacity(borderOpacity ?? defaultBorderOpacity);

    final Color checkmarkColor = isDark
      ? textColor
      : activeStyle.color;

    final Color backgroundColor = isDark
      ? style.color
      : const Color(0x00000000);

    final Color selectedBackgroundColor = isDark
      ? activeStyle.color
      : const Color(0x00000000);

    final EdgeInsetsGeometry margin = data.selected
      ? activeStyle.margin
      : style.margin;

    final TextStyle labelStyle = data.selected
      ? activeStyle.labelStyle
      : style.labelStyle;

    return Padding(
      padding: margin ?? (isWrapped ? defaultWrappedMargin : defaultScrollableMargin),
      child: FilterChip(
        padding: data.selected
          ? activeStyle.padding
          : style.padding,
        label: label ?? Text(data.label),
        labelStyle: TextStyle(color: textColor).merge(labelStyle),
        labelPadding: data.selected
          ? activeStyle.labelPadding
          : style.labelPadding,
        avatar: avatar,
        avatarBorder: data.selected
          ? activeStyle.avatarBorderShape ?? getAvatarShapeBorder(
              color: activeStyle.avatarBorderColor ?? style.avatarBorderColor,
              width: activeStyle.avatarBorderWidth ?? style.avatarBorderWidth,
              radius: activeStyle.avatarBorderRadius ?? style.avatarBorderRadius,
              style: activeStyle.avatarBorderStyle ?? style.avatarBorderStyle,
            )
          : style.borderShape ?? getAvatarShapeBorder(
              color: style.avatarBorderColor,
              width: style.avatarBorderWidth,
              radius: style.avatarBorderRadius,
              style: style.avatarBorderStyle,
            ),
        tooltip: data.tooltip,
        shape: data.selected
          ? activeStyle.borderShape ?? getShapeBorder(
              color: activeStyle.borderColor ?? borderColor,
              width: activeStyle.borderWidth ?? style.borderWidth,
              radius: activeStyle.borderRadius ?? style.borderRadius,
              style: activeStyle.borderStyle ?? style.borderStyle,
            )
          : style.borderShape ?? getShapeBorder(
              color: style.borderColor ?? borderColor,
              width: style.borderWidth,
              radius: style.borderRadius,
              style: style.borderStyle,
            ),
        clipBehavior: data.selected
          ? activeStyle.clipBehavior ?? Clip.none
          : style.clipBehavior ?? Clip.none,
        elevation: data.selected
          ? activeStyle.elevation
          : style.elevation,
        pressElevation: data.selected
          ? activeStyle.pressElevation
          : style.pressElevation,
        shadowColor: style.color,
        selectedShadowColor: activeStyle.color,
        backgroundColor: backgroundColor,
        selectedColor: selectedBackgroundColor,
        checkmarkColor: checkmarkColor,
        showCheckmark: data.selected
          ? activeStyle.showCheckmark
          : style.showCheckmark,
        materialTapTargetSize: data.selected
          ? activeStyle.materialTapTargetSize
          : style.materialTapTargetSize,
        disabledColor: data.selected
          ? activeStyle.disabledColor ?? style.disabledColor ?? Colors.blueGrey.withOpacity(.1)
          : style.disabledColor ?? Colors.blueGrey.withOpacity(.1),
        selected: data.selected,
        onSelected: data.disabled == false
          ? (_selected) => data.select(_selected)
          : null,
      ),
    );
  }
}