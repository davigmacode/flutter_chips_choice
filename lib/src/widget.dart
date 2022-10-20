import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'choice.dart';
import 'types.dart';
import 'chip.dart';

part 'state.dart';
part 'state_single.dart';
part 'state_multi.dart';
part 'utils.dart';

/// Easy way to provide a single or multiple choice chips
class ChipsChoice<T> extends StatefulWidget {
  /// List of choice item
  final List<C2Choice<T>> choiceItems;

  /// Function to load the choice items
  final C2ChoiceLoader<T>? choiceLoader;

  /// Configuration for styling unselected choice widget
  final C2ChipStyle? choiceStyle;

  /// Configuration for styling unselected choice widget
  final bool choiceCheckmark;

  /// Builder for custom label of the choice item
  final C2Builder<T>? choiceLabelBuilder;

  /// Builder for custom avatar of the choice item
  final C2Builder<T>? choiceAvatarBuilder;

  /// Builder for custom choice item widget
  final C2Builder<T>? choiceBuilder;

  /// Called when the user taps the [deleteIcon] to delete the chip.
  ///
  /// If null, the delete button will not appear on the chip.
  ///
  /// The chip will not automatically remove itself: this just tells the app
  /// that the user tapped the delete button.
  final VoidCallback? choiceOnDeleted;

  /// Builder for custom spinner widget
  final WidgetBuilder? spinnerBuilder;

  /// Builder for custom placeholder widget
  final WidgetBuilder? placeholderBuilder;

  /// Builder for custom error widget
  final WidgetBuilder? errorBuilder;

  /// Whether the chips is wrapped or scrollable
  final bool wrapped;

  /// Padding of the list container
  final EdgeInsetsGeometry? padding;

  /// The direction to use as the main axis
  final Axis direction;

  /// Determines the order to lay children out vertically and how to interpret start and end in the vertical direction
  final VerticalDirection verticalDirection;

  /// Determines the order to lay children out horizontally and how to interpret start and end in the horizontal direction
  final TextDirection? textDirection;

  /// If [wrapped] is [false], How the scroll view should respond to user input
  final ScrollPhysics? scrollPhysics;

  /// If [wrapped] is [false], How much space should be occupied in the main axis
  final MainAxisSize mainAxisSize;

  /// If [wrapped] is [false], How the children should be placed along the main axis
  final MainAxisAlignment mainAxisAlignment;

  /// If [wrapped] is [false], How the children should be placed along the cross axis
  final CrossAxisAlignment crossAxisAlignment;

  /// If [wrapped] is [true], how the children within a run should be aligned relative to each other in the cross axis
  final WrapCrossAlignment wrapCrossAlignment;

  /// If [wrapped] is [true], determines how wrap will align the objects
  final WrapAlignment alignment;

  /// If [wrapped] is [true], how the runs themselves should be placed in the cross axis
  final WrapAlignment runAlignment;

  /// If [wrapped] is [true], how much space to place between children in a run in the main axis
  final double spacing;

  /// If [wrapped] is [true], how much space to place between the runs themselves in the cross axis
  final double runSpacing;

  /// Clip behavior of the list container
  final Clip clipBehavior;

  /// String to display when there is no choice items
  final String? placeholder;

  /// Text style for default placeholder widget
  final TextStyle? placeholderStyle;

  /// Text align for default placeholder widget
  final TextAlign? placeholderAlign;

  /// Text style for default error widget
  final TextStyle? errorStyle;

  /// Text align for default error widget
  final TextAlign? errorAlign;

  /// Size of the default spinner widget
  final double? spinnerSize;

  /// Color of the default spinner widget
  final Color? spinnerColor;

  /// Thickness of the default spinner widget
  final double? spinnerThickness;

  /// Custom widget that inserted before the first choice item
  final Widget? leading;

  /// Custom widget that inserted after the last choice item
  final Widget? trailing;

  /// Whether show the choice items
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// Initial value for single choice widget
  final T? singleValue;

  /// Called when value changed in single choice widget
  final C2Changed<T>? singleOnChanged;

  /// Initial value for multiple choice widget
  final List<T> multiValue;

  /// Called when value changed in multiple choice widget
  final C2Changed<List<T>>? multiOnChanged;

  /// Used when the choice items is scrollable or [wrapped] is not [true]
  final ScrollController? scrollController;

  /// scroll to selected value on external value changed
  final bool scrollToSelectedOnChanged;

  /// Constructor for single choice
  ///
  /// The [value] is current selected value
  ///
  /// The [onChanged] called when value changed
  ///
  /// The [choiceItems] is [List] of [C2Choice] item to generate the choices
  ///
  /// The [choiceLoader] is function to load the choice items
  ///
  /// The [choiceStyle] is a configuration for styling unselected choice widget
  ///
  /// The [choiceActiveStyle] is a configuration for styling selected choice widget
  ///
  /// The [choiceLabelBuilder] is builder for custom label of the choice item
  ///
  /// The [choiceAvatarBuilder] is builder for custom avatar of the choice item
  ///
  /// The [choiceBuilder] is builder for custom choice item widget
  ///
  /// The [spinnerBuilder] is builder for custom spinner widget
  ///
  /// The [placeholderBuilder] is builder for custom placeholder widget
  ///
  /// The [errorBuilder] is builder for custom error widget
  ///
  /// The [wrapped] is whether the chips is wrapped or scrollable
  ///
  /// The [padding] is padding of the list container
  ///
  /// The [direction] is the direction to use as the main axis
  ///
  /// The [verticalDirection] is determines the order to lay children out vertically and how to interpret start and end in the vertical direction
  ///
  /// The [textDirection] is determines the order to lay children out horizontally and how to interpret start and end in the horizontal direction
  ///
  /// The [clipBehavior] is clip behavior of the list container
  ///
  /// The [scrollPhysics] is how the scroll view should respond to user input, if [Wrapped] is [false]
  ///
  /// The [mainAxisSize] is how much space should be occupied in the main axis, if [wrapped] is [false]
  ///
  /// The [mainAxisAlignment] is how the children should be placed along the main axis, if [wrapped] is [false]
  ///
  /// The [crossAxisAlignment] is how the children should be placed along the cross axis, if [wrapped] is [false]
  ///
  /// The [alignment] is determines how wrap will align the objects, if [wrapped] is [true]
  ///
  /// The [runAlignment] is how the runs themselves should be placed in the cross axis, if [wrapped] is [true]
  ///
  /// The [wrapCrossAlignment] is how the children within a run should be aligned relative to each other in the cross axis, if [wrapped] is [true]
  ///
  /// The [spacing] is how much space to place between children in a run in the main axis, if [wrapped] is [true]
  ///
  /// The [runSpacing] is how much space to place between the runs themselves in the cross axis, if [wrapped] is [true]
  ///
  /// The [placeholder] is string to display when there is no choice items
  ///
  /// The [placeholderStyle] is text style for default placeholder widget
  ///
  /// The [placeholderAlign] is text align for default placeholder widget
  ///
  /// The [errorStyle] is text style for default error widget
  ///
  /// The [errorAlign] is text align for default error widget
  ///
  /// The [spinnerSize] is size of the default spinner widget
  ///
  /// The [spinnerColor] is color of the default spinner widget
  ///
  /// The [spinnerThickness] is thickness of the default spinner widget
  ///
  /// The [leading] is custom widget that inserted before the first choice item
  ///
  /// The [trailing] is custom widget that inserted after the last choice item
  ///
  /// The [scrollController] used when the choice items is scrollable or [wrapped] is not [true]
  ChipsChoice.single({
    Key? key,
    required T? value,
    required C2Changed<T> onChanged,
    this.choiceItems = const [],
    this.choiceLoader,
    this.choiceStyle,
    this.choiceCheckmark = false,
    this.choiceLabelBuilder,
    this.choiceAvatarBuilder,
    this.choiceBuilder,
    this.choiceOnDeleted,
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
    this.wrapCrossAlignment = WrapCrossAlignment.center,
    this.spacing = 10,
    this.runSpacing = 10,
    this.placeholder,
    this.placeholderStyle,
    this.placeholderAlign,
    this.errorStyle,
    this.errorAlign,
    this.spinnerSize,
    this.spinnerColor,
    this.spinnerThickness,
    this.leading,
    this.trailing,
    this.scrollController,
    this.scrollToSelectedOnChanged = false,
  })  : assert(
          choiceItems.isNotEmpty || choiceLoader != null,
          'One of the parameters must be provided',
        ),
        isMultiChoice = false,
        singleValue = value,
        singleOnChanged = onChanged,
        multiValue = const [],
        multiOnChanged = null,
        super(key: key);

  /// Constructor for multiple choice
  ///
  /// The [value] is current selected value
  ///
  /// The [onChanged] called when value changed
  ///
  /// The [choiceItems] is [List] of [C2Choice] item to generate the choices
  ///
  /// The [choiceLoader] is function to load the choice items
  ///
  /// The [choiceStyle] is a configuration for styling unselected choice widget
  ///
  /// The [choiceActiveStyle] is a configuration for styling selected choice widget
  ///
  /// The [choiceLabelBuilder] is builder for custom label of the choice item
  ///
  /// The [choiceAvatarBuilder] is builder for custom avatar of the choice item
  ///
  /// The [choiceBuilder] is builder for custom choice item widget
  ///
  /// The [spinnerBuilder] is builder for custom spinner widget
  ///
  /// The [placeholderBuilder] is builder for custom placeholder widget
  ///
  /// The [errorBuilder] is builder for custom error widget
  ///
  /// The [wrapped] is whether the chips is wrapped or scrollable
  ///
  /// The [padding] is padding of the list container
  ///
  /// The [direction] is the direction to use as the main axis
  ///
  /// The [verticalDirection] is determines the order to lay children out vertically and how to interpret start and end in the vertical direction
  ///
  /// The [textDirection] is determines the order to lay children out horizontally and how to interpret start and end in the horizontal direction
  ///
  /// The [clipBehavior] is clip behavior of the list container
  ///
  /// The [scrollPhysics] is how the scroll view should respond to user input, if [Wrapped] is [false]
  ///
  /// The [mainAxisSize] is how much space should be occupied in the main axis, if [wrapped] is [false]
  ///
  /// The [mainAxisAlignment] is how the children should be placed along the main axis, if [wrapped] is [false]
  ///
  /// The [crossAxisAlignment] is how the children should be placed along the cross axis, if [wrapped] is [false]
  ///
  /// The [alignment] is determines how wrap will align the objects, if [wrapped] is [true]
  ///
  /// The [runAlignment] is how the runs themselves should be placed in the cross axis, if [wrapped] is [true]
  ///
  /// The [wrapCrossAlignment] is how the children within a run should be aligned relative to each other in the cross axis, if [wrapped] is [true]
  ///
  /// The [spacing] is how much space to place between children in a run in the main axis, if [wrapped] is [true]
  ///
  /// The [runSpacing] is how much space to place between the runs themselves in the cross axis, if [wrapped] is [true]
  ///
  /// The [placeholder] is string to display when there is no choice items
  ///
  /// The [placeholderStyle] is text style for default placeholder widget
  ///
  /// The [placeholderAlign] is text align for default placeholder widget
  ///
  /// The [errorStyle] is text style for default error widget
  ///
  /// The [errorAlign] is text align for default error widget
  ///
  /// The [spinnerSize] is size of the default spinner widget
  ///
  /// The [spinnerColor] is color of the default spinner widget
  ///
  /// The [spinnerThickness] is thickness of the default spinner widget
  ///
  /// The [leading] is custom widget that inserted before the first choice item
  ///
  /// The [trailing] is custom widget that inserted after the last choice item
  ///
  /// The [scrollController] used when the choice items is scrollable or [wrapped] is not [true]
  ChipsChoice.multiple({
    Key? key,
    required List<T> value,
    required C2Changed<List<T>> onChanged,
    this.choiceItems = const [],
    this.choiceLoader,
    this.choiceStyle,
    this.choiceCheckmark = false,
    this.choiceLabelBuilder,
    this.choiceAvatarBuilder,
    this.choiceBuilder,
    this.choiceOnDeleted,
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
    this.wrapCrossAlignment = WrapCrossAlignment.center,
    this.spacing = 10,
    this.runSpacing = 10,
    this.placeholder,
    this.placeholderStyle,
    this.placeholderAlign,
    this.errorStyle,
    this.errorAlign,
    this.spinnerSize,
    this.spinnerColor,
    this.spinnerThickness,
    this.leading,
    this.trailing,
    this.scrollController,
    this.scrollToSelectedOnChanged = false,
  })  : assert(
          choiceItems.isNotEmpty || choiceLoader != null,
          'One of the parameters must be provided',
        ),
        isMultiChoice = true,
        multiValue = value,
        multiOnChanged = onChanged,
        singleValue = null,
        singleOnChanged = null,
        super(key: key);

  /// Default padding for scrollable list
  static final EdgeInsetsGeometry defaultScrollablePadding =
      const EdgeInsets.fromLTRB(10, 10, 10, 10);

  /// Default padding for wrapped list
  static final EdgeInsetsGeometry defaultWrappedPadding =
      const EdgeInsets.fromLTRB(15, 15, 15, 15);

  /// Default padding for spinner and placeholder
  static final EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(20);

  /// Default chip margin in wrapped list
  static final EdgeInsetsGeometry defaultWrappedChipMargin =
      const EdgeInsets.all(0);

  /// Default chip margin in scrollable list
  static final EdgeInsetsGeometry defaultScrollableChipMargin =
      const EdgeInsets.all(5);

  /// Default placeholder string
  static final String defaultPlaceholder = 'Empty choice items';

  @override
  C2State<T> createState() {
    return isMultiChoice ? C2MultiState<T>() : C2SingleState<T>();
  }
}
