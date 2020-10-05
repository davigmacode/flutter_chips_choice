import 'package:flutter/widgets.dart';

/// Choice item style configuration
class C2WrapConfig {

  /// Determines how wrap will align the objects
  final WrapAlignment alignment;

  /// how much space to place between children in a run in the main axis.
  final double spacing;

  /// how much space to place between the runs themselves in the cross axis.
  final double runSpacing;

  /// Default Constructor
  const C2WrapConfig({
    this.alignment = WrapAlignment.start,
    this.spacing = 10.0,
    this.runSpacing = 0,
  });
}