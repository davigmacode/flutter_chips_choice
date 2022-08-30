part of 'widget.dart';

/// Default spinner widget
class C2Spinner extends StatelessWidget {
  /// Spinner padding
  final EdgeInsetsGeometry? padding;

  /// Spinner size
  final double? size;

  /// Spinner color
  final Color? color;

  /// Spinner thickness
  final double? thickness;

  /// Default constructor
  const C2Spinner({
    Key? key,
    this.padding,
    this.size,
    this.color,
    this.thickness,
  }) : super(key: key);

  /// Default spinner padding
  static final EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(25);

  /// Default spinner size
  static final double defaultSize = 20;

  /// Default spinner thickness
  static final double defaultThickness = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? C2Spinner.defaultPadding,
      child: Center(
        child: SizedBox(
          width: size ?? C2Spinner.defaultSize,
          height: size ?? C2Spinner.defaultSize,
          child: CircularProgressIndicator(
            strokeWidth: thickness ?? C2Spinner.defaultThickness,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Default placeholder widget
class C2Placeholder extends StatelessWidget {
  /// String to display
  final String message;

  /// Placeholder text style
  final TextStyle? style;

  /// Placeholder text align
  final TextAlign? align;

  /// Placeholder padding
  final EdgeInsetsGeometry? padding;

  /// Default constructor
  const C2Placeholder({
    Key? key,
    required this.message,
    this.style,
    this.align,
    this.padding,
  }) : super(key: key);

  /// Default text style
  static final TextStyle defaultStyle = const TextStyle();

  /// Default text align
  static final TextAlign defaultAlign = TextAlign.left;

  /// Default padding
  static final EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? C2Placeholder.defaultPadding,
      child: Text(
        message,
        textAlign: align ?? C2Placeholder.defaultAlign,
        style: C2Placeholder.defaultStyle.merge(style),
      ),
    );
  }
}
