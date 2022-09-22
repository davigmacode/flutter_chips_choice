import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'choice_item.dart';

/// Callback when the value changed
typedef C2Changed<T> = void Function(T value);

/// Callback to load the choice items
typedef C2ChoiceLoader<T> = Future<List<C2Choice<T>>> Function();

/// Builder for custom choice item
typedef C2Builder<T> = Widget? Function(C2Choice<T> item, int i);

/// alias to AsyncMemoizer
class C2ChoiceMemoizer<T> extends AsyncMemoizer<List<C2Choice<T>>> {}
