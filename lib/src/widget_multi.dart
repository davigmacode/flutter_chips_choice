part of 'widget.dart';

/// State for Single Choice
class C2MultiState<T> extends C2State<T> {
  @override
  List<T> get value => widget.multiValue;

  @override
  C2Changed<List<T>>? get onChanged => widget.multiOnChanged;

  @override
  void select(T val, {bool selected = true}) {
    final List<T> values = List.from(value);
    if (selected) {
      values.add(val);
    } else {
      values.remove(val);
    }
    onChanged?.call(values);
  }

  @override
  void didUpdateWidget(ChipsChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // scroll to selected
    if (!listEquals(oldWidget.multiValue, widget.multiValue) &&
        widget.scrollToSelectedOnChanged) {
      scrollToSelected();
    }
  }
}
