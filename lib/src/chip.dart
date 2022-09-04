import 'package:flutter/material.dart';
import 'model/choice_item.dart';
import 'model/choice_style.dart';

/// Default choice item widget
class C2Chip<T> extends StatelessWidget {
  /// Choice item data
  final C2Choice<T> data;

  /// Label widget
  final Widget? label;

  /// Avatar widget
  final Widget? avatar;

  /// Default constructor
  const C2Chip({
    Key? key,
    required this.data,
    this.label,
    this.avatar,
  }) : super(key: key);

  static EdgeInsetsGeometry defaultPadding = EdgeInsets.all(4.0);
  static EdgeInsetsGeometry defaultMargin = EdgeInsets.all(0);

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

  /// Default border opacity
  static final double defaultBorderOpacity = .2;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final ChipThemeData chipTheme = ChipTheme.of(context);

    final C2ChoiceStyle? style = data.effectiveStyle;

    final Brightness? brightness = style?.brightness ?? chipTheme.brightness;

    // final bool isDark = brightness == Brightness.dark;

    final bool isElevated = style?.isElevated ?? false;

    final bool isOutlined = style?.isOutlined ?? false;

    final Color primaryColor = style?.color ??
        chipTheme.backgroundColor ??
        appTheme.unselectedWidgetColor;

    final double backgroundOpacity =
        style?.effectiveBackgroundOpacity ?? backgroundAlpha;

    final Color backgroundColor = isElevated
        ? primaryColor
        : isOutlined
            ? Colors.transparent
            : primaryColor.withOpacity(backgroundOpacity);

    final Color disabledColor = primaryColor.withAlpha(disabledAlpha);

    final Color secondaryColor = style?.color ?? appTheme.colorScheme.primary;

    final Color selectedColor = isElevated
        ? secondaryColor
        : isOutlined
            ? Colors.transparent
            : secondaryColor.withOpacity(backgroundOpacity);

    final Color foregroundColor = isElevated
        ? Colors.white
        : data.selected
            ? secondaryColor.withAlpha(foregroundAlpha)
            : primaryColor.withAlpha(foregroundAlpha);

    final TextStyle defaultLabelStyle =
        TextStyle().merge(chipTheme.labelStyle).merge(style?.labelStyle);

    final TextStyle primaryLabelStyle =
        defaultLabelStyle.copyWith(color: foregroundColor);

    final TextStyle selectedLabelStyle = defaultLabelStyle.copyWith(
      color:
          isElevated ? Colors.white : secondaryColor.withAlpha(foregroundAlpha),
    );

    final double effectiveBorderOpacity =
        style?.effectiveBorderOpacity ?? borderAlpha;

    final Color effectiveBorderColor = data.selected
        ? secondaryColor.withOpacity(effectiveBorderOpacity)
        : primaryColor.withOpacity(effectiveBorderOpacity);

    final OutlinedBorder? borderShape = createBorderShape(
      color: effectiveBorderColor,
      width: style?.borderWidth ?? (isOutlined ? 1 : 0),
      radius: style?.borderRadius,
      style: isOutlined ? BorderStyle.solid : style?.borderStyle,
    );

    return ChipTheme(
      data: ChipThemeData(
        brightness: brightness,
        secondarySelectedColor: selectedColor,
        secondaryLabelStyle: selectedLabelStyle,
      ),
      child: Padding(
        padding: style?.margin ?? defaultMargin,
        child: RawChip(
          padding: style?.padding ?? defaultPadding,
          shape: style?.borderShape ?? borderShape,
          clipBehavior: style?.clipBehavior ?? Clip.none,
          materialTapTargetSize: style?.materialTapTargetSize,
          tooltip: data.tooltip,
          label: label ?? Text(data.label),
          labelStyle: primaryLabelStyle,
          labelPadding: style?.labelPadding,
          avatar: avatar,
          avatarBorder: style?.avatarBorderShape ??
              createAvatarShape(
                color: style?.avatarBorderColor,
                width: style?.avatarBorderWidth,
                radius: style?.avatarBorderRadius,
                style: style?.avatarBorderStyle,
              ),
          elevation: !isOutlined ? style?.elevation : 0,
          pressElevation: !isOutlined ? style?.pressElevation : 0,
          shadowColor: data.style?.color,
          selectedShadowColor: data.activeStyle?.color,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          disabledColor: disabledColor,
          deleteIconColor: foregroundColor,
          checkmarkColor: foregroundColor,
          showCheckmark: style?.showCheckmark ?? false,
          isEnabled: data.disabled != true,
          selected: data.selected,
          onPressed: () => data.select!(!data.selected),
        ),
      ),
    );
  }
}
