import 'package:chips_choice/src/model/choice_style.dart';
import 'package:flutter/material.dart';
import 'model/choice_style.dart';
import 'model/choice_item.dart';
import 'model/types.dart';
import 'chip.dart';

/// Easy way to provide a single or multiple choice chips.
class ChipsChoice<T> extends StatefulWidget {

  /// List of choice item
  final List<C2Choice<T>> choiceItems;

  /// Async loader of choice items
  final C2ChoiceLoader<T> choiceLoader;

  /// Choice unselected item style
  final C2ChoiceStyle choiceStyle;

  /// Choice selected item style
  final C2ChoiceStyle choiceActiveStyle;

  /// Builder for custom choice item label
  final C2Builder<T> choiceLabelBuilder;

  /// Builder for custom choice item label
  final C2Builder<T> choiceAvatarBuilder;

  /// Builder for custom choice item
  final C2Builder<T> choiceBuilder;

  /// Builder for spinner widget
  final WidgetBuilder spinnerBuilder;

  /// Builder for placeholder widget
  final WidgetBuilder placeholderBuilder;

  /// Builder for placeholder widget
  final WidgetBuilder errorBuilder;

  /// Whether the chips is wrapped or scrollable
  final bool wrapped;

  /// Container padding
  final EdgeInsetsGeometry padding;

  /// The direction to use as the main axis.
  final Axis direction;

  /// Determines the order to lay children out vertically and how to interpret start and end in the vertical direction.
  final VerticalDirection verticalDirection;

  /// Determines the order to lay children out horizontally and how to interpret start and end in the horizontal direction.
  final TextDirection textDirection;

  /// if [wrapped] is [false], How the scroll view should respond to user input.
  final ScrollPhysics scrollPhysics;

  /// if [wrapped] is [false], How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// if [wrapped] is [false], How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// if [wrapped] is [false], How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// if [wrapped] is [true], how the children within a run should be aligned relative to each other in the cross axis.
  final WrapCrossAlignment wrapCrossAlignment;

  /// if [wrapped] is [true], determines how wrap will align the objects
  final WrapAlignment alignment;

  /// if [wrapped] is [true], how the runs themselves should be placed in the cross axis.
  final WrapAlignment runAlignment;

  /// if [wrapped] is [true], how much space to place between children in a run in the main axis.
  final double spacing;

  /// if [wrapped] is [true], how much space to place between the runs themselves in the cross axis.
  final double runSpacing;

  /// Clip behavior
  final Clip clipBehavior;

  /// String to display when choice items is empty
  final String placeholder;

  /// placeholder text style
  final TextStyle placeholderStyle;

  /// placeholder text align
  final TextAlign placeholderAlign;

  /// error text style
  final TextStyle errorStyle;

  /// error text align
  final TextAlign errorAlign;

  /// spinner size
  final double spinnerSize;

  /// spinner color
  final Color spinnerColor;

  /// spinner thickness
  final double spinnerThickness;

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
    this.choiceLoader,
    this.choiceStyle,
    this.choiceActiveStyle,
    this.choiceLabelBuilder,
    this.choiceAvatarBuilder,
    this.choiceBuilder,
    this.spinnerBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.wrapped = false,
    this.padding,
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.scrollPhysics,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.spacing = 10.0,
    this.runSpacing = 0,
    this.placeholder,
    this.placeholderStyle,
    this.placeholderAlign,
    this.errorStyle,
    this.errorAlign,
    this.spinnerSize,
    this.spinnerColor,
    this.spinnerThickness,
  }) :
    assert(
      choiceItems != null || choiceLoader != null,
      'One of the parameters must be provided',
    ),
    assert(onChanged != null),
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
    this.choiceLoader,
    this.choiceStyle,
    this.choiceActiveStyle,
    this.choiceLabelBuilder,
    this.choiceAvatarBuilder,
    this.choiceBuilder,
    this.spinnerBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.wrapped = false,
    this.padding,
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.scrollPhysics,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.spacing = 10.0,
    this.runSpacing = 0,
    this.placeholder,
    this.placeholderStyle,
    this.placeholderAlign,
    this.errorStyle,
    this.errorAlign,
    this.spinnerSize,
    this.spinnerColor,
    this.spinnerThickness,
  }) :
    assert(
      choiceItems != null || choiceLoader != null,
      'One of the parameters must be provided',
    ),
    assert(onChanged != null),
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
  static final EdgeInsetsGeometry defaultWrappedPadding = const EdgeInsets.fromLTRB(15, 10, 15, 10);

  /// default padding for spinner and placeholder
  static final EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(20);

  /// default chip margin in wrapped list
  static final EdgeInsetsGeometry defaultWrappedChipMargin = const EdgeInsets.all(0);

  /// default chip margin in scrollable list
  static final EdgeInsetsGeometry defaultScrollableChipMargin = const EdgeInsets.all(5);

  /// default placeholder string
  static final String defaultPlaceholder = 'Empty choice items';

  @override
  ChipsChoiceState<T> createState() => ChipsChoiceState<T>();
}

/// Chips Choice State
class ChipsChoiceState<T> extends State<ChipsChoice<T>> {

  /// get default theme
  ThemeData get theme => Theme.of(context);

  /// default chip margin
  EdgeInsetsGeometry get defaultChipMargin => widget.wrapped
    ? ChipsChoice.defaultWrappedChipMargin
    : ChipsChoice.defaultScrollableChipMargin;

  /// default style for unselected choice item
  C2ChoiceStyle get defaultChoiceStyle => C2ChoiceStyle(
    margin: defaultChipMargin,
    color: theme.unselectedWidgetColor
  );

  /// default style for selected choice item
  C2ChoiceStyle get defaultActiveChoiceStyle => C2ChoiceStyle(
    margin: defaultChipMargin,
    color: theme.primaryColor
  );

  /// get placeholder string
  String get placeholder => widget.placeholder ?? ChipsChoice.defaultPlaceholder;

  /// choice items
  List<C2Choice<T>> choiceItems;

  /// choice loader process indicator
  bool loading = false;

  /// choice loader error
  Error error;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    /// initial load choice items
    loadChoiceItems();
  }

  @override
  void didUpdateWidget(ChipsChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.choiceItems != widget.choiceItems || oldWidget.choiceLoader != widget.choiceLoader) {
      loadChoiceItems();
    }
  }

  /// load the choice items
  void loadChoiceItems () async {
    try {
      setState(() {
        error = null;
        loading = true;
      });
      if (widget.choiceLoader != null) {
        final List<C2Choice<T>> items = await widget.choiceLoader();
        setState(() => choiceItems = items);
      } else {
        setState(() => choiceItems = widget.choiceItems);
      }
    } catch (e) {
      setState(() => error = e);
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
      ? C2Spinner(
          padding: widget.padding ?? ChipsChoice.defaultPadding,
          size: widget.spinnerSize,
          color: widget.spinnerColor,
          thickness: widget.spinnerThickness,
        )
      : choiceItems != null && choiceItems.isNotEmpty
        ? widget.wrapped != true
          ? listScrollable
          : listWrapped
        : error != null
          ? widget.errorBuilder?.call(context) ?? C2Placeholder(
              padding: widget.padding ?? ChipsChoice.defaultPadding,
              style: widget.errorStyle,
              align: widget.errorAlign,
              message: error.toString(),
            )
          : widget.placeholderBuilder?.call(context) ?? C2Placeholder(
              padding: widget.padding ?? ChipsChoice.defaultPadding,
              style: widget.placeholderStyle,
              align: widget.placeholderAlign,
              message: placeholder,
            );
  }

  /// the scrollable list
  Widget get listScrollable {
    return SingleChildScrollView(
      padding: widget.padding ?? ChipsChoice.defaultScrollablePadding,
      scrollDirection: widget.direction,
      clipBehavior: widget.clipBehavior,
      physics: widget.scrollPhysics,
      child: Flex(
        direction: widget.direction,
        verticalDirection: widget.verticalDirection,
        textDirection: widget.textDirection,
        clipBehavior: widget.clipBehavior,
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisAlignment: widget.mainAxisAlignment,
        mainAxisSize: widget.mainAxisSize,
        children: choiceChips,
      ),
    );
  }

  Widget get listScrollableVertical {
    return ListView.builder(
      itemCount: choiceItems.length,
      itemBuilder: (context, i) => choiceChipsGenerator(i),
    );
  }

  /// the wrapped list
  Widget get listWrapped {
    return Padding(
      padding: widget.padding ?? ChipsChoice.defaultWrappedPadding,
      child: Wrap(
        direction: widget.direction,
        textDirection: widget.textDirection,
        verticalDirection: widget.verticalDirection,
        alignment: widget.alignment,
        runAlignment: widget.runAlignment,
        crossAxisAlignment: widget.wrapCrossAlignment,
        spacing: widget.spacing, // gap between adjacent chips
        runSpacing: widget.runSpacing, // gap between lines
        clipBehavior: widget.clipBehavior,
        children: choiceChips,
      ),
    );
  }

  /// generate the choice chips
  List<Widget> get choiceChips {
    return List<Widget>
      .generate(choiceItems.length, choiceChipsGenerator)
      .where((e) => e != null).toList();
  }

  /// choice chips generator
  Widget choiceChipsGenerator (int i) {
    final C2Choice<T> item = choiceItems[i].copyWith(
      selected: widget._isMultiChoice
        ? widget._values.contains(choiceItems[i].value)
        : widget._value == choiceItems[i].value,
      select: _select(choiceItems[i].value),
    );
    return item.hidden == false
      ? widget.choiceBuilder?.call(item) ?? C2Chip(
          data: item,
          style: defaultChoiceStyle
            .merge(widget.choiceStyle)
            .merge(item.style),
          activeStyle: defaultActiveChoiceStyle
            .merge(widget.choiceStyle)
            .merge(item.style)
            .merge(widget.choiceActiveStyle)
            .merge(item.activeStyle),
          label: widget.choiceLabelBuilder?.call(item),
          avatar: widget.choiceAvatarBuilder?.call(item),
        )
      : null;
  }

  /// return the selection function
  Function(bool selected) _select(T value) {
    return (bool selected) {
      if (widget._isMultiChoice) {
        List<T> values = List.from(widget._values ?? []);
        if (selected) {
          values.add(value);
        } else {
          values.remove(value);
        }
        widget._onChangedMultiple?.call(values);
      } else {
        widget._onChangedSingle?.call(value);
      }
    };
  }
}

/// default spinner widget
class C2Spinner extends StatelessWidget {

  /// spinner padding
  final EdgeInsetsGeometry padding;

  /// spinner size
  final double size;

  /// spinner color
  final Color color;

  /// spinner thickness
  final double thickness;

  /// default constructor
  const C2Spinner({
    Key key,
    this.padding,
    this.size,
    this.color,
    this.thickness,
  }) : super(key: key);

  /// default spinner padding
  static final EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(25);

  /// default spinner size
  static final double defaultSize = 20;

  /// default spinner thickness
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
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}

class C2Placeholder extends StatelessWidget {

  /// String to display
  final String message;

  /// placeholder text style
  final TextStyle style;

  /// placeholder text align
  final TextAlign align;

  /// placeholder padding
  final EdgeInsetsGeometry padding;

  /// default constructor
  const C2Placeholder({
    Key key,
    @required this.message,
    this.style,
    this.align,
    this.padding,
  }) : super(key: key);

  /// default text style
  static final TextStyle defaultStyle = const TextStyle();

  /// default text align
  static final TextAlign defaultAlign = TextAlign.left;

  /// default padding
  static final EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? C2Placeholder.defaultPadding,
      child: Text(
        message,
        textAlign: align ?? C2Placeholder.defaultAlign,
        style: C2Placeholder.defaultStyle.merge(style)
      ),
    );
  }
}