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
  C2ChipStyle get defaultChoiceStyle => C2ChipStyle.toned(
        margin: defaultChipMargin,
      );

  /// Default style for selected choice item
  C2ChipStyle get defaultActiveChoiceStyle => defaultChoiceStyle;

  /// Placeholder string
  String get placeholder =>
      widget.placeholder ?? ChipsChoice.defaultPlaceholder;

  /// Choice items
  List<C2Choice<T>> choiceItems = [];

  /// Async memoizer for choice items
  C2ChoiceMemoizer<T>? choiceItemsMemoizer;

  bool get hasChoiceLoader => widget.choiceLoader != null;

  bool get hasChoiceLoaderRun => choiceItemsMemoizer?.hasRun ?? false;

  /// Whether the choice items is loading or not
  bool loading = false;

  /// Choice loader error
  String error = '';

  ScrollController? _internalScrollController;
  ScrollController? get scrollController {
    return isScrollable
        ? (widget.scrollController ?? _internalScrollController)
        : null;
  }

  @protected
  BuildContext? selectedContext;

  /// Function to select a value
  void select(T val, {bool selected = true});

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    initScrollController();
    loadChoiceItems(ensureSelectedVisibility: true);
    super.initState();
  }

  @override
  void dispose() {
    disposeScrollController();
    super.dispose();
  }

  @override
  void didUpdateWidget(ChipsChoice<T> oldWidget) {
    if (oldWidget.scrollController != widget.scrollController) {
      initScrollController();
    }

    if (!listEquals(oldWidget.choiceItems, widget.choiceItems) ||
        oldWidget.choiceLoader != widget.choiceLoader) {
      loadChoiceItems();
    }

    super.didUpdateWidget(oldWidget);
  }

  @protected
  void initScrollController() {
    _internalScrollController = isScrollable && widget.scrollController == null
        ? ScrollController()
        : null;
    scrollController?.addListener(didChangeScrollController);
  }

  @protected
  void didChangeScrollController() {
    setState(() {});
  }

  @protected
  void disposeScrollController() {
    scrollController?.removeListener(didChangeScrollController);
    _internalScrollController?.dispose();
  }

  @protected

  /// load the choice items
  void loadChoiceItems({ensureSelectedVisibility = false}) async {
    try {
      setState(() => choiceItems = widget.choiceItems);

      // load async choice items
      if (hasChoiceLoader) {
        choiceItemsMemoizer = choiceItemsMemoizer ?? C2ChoiceMemoizer();
        await loadAsyncChoiceItems();
      }
    } finally {
      if (ensureSelectedVisibility == true) scrollToSelected();
    }
  }

  @protected
  Future<void> loadAsyncChoiceItems() async {
    if (hasChoiceLoaderRun) return;
    try {
      setState(() {
        error = '';
        loading = true;
      });
      final List<C2Choice<T>> items = await choiceItemsMemoizer!.runOnce(
        () => widget.choiceLoader!(),
      );
      setState(() => choiceItems = items);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  /// Scroll to the selected choice item
  void scrollToSelected() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = selectedContext?.findRenderObject();
      if (isScrollable && renderObject != null) {
        scrollController?.position.ensureVisible(renderObject);
      }
    });
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
            : error.isNotEmpty
                ? widget.errorBuilder?.call(context) ??
                    C2Placeholder(
                      padding: padding,
                      style: widget.errorStyle,
                      align: widget.errorAlign,
                      message: error,
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
      primary: false,
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
    final choiceWidgets = List<Widget?>.generate(
      choiceItems.length,
      (i) => choiceChip(i),
      growable: false,
    );
    return <Widget?>[
      widget.leading,
      ...choiceWidgets,
      widget.trailing,
    ].whereType<Widget>().toList();
  }

  Widget choiceLabelBuilder(C2Choice<T> item, int i) {
    return widget.choiceLabelBuilder?.call(item, i) ?? Text(item.label);
  }

  /// Widget generator for choice items
  Widget? choiceChip(int i) {
    final data = choiceItems[i];
    final selected = isMultiChoice
        ? widget.multiValue.contains(data.value)
        : widget.singleValue == data.value;
    final item = data.copyWith(
      style: defaultChoiceStyle.merge(widget.choiceStyle).merge(data.style),
      selected: selected,
      select: (selected) => select(data.value, selected: selected),
    );
    final isSelectedTarget = isScrollable
        ? isMultiChoice
            ? selected && (widget.multiValue[0] == item.value)
            : selected
        : false;
    return item.hidden == true
        ? null
        : Builder(
            key: ValueKey('${item.value}'),
            builder: (context) {
              if (isSelectedTarget) {
                selectedContext = context;
              }
              return widget.choiceBuilder?.call(item, i) ??
                  C2Chip(
                    label: choiceLabelBuilder.call(item, i),
                    avatarImage: item.avatarImage,
                    avatarText: item.avatarText,
                    leading: widget.choiceAvatarBuilder?.call(item, i),
                    checkmark: widget.choiceCheckmark,
                    style: item.style,
                    disabled: item.disabled,
                    selected: item.selected,
                    onSelected: item.select,
                    onDeleted: widget.choiceOnDeleted,
                    tooltip: item.tooltip,
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
// T? _ambiguate<T>(T? value) => value;
