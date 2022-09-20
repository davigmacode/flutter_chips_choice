part of 'widget.dart';

/// State for Single Choice
class C2SingleState<T> extends C2State<T> {
  @override
  T? get value => widget.singleValue;

  @override
  C2Changed<T>? get onChanged => widget.singleOnChanged;

  @override
  void select(T val, {bool selected = true}) {
    onChanged?.call(val);
  }

  @override
  void didUpdateWidget(ChipsChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // scroll to selected
    if (oldWidget.singleValue != widget.singleValue &&
        widget.scrollToSelectedOnChanged) {
      scrollToSelected();
    }
  }
}
