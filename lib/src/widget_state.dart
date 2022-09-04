part of 'widget.dart';

/// Chips Choice State
abstract class C2State<T> extends State<ChipsChoice<T>> {
  /// Whether the chips is scrollable or not
  bool get isScrollable => !widget.wrapped;

  /// Whether the widget is multiple choice or not
  bool get isMultiChoice => widget.isMultiChoice;

  /// Whether the widget is single choice or not
  bool get isSingleChoice => !isMultiChoice;

  /// Current selected value
  get value;

  /// Called when value changed
  get onChanged;

  /// Default chip margin
  EdgeInsetsGeometry get defaultChipMargin => isScrollable
      ? ChipsChoice.defaultScrollableChipMargin
      : ChipsChoice.defaultWrappedChipMargin;

  /// Default style for unselected choice item
  C2ChoiceStyle get defaultChoiceStyle => C2ChoiceStyle(
        margin: defaultChipMargin,
      );

  /// Default style for selected choice item
  C2ChoiceStyle get defaultActiveChoiceStyle => defaultChoiceStyle;

  /// Placeholder string
  String get placeholder =>
      widget.placeholder ?? ChipsChoice.defaultPlaceholder;

  /// Choice items
  late List<C2Choice<T>> choiceItems;

  /// Whether the choice items is loading or not
  bool loading = true;

  /// Choice loader error
  Error? error;

  /// Context of the selected choice item
  BuildContext? selectedContext;

  ScrollController get scrollController =>
      widget.scrollController ?? ScrollController();

  /// Function to select a value
  void select(T val, {bool selected = true});

  /// Function to set the context of the selected choice item
  void setSelectedContext(BuildContext context, C2Choice<T> choice);

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
    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      loadChoiceItems(ensureSelectedVisibility: true);
    });
  }

  @override
  void didUpdateWidget(ChipsChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.singleValue != widget.singleValue ||
        oldWidget.multiValue != widget.multiValue ||
        oldWidget.singleOnChanged != widget.singleOnChanged ||
        oldWidget.multiOnChanged != widget.multiOnChanged ||
        !listEquals(oldWidget.choiceItems, widget.choiceItems) ||
        oldWidget.choiceLoader != widget.choiceLoader ||
        oldWidget.choiceStyle != widget.choiceStyle ||
        oldWidget.choiceActiveStyle != widget.choiceActiveStyle) {
      loadChoiceItems();
    }
  }

  /// load the choice items
  void loadChoiceItems({ensureSelectedVisibility = false}) async {
    try {
      setState(() {
        error = null;
        loading = true;
      });
      if (widget.choiceLoader != null) {
        final List<C2Choice<T>> items = await widget.choiceLoader!();
        setChoiceItems(items);
      } else {
        setChoiceItems(widget.choiceItems);
      }
    } catch (e) {
      setState(() => error = e as Error?);
    } finally {
      setState(() => loading = false);
      if (ensureSelectedVisibility == true) scrollToSelected();
    }
  }

  void setChoiceItems(List<C2Choice<T>> _choiceItems) {
    setState(() => choiceItems = _choiceItems
        .map((e) => e.copyWith(
              style:
                  defaultChoiceStyle.merge(widget.choiceStyle).merge(e.style),
              activeStyle: defaultActiveChoiceStyle
                  .merge(widget.choiceStyle)
                  .merge(e.style)
                  .merge(widget.choiceActiveStyle)
                  .merge(e.activeStyle),
              selected: widget.isMultiChoice
                  ? widget.multiValue?.contains(e.value)
                  : widget.singleValue == e.value,
              select: (selected) => select(e.value, selected: selected),
            ))
        .toList());
  }

  /// Scroll to the selected choice item
  void scrollToSelected() {
    if (isScrollable && selectedContext != null) {
      scrollController.position
          .ensureVisible(selectedContext!.findRenderObject()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry padding =
        widget.padding ?? ChipsChoice.defaultPadding;
    return loading == true
        ? C2Spinner(
            padding: padding,
            size: widget.spinnerSize,
            color: widget.spinnerColor,
            thickness: widget.spinnerThickness,
          )
        : choiceItems.isNotEmpty
            ? isScrollable
                ? listScrollable
                : listWrapped
            : error != null
                ? widget.errorBuilder?.call(context) ??
                    C2Placeholder(
                      padding: padding,
                      style: widget.errorStyle,
                      align: widget.errorAlign,
                      message: error.toString(),
                    )
                : widget.placeholderBuilder?.call(context) ??
                    C2Placeholder(
                      padding: padding,
                      style: widget.placeholderStyle,
                      align: widget.placeholderAlign,
                      message: placeholder,
                    );
  }

  /// The scrollable choice items
  Widget get listScrollable {
    return SingleChildScrollView(
      padding: widget.padding ?? ChipsChoice.defaultScrollablePadding,
      scrollDirection: widget.direction,
      clipBehavior: widget.clipBehavior,
      physics: widget.scrollPhysics,
      controller: scrollController,
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

  /// The non scrollable choice items
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

  /// List of widget of the choice items
  List<Widget> get choiceChips {
    return List<Widget>.generate(choiceItems.length, choiceChipsGenerator);
  }

  /// Widget generator for choice items
  Widget choiceChipsGenerator(int i) {
    final C2Choice<T> item = choiceItems[i];
    return item.hidden == true
        ? Container()
        : Builder(
            builder: (context) {
              setSelectedContext(context, item);
              return widget.choiceBuilder?.call(item) ??
                  C2Chip(
                    key: ValueKey('${item.value} - ${item.selected}'),
                    data: item,
                    label: widget.choiceLabelBuilder?.call(item),
                    avatar: widget.choiceAvatarBuilder?.call(item),
                  );
            },
          );
  }
}

/// This allows a value of type T or T?
/// to be treated as a value of type T?.
///
/// We use this so that APIs that have become
/// non-nullable can still be used with `!` and `?`
/// to support older versions of the API as well.
T? _ambiguate<T>(T? value) => value;
