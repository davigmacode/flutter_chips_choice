import 'package:flutter/material.dart';
import 'model/choice_item.dart';
import 'model/choice_style.dart';

/// Default choice item widget
class C2Chip<T> extends StatelessWidget {

  /// choice item data
  final C2Choice<T> data;

  /// unselected choice style
  final C2ChoiceStyle style;

  /// selected choice style
  final C2ChoiceStyle activeStyle;

  /// label widget
  final Widget? label;

  /// avatar widget
  final Widget? avatar;

  /// default constructor
  const C2Chip({
    Key? key,
    required this.data,
    required this.style,
    required this.activeStyle,
    this.label,
    this.avatar,
  }) : super(key: key);

  /// get shape border
  static ShapeBorder getShapeBorder({
    required Color color,
    double? width,
    BorderRadiusGeometry? radius,
    BorderStyle? style,
  }) {
    final BorderSide side = BorderSide(
      color: color,
      width: width ?? 1.0,
      style: style ?? BorderStyle.solid
    );
    return radius == null
      ? StadiumBorder(side: side)
      : RoundedRectangleBorder(
          borderRadius: radius,
          side: side,
        );
  }

  /// get shape border
  static ShapeBorder getAvatarShapeBorder({
    required Color? color,
    double? width,
    BorderRadiusGeometry? radius,
    BorderStyle? style,
  }) {
    final BorderSide side = BorderSide(
      color: color ?? const Color(0xFF000000),
      width: width ?? 1.0,
      style: style ?? BorderStyle.none
    );
    return radius == null
      ? CircleBorder(side: side)
      : RoundedRectangleBorder(
          borderRadius: radius,
          side: side,
        );
  }

  /// default border opacity
  static final double defaultBorderOpacity = .2;

  @override
  Widget build(BuildContext context) {
    final C2ChoiceStyle effectiveStyle = data.selected
      ? activeStyle
      : style;

    final bool isDark = effectiveStyle.brightness == Brightness.dark;

    final Color? textColor = isDark
      ? const Color(0xFFFFFFFF)
      : effectiveStyle.color;

    final Color borderColor = isDark
      ? const Color(0x00000000)
      : textColor!.withOpacity(effectiveStyle.borderOpacity ?? defaultBorderOpacity);

    final Color? checkmarkColor = isDark
      ? textColor
      : activeStyle.color;

    final Color? backgroundColor = isDark
      ? style.color
      : const Color(0x00000000);

    final Color? selectedBackgroundColor = isDark
      ? activeStyle.color
      : const Color(0x00000000);

    return Padding(
      padding: effectiveStyle.margin!,
      child: RawChip(
        padding: effectiveStyle.padding,
        label: label ?? Text(data.label),
        labelStyle: TextStyle(color: textColor).merge(effectiveStyle.labelStyle),
        labelPadding: effectiveStyle.labelPadding,
        avatar: avatar,
        avatarBorder: effectiveStyle.avatarBorderShape ?? getAvatarShapeBorder(
          color: effectiveStyle.avatarBorderColor,
          width: effectiveStyle.avatarBorderWidth,
          radius: effectiveStyle.avatarBorderRadius,
          style: effectiveStyle.avatarBorderStyle,
        ),
        tooltip: data.tooltip,
        shape: effectiveStyle.borderShape as OutlinedBorder? ?? getShapeBorder(
          color: effectiveStyle.borderColor ?? borderColor,
          width: effectiveStyle.borderWidth,
          radius: effectiveStyle.borderRadius,
          style: effectiveStyle.borderStyle,
        ) as OutlinedBorder?,
        clipBehavior: effectiveStyle.clipBehavior ?? Clip.none,
        elevation: effectiveStyle.elevation ?? 0,
        pressElevation: effectiveStyle.pressElevation ?? 0,
        shadowColor: style.color,
        selectedShadowColor: activeStyle.color,
        backgroundColor: backgroundColor,
        selectedColor: selectedBackgroundColor,
        checkmarkColor: checkmarkColor,
        showCheckmark: effectiveStyle.showCheckmark,
        materialTapTargetSize: effectiveStyle.materialTapTargetSize,
        disabledColor: effectiveStyle.disabledColor ?? Colors.blueGrey.withOpacity(.1),
        isEnabled: data.disabled != true,
        selected: data.selected,
        onSelected: (_selected) => data.select!(_selected),
      ),
    );
  }
}