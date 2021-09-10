import 'package:flutter/widgets.dart';
import 'choice_item.dart';

/// Callback when the value changed
typedef void C2Changed<T>(T value);

/// Callback to load the choice items
typedef Future<List<C2Choice<T>>> C2ChoiceLoader<T>();

/// Builder for custom choice item
typedef Widget? C2Builder<T>(C2Choice<T> item);
