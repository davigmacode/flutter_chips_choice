import 'package:flutter/widgets.dart';

/// Choice item style configuration
class C2WrapConfig {

  /// Determines how wrap will align the objects
  final WrapAlignment alignment;

  /// How the runs themselves should be placed in the cross axis.
  final WrapAlignment runAlignment;

  /// How the children within a run should be aligned relative to each other in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// how much space to place between children in a run in the main axis.
  final double spacing;

  /// how much space to place between the runs themselves in the cross axis.
  final double runSpacing;

  /// The direction to use as the main axis.
  final Axis direction;

  /// Determines the order to lay children out vertically and how to interpret start and end in the vertical direction.
  final VerticalDirection verticalDirection;

  /// Determines the order to lay children out horizontally and how to interpret start and end in the horizontal direction.
  final TextDirection textDirection;

  /// Wrap clip behavior
  final Clip clipBehavior;

  /// Default Constructor
  const C2WrapConfig({
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.spacing = 10.0,
    this.runSpacing = 0,
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
  });

  /// Creates a copy of this [C2WrapConfig] but with
  /// the given fields replaced with the new values.
  C2WrapConfig copyWith({
    WrapAlignment alignment,
    WrapAlignment runAlignment,
    WrapCrossAlignment crossAxisAlignment,
    double spacing,
    double runSpacing,
    Axis direction,
    VerticalDirection verticalDirection,
    TextDirection textDirection,
    Clip clipBehavior,
  }) {
    return C2WrapConfig(
      alignment: alignment ?? this.alignment,
      runAlignment: runAlignment ?? this.runAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      spacing: spacing ?? this.spacing,
      runSpacing: runSpacing ?? this.runSpacing,
      direction: direction ?? this.direction,
      verticalDirection: verticalDirection ?? this.verticalDirection,
      textDirection: textDirection ?? this.textDirection,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }

  /// Creates a copy of this [C2WrapConfig] but with
  /// the given fields replaced with the new values.
  C2WrapConfig merge(C2WrapConfig other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      alignment: other.alignment,
      runAlignment: other.runAlignment,
      crossAxisAlignment: other.crossAxisAlignment,
      spacing: other.spacing,
      runSpacing: other.runSpacing,
      direction: other.direction,
      verticalDirection: other.verticalDirection,
      textDirection: other.textDirection,
      clipBehavior: other.clipBehavior,
    );
  }
}