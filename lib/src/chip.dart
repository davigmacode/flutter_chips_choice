import 'package:flutter/material.dart';
import 'choice_item.dart';
import 'choice_style.dart';

/// Default choice item widget
class C2Chip<T> extends StatelessWidget {
  /// Choice item data
  final C2Choice<T> data;

  /// Label widget
  final Widget? label;

  /// Avatar widget
  final Widget? avatar;

  final ThemeData appTheme;

  final ChipThemeData chipTheme;

  /// Default constructor
  const C2Chip({
    Key? key,
    required this.data,
    this.label,
    this.avatar,
    required this.appTheme,
    required this.chipTheme,
  }) : super(key: key);

  static EdgeInsetsGeometry defaultPadding = EdgeInsets.all(4.0);
  static EdgeInsetsGeometry defaultMargin = EdgeInsets.all(0);

  /// Default border opacity
  static final double defaultBorderOpacity = .2;

  // These are Material Design defaults, and are used to derive
  // component Colors (with opacity) from base colors.
  static double backgroundAlpha = .12; // 10%
  static double borderAlpha = .21; // 20%
  static int foregroundAlpha = 0xde; // 87%
  static int disabledAlpha = 0x0c; // 38% * 12% = 5%

  /// Create border shape
  static OutlinedBorder createBorderShape({
    required Color color,
    double? width,
    BorderRadiusGeometry? radius,
    BorderStyle? style,
  }) {
    final BorderSide side = BorderSide(
      color: color,
      width: width ?? 0,
      style: style ?? BorderStyle.none,
    );
    return radius == null
        ? StadiumBorder(side: side)
        : RoundedRectangleBorder(
            borderRadius: radius,
            side: side,
          );
  }

  /// Create avatar shape
  static ShapeBorder createAvatarShape({
    Color? color,
    double? width,
    BorderRadiusGeometry? radius,
    BorderStyle? style,
  }) {
    final BorderSide side = BorderSide(
      color: color ?? Colors.transparent,
      width: width ?? 0,
      style: style ?? BorderStyle.none,
    );
    return radius == null
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            borderRadius: radius,
            side: side,
          );
  }

  @override
  Widget build(BuildContext context) {
    final C2ChoiceStyle? style = data.effectiveStyle;

    final bool isFlatten = style?.isFlatten ?? false;
    final bool isElevated = style?.isElevated ?? false;
    final bool isOutlined = style?.isOutlined ?? false;

    // final Color primaryColor = style?.color ??
    //     chipTheme.backgroundColor ??
    //     appTheme.unselectedWidgetColor;

    final unselectedColor =
        chipTheme.backgroundColor ?? appTheme.unselectedWidgetColor;
    final selectedColor = appTheme.colorScheme.primary;
    final effectiveColor = data.selected ? selectedColor : unselectedColor;

    // final Color primaryColor =
    //     chipTheme.backgroundColor ??
    //     appTheme.unselectedWidgetColor;

    final double backgroundOpacity =
        style?.backgroundOpacity ?? backgroundAlpha;

    // final Color backgroundColor = isElevated
    //     ? primaryColor
    //     : isOutlined
    //         ? Colors.transparent
    //         : primaryColor.withOpacity(backgroundOpacity);
    final Color backgroundColor =
        data.style?.backgroundColor ?? unselectedColor;
    final Color selectedBackgroundColor =
        data.activeStyle?.backgroundColor ?? selectedColor;

    final Color disabledColor =
        style?.disabledColor ?? unselectedColor.withAlpha(disabledAlpha);

    // final Color secondaryColor = style?.color ?? appTheme.colorScheme.primary;
    // final Color secondaryColor = appTheme.colorScheme.primary;

    // final Color selectedColor = isElevated
    //     ? secondaryColor
    //     : isOutlined
    //         ? Colors.transparent
    //         : secondaryColor.withOpacity(backgroundOpacity);
    // final Color selectedColor = isElevated
    //     ? secondaryColor
    //     : isOutlined
    //         ? Colors.transparent
    //         : secondaryColor.withOpacity(backgroundOpacity);

    // final Color foregroundColor = isElevated
    //     ? Colors.white
    //     : data.selected
    //         ? secondaryColor.withAlpha(foregroundAlpha)
    //         : primaryColor.withAlpha(foregroundAlpha);
    final foregroundColor = style?.foregroundColor ?? effectiveColor;

    final defaultLabelStyle =
        TextStyle().merge(chipTheme.labelStyle).merge(style?.labelStyle);

    final primaryLabelStyle =
        defaultLabelStyle.copyWith(color: foregroundColor);

    // final TextStyle selectedLabelStyle = defaultLabelStyle.copyWith(
    //   color:
    //       isElevated ? Colors.white : secondaryColor.withAlpha(foregroundAlpha),
    // );

    // final TextStyle labelStyle = data.selected ? selectedLabelStyle : primaryLabelStyle;

    final labelStyle = TextStyle()
        .merge(chipTheme.labelStyle)
        .merge(style?.labelStyle)
        .copyWith(color: foregroundColor);

    final effectiveBorderOpacity = style?.borderOpacity ?? borderAlpha;
    final effectiveBorderColor = data.selected
        ? selectedColor.withOpacity(effectiveBorderOpacity)
        : unselectedColor.withOpacity(effectiveBorderOpacity);
    final borderShape = createBorderShape(
      color: style?.borderColor ?? effectiveBorderColor,
      width: style?.borderWidth,
      radius: style?.borderRadius,
      style: style?.borderStyle,
    );

    return Padding(
      padding: style?.margin ?? defaultMargin,
      child: RawChip(
        padding: style?.padding ?? defaultPadding,
        shape: style?.borderShape ?? borderShape,
        clipBehavior: style?.clipBehavior ?? Clip.none,
        materialTapTargetSize: style?.materialTapTargetSize,
        label: label ?? Text(data.label),
        labelStyle: labelStyle,
        labelPadding: style?.labelPadding,
        avatar: avatar,
        avatarBorder: style?.avatarBorderShape ??
            createAvatarShape(
              color: style?.avatarBorderColor,
              width: style?.avatarBorderWidth,
              radius: style?.avatarBorderRadius,
              style: style?.avatarBorderStyle,
            ),
        elevation: style?.elevation,
        pressElevation: style?.pressElevation,
        shadowColor: data.style?.shadowColor,
        selectedShadowColor: data.activeStyle?.shadowColor,
        backgroundColor: isFlatten
            ? backgroundColor.withOpacity(backgroundOpacity)
            : backgroundColor,
        selectedColor: isFlatten
            ? selectedBackgroundColor.withOpacity(backgroundOpacity)
            : selectedBackgroundColor,
        disabledColor: disabledColor,
        deleteIconColor: foregroundColor,
        checkmarkColor: foregroundColor,
        showCheckmark: style?.showCheckmark ?? false,
        isEnabled: data.disabled != true,
        selected: data.selected,
        onPressed: () => data.select!(!data.selected),
      ),
    );
  }
}
