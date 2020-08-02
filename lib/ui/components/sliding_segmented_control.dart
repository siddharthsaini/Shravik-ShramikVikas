import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

const EdgeInsetsGeometry _kHorizontalItemPadding =
    EdgeInsets.symmetric(vertical: 2, horizontal: 3);

const Radius _kThumbRadius = Radius.circular(26.93); 

const EdgeInsets _kThumbInsets = EdgeInsets.symmetric(horizontal: 1);

const double _kMinSegmentedControlHeight = 28.0;

const Color _kSeparatorColor = Color.fromRGBO(0, 0, 0, 0); 

const CupertinoDynamicColor _kThumbColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFFFFFF),
  darkColor: Color(0xFF636366),
);

// The amount of space by which to inset each separator.
const EdgeInsets _kSeparatorInset = EdgeInsets.symmetric(vertical: 6);
const double _kSeparatorWidth = 1;
const Radius _kSeparatorRadius = Radius.circular(_kSeparatorWidth / 2);
const double _kMinThumbScale = 0.95;
const double _kSegmentMinPadding = 9.25;
const double _kTouchYDistanceThreshold = 50.0 * 50.0;
const double _kCornerRadius = 28; 

final SpringSimulation _kThumbSpringAnimationSimulation = SpringSimulation(
  const SpringDescription(mass: 1, stiffness: 503.551, damping: 44.8799),
  0,
  1,
  0,
);

const Duration _kSpringAnimationDuration = Duration(milliseconds: 412);

const Duration _kOpacityAnimationDuration = Duration(milliseconds: 470);

const Duration _kHighlightAnimationDuration = Duration(milliseconds: 200);

class _FontWeightTween extends Tween<FontWeight> {
  _FontWeightTween({FontWeight begin, FontWeight end})
      : super(begin: begin, end: end);

  @override
  FontWeight lerp(double t) => FontWeight.lerp(begin, end, t);
}

class CupertinoSlidingSegmentedControl<T> extends StatefulWidget {
  CupertinoSlidingSegmentedControl({
    Key key,
    @required this.children,
    @required this.onValueChanged,
    this.groupValue,
    this.thumbColor = _kThumbColor,
    this.padding = _kHorizontalItemPadding,
    this.backgroundColor = CupertinoColors.tertiarySystemFill,
  })  : assert(children != null),
        assert(children.length >= 2),
        assert(padding != null),
        assert(onValueChanged != null),
        assert(
          groupValue == null || children.keys.contains(groupValue),
          'The groupValue must be either null or one of the keys in the children map.',
        ),
        super(key: key);

  final Map<T, Widget> children;
  final T groupValue;
  final ValueChanged<T> onValueChanged;

  final Color backgroundColor;

  final Color thumbColor;
  final EdgeInsetsGeometry padding;

  @override
  _SegmentedControlState<T> createState() => _SegmentedControlState<T>();
}

class _SegmentedControlState<T>
    extends State<CupertinoSlidingSegmentedControl<T>>
    with TickerProviderStateMixin<CupertinoSlidingSegmentedControl<T>> {
  final Map<T, AnimationController> _highlightControllers =
      <T, AnimationController>{};
  final Tween<FontWeight> _highlightTween =
      _FontWeightTween(begin: FontWeight.normal, end: FontWeight.w500);

  final Map<T, AnimationController> _pressControllers =
      <T, AnimationController>{};
  final Tween<double> _pressTween = Tween<double>(begin: 1, end: 0.2);

  List<T> keys;

  AnimationController thumbController;
  AnimationController separatorOpacityController;
  AnimationController thumbScaleController;

  final TapGestureRecognizer tap = TapGestureRecognizer();
  final HorizontalDragGestureRecognizer drag =
      HorizontalDragGestureRecognizer();
  final LongPressGestureRecognizer longPress = LongPressGestureRecognizer();

  AnimationController _createHighlightAnimationController(
      {bool isCompleted = false}) {
    return AnimationController(
      duration: _kHighlightAnimationDuration,
      value: isCompleted ? 1 : 0,
      vsync: this,
    );
  }

  AnimationController _createFadeoutAnimationController() {
    return AnimationController(
      duration: _kOpacityAnimationDuration,
      vsync: this,
    );
  }

  @override
  void initState() {
    super.initState();

    final GestureArenaTeam team = GestureArenaTeam();
    // If the long press or horizontal drag recognizer gets accepted, we know for
    // sure the gesture is meant for the segmented control. Hand everything to
    // the drag gesture recognizer.
    longPress.team = team;
    drag.team = team;
    team.captain = drag;

    _highlighted = widget.groupValue;

    thumbController = AnimationController(
      duration: _kSpringAnimationDuration,
      value: 0,
      vsync: this,
    );

    thumbScaleController = AnimationController(
      duration: _kSpringAnimationDuration,
      value: 1,
      vsync: this,
    );

    separatorOpacityController = AnimationController(
      duration: _kSpringAnimationDuration,
      value: 0,
      vsync: this,
    );

    for (final T currentKey in widget.children.keys) {
      _highlightControllers[currentKey] = _createHighlightAnimationController(
        isCompleted:
            currentKey == widget.groupValue, // Highlight the current selection.
      );
      _pressControllers[currentKey] = _createFadeoutAnimationController();
    }
  }

  @override
  void didUpdateWidget(CupertinoSlidingSegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation controllers.
    for (final T oldKey in oldWidget.children.keys) {
      if (!widget.children.containsKey(oldKey)) {
        _highlightControllers[oldKey].dispose();
        _pressControllers[oldKey].dispose();

        _highlightControllers.remove(oldKey);
        _pressControllers.remove(oldKey);
      }
    }

    for (final T newKey in widget.children.keys) {
      if (!_highlightControllers.keys.contains(newKey)) {
        _highlightControllers[newKey] = _createHighlightAnimationController();
        _pressControllers[newKey] = _createFadeoutAnimationController();
      }
    }

    highlighted = widget.groupValue;
  }

  @override
  void dispose() {
    for (final AnimationController animationController
        in _highlightControllers.values) {
      animationController.dispose();
    }

    for (final AnimationController animationController
        in _pressControllers.values) {
      animationController.dispose();
    }

    thumbScaleController.dispose();
    thumbController.dispose();
    separatorOpacityController.dispose();

    drag.dispose();
    tap.dispose();
    longPress.dispose();

    super.dispose();
  }

  // Play highlight animation for the child located at _highlightControllers[at].
  void _animateHighlightController({T at, bool forward}) {
    if (at == null) return;
    final AnimationController controller = _highlightControllers[at];
    assert(!forward || controller != null);
    controller?.animateTo(forward ? 1 : 0,
        duration: _kHighlightAnimationDuration, curve: Curves.ease);
  }

  T _highlighted;
  set highlighted(T newValue) {
    if (_highlighted == newValue) return;
    _animateHighlightController(at: newValue, forward: true);
    _animateHighlightController(at: _highlighted, forward: false);
    _highlighted = newValue;
  }

  T _pressed;
  set pressed(T newValue) {
    if (_pressed == newValue) return;

    if (_pressed != null) {
      _pressControllers[_pressed]?.animateTo(0,
          duration: _kOpacityAnimationDuration, curve: Curves.ease);
    }
    if (newValue != _highlighted && newValue != null) {
      _pressControllers[newValue].animateTo(1,
          duration: _kOpacityAnimationDuration, curve: Curves.ease);
    }
    _pressed = newValue;
  }

  void didChangeSelectedViaGesture() {
    widget.onValueChanged(_highlighted);
  }

  T indexToKey(int index) => index == null ? null : keys[index];

  @override
  Widget build(BuildContext context) {
    debugCheckHasDirectionality(context);

    switch (Directionality.of(context)) {
      case TextDirection.ltr:
        keys = widget.children.keys.toList(growable: false);
        break;
      case TextDirection.rtl:
        keys = widget.children.keys.toList().reversed.toList(growable: false);
        break;
    }

    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        ..._highlightControllers.values,
        ..._pressControllers.values,
      ]),
      builder: (BuildContext context, Widget child) {
        final List<Widget> children = <Widget>[];
        for (final T currentKey in keys) {
          final TextStyle textStyle =
              DefaultTextStyle.of(context).style.copyWith(
                    fontWeight: _highlightTween
                        .evaluate(_highlightControllers[currentKey]),
                  );

          final Widget child = DefaultTextStyle(
            style: textStyle,
            child: Semantics(
              button: true,
              onTap: () {
                widget.onValueChanged(currentKey);
              },
              inMutuallyExclusiveGroup: true,
              selected: widget.groupValue == currentKey,
              child: Opacity(
                opacity: _pressTween.evaluate(_pressControllers[currentKey]),
                // Expand the hitTest area to be as large as the Opacity widget.
                child: MetaData(
                  behavior: HitTestBehavior.opaque,
                  child: Center(child: widget.children[currentKey]),
                ),
              ),
            ),
          );

          children.add(child);
        }

        final int selectedIndex =
            widget.groupValue == null ? null : keys.indexOf(widget.groupValue);

        final Widget box = _SegmentedControlRenderWidget<T>(
          children: children,
          selectedIndex: selectedIndex,
          thumbColor: CupertinoDynamicColor.resolve(widget.thumbColor, context),
          state: this,
        );

        return UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: Container(
            padding: widget.padding.resolve(Directionality.of(context)),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(_kCornerRadius)),
              color: CupertinoDynamicColor.resolve(
                  widget.backgroundColor, context),
            ),
            child: box,
          ),
        );
      },
    );
  }
}

class _SegmentedControlRenderWidget<T> extends MultiChildRenderObjectWidget {
  _SegmentedControlRenderWidget({
    Key key,
    List<Widget> children = const <Widget>[],
    @required this.selectedIndex,
    @required this.thumbColor,
    @required this.state,
  }) : super(key: key, children: children);

  final int selectedIndex;
  final Color thumbColor;
  final _SegmentedControlState<T> state;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSegmentedControl<T>(
      selectedIndex: selectedIndex,
      thumbColor: CupertinoDynamicColor.resolve(thumbColor, context),
      state: state,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSegmentedControl<T> renderObject) {
    renderObject
      ..thumbColor = CupertinoDynamicColor.resolve(thumbColor, context)
      ..guardedSetHighlightedIndex(selectedIndex);
  }
}

class _ChildAnimationManifest {
  _ChildAnimationManifest({
    this.opacity = 1,
    @required this.separatorOpacity,
  })  : assert(separatorOpacity != null),
        assert(opacity != null),
        separatorTween =
            Tween<double>(begin: separatorOpacity, end: separatorOpacity),
        opacityTween = Tween<double>(begin: opacity, end: opacity);

  double opacity;
  Tween<double> opacityTween;
  double separatorOpacity;
  Tween<double> separatorTween;
}

class _SegmentedControlContainerBoxParentData
    extends ContainerBoxParentData<RenderBox> {}

class _RenderSegmentedControl<T> extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox,
            ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            ContainerBoxParentData<RenderBox>> {
  _RenderSegmentedControl({
    @required int selectedIndex,
    @required Color thumbColor,
    @required this.state,
  })  : _highlightedIndex = selectedIndex,
        _thumbColor = thumbColor,
        assert(state != null) {
    state.drag
      ..onDown = _onDown
      ..onUpdate = _onUpdate
      ..onEnd = _onEnd
      ..onCancel = _onCancel;

    state.tap.onTapUp = _onTapUp;
    state.longPress.onLongPress = () {};
  }

  final _SegmentedControlState<T> state;

  Map<RenderBox, _ChildAnimationManifest> _childAnimations =
      <RenderBox, _ChildAnimationManifest>{};

  // The current **Unscaled** Thumb Rect.
  Rect currentThumbRect;

  Tween<Rect> _currentThumbTween;

  Tween<double> _thumbScaleTween =
      Tween<double>(begin: _kMinThumbScale, end: 1);
  double currentThumbScale = 1;

  // The current position of the active drag pointer.
  Offset _localDragOffset;
  // Whether the current drag gesture started on a selected segment.
  bool _startedOnSelectedSegment;

  @override
  void insert(RenderBox child, {RenderBox after}) {
    super.insert(child, after: after);
    if (_childAnimations == null) return;

    assert(_childAnimations[child] == null);
    _childAnimations[child] = _ChildAnimationManifest(separatorOpacity: 1);
  }

  @override
  void remove(RenderBox child) {
    super.remove(child);
    _childAnimations?.remove(child);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    state.thumbController.addListener(markNeedsPaint);
    state.thumbScaleController.addListener(markNeedsPaint);
    state.separatorOpacityController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    state.thumbController.removeListener(markNeedsPaint);
    state.thumbScaleController.removeListener(markNeedsPaint);
    state.separatorOpacityController.removeListener(markNeedsPaint);
    super.detach();
  }

  // Indicates whether selectedIndex has changed and animations need to be updated.
  // when true some animation tweens will be updated in paint phase.
  bool _needsThumbAnimationUpdate = false;

  int get highlightedIndex => _highlightedIndex;
  int _highlightedIndex;
  set highlightedIndex(int value) {
    if (_highlightedIndex == value) {
      return;
    }

    _needsThumbAnimationUpdate = true;
    _highlightedIndex = value;

    state.thumbController.animateWith(_kThumbSpringAnimationSimulation);

    state.separatorOpacityController.reset();
    state.separatorOpacityController.animateTo(
      1,
      duration: _kSpringAnimationDuration,
      curve: Curves.ease,
    );

    state.highlighted = state.indexToKey(value);
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  void guardedSetHighlightedIndex(int value) {
    // Ignore set highlightedIndex when the user is dragging the thumb around.
    if (_startedOnSelectedSegment == true) return;
    highlightedIndex = value;
  }

  int get pressedIndex => _pressedIndex;
  int _pressedIndex;
  set pressedIndex(int value) {
    if (_pressedIndex == value) {
      return;
    }

    assert(value == null || (value >= 0 && value < childCount));

    _pressedIndex = value;
    state.pressed = state.indexToKey(value);
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor == value) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  double get totalSeparatorWidth =>
      (_kSeparatorInset.horizontal + _kSeparatorWidth) * (childCount - 1);

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      state.tap.addPointer(event);
      state.longPress.addPointer(event);
      state.drag.addPointer(event);
    }
  }

  int indexFromLocation(Offset location) {
    return childCount == 0
        ? null
        // This assumes all children have the same width.
        : ((location.dx / (size.width / childCount))
            .floor()
            .clamp(0, childCount - 1) as int);
  }

  void _onTapUp(TapUpDetails details) {
    highlightedIndex = indexFromLocation(details.localPosition);
    state.didChangeSelectedViaGesture();
  }

  void _onDown(DragDownDetails details) {
    assert(size.contains(details.localPosition));
    _localDragOffset = details.localPosition;
    final int index = indexFromLocation(_localDragOffset);
    _startedOnSelectedSegment = index == highlightedIndex;
    pressedIndex = index;

    if (_startedOnSelectedSegment) {
      _playThumbScaleAnimation(isExpanding: false);
    }
  }

  void _onUpdate(DragUpdateDetails details) {
    _localDragOffset = details.localPosition;
    final int newIndex = indexFromLocation(_localDragOffset);

    if (_startedOnSelectedSegment) {
      highlightedIndex = newIndex;
      pressedIndex = newIndex;
    } else {
      pressedIndex = _hasDraggedTooFar(details) ? null : newIndex;
    }
  }

  void _onEnd(DragEndDetails details) {
    if (_startedOnSelectedSegment) {
      _playThumbScaleAnimation(isExpanding: true);
      state.didChangeSelectedViaGesture();
    }

    if (pressedIndex != null) {
      highlightedIndex = pressedIndex;
      state.didChangeSelectedViaGesture();
    }
    pressedIndex = null;
    _localDragOffset = null;
    _startedOnSelectedSegment = null;
  }

  void _onCancel() {
    if (_startedOnSelectedSegment) {
      _playThumbScaleAnimation(isExpanding: true);
    }

    _localDragOffset = null;
    pressedIndex = null;
    _startedOnSelectedSegment = null;
  }

  void _playThumbScaleAnimation({@required bool isExpanding}) {
    assert(isExpanding != null);
    _thumbScaleTween = Tween<double>(
        begin: currentThumbScale, end: isExpanding ? 1 : _kMinThumbScale);
    state.thumbScaleController.animateWith(_kThumbSpringAnimationSimulation);
  }

  bool _hasDraggedTooFar(DragUpdateDetails details) {
    final Offset offCenter =
        details.localPosition - Offset(size.width / 2, size.height / 2);
    return math.pow(math.max(0, offCenter.dx.abs() - size.width / 2), 2) +
            math.pow(math.max(0, offCenter.dy.abs() - size.height / 2), 2) >
        _kTouchYDistanceThreshold;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    RenderBox child = firstChild;
    double maxMinChildWidth = 0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData as _SegmentedControlContainerBoxParentData;
      final double childWidth = child.getMinIntrinsicWidth(height);
      maxMinChildWidth = math.max(maxMinChildWidth, childWidth);
      child = childParentData.nextSibling;
    }
    return (maxMinChildWidth + 2 * _kSegmentMinPadding) * childCount +
        totalSeparatorWidth;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    RenderBox child = firstChild;
    double maxMaxChildWidth = 0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData as _SegmentedControlContainerBoxParentData;
      final double childWidth = child.getMaxIntrinsicWidth(height);
      maxMaxChildWidth = math.max(maxMaxChildWidth, childWidth);
      child = childParentData.nextSibling;
    }
    return (maxMaxChildWidth + 2 * _kSegmentMinPadding) * childCount +
        totalSeparatorWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    RenderBox child = firstChild;
    double maxMinChildHeight = 0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData as _SegmentedControlContainerBoxParentData;
      final double childHeight = child.getMinIntrinsicHeight(width);
      maxMinChildHeight = math.max(maxMinChildHeight, childHeight);
      child = childParentData.nextSibling;
    }
    return maxMinChildHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    RenderBox child = firstChild;
    double maxMaxChildHeight = 0;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData as _SegmentedControlContainerBoxParentData;
      final double childHeight = child.getMaxIntrinsicHeight(width);
      maxMaxChildHeight = math.max(maxMaxChildHeight, childHeight);
      child = childParentData.nextSibling;
    }
    return maxMaxChildHeight;
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SegmentedControlContainerBoxParentData) {
      child.parentData = _SegmentedControlContainerBoxParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    double childWidth =
        (constraints.minWidth - totalSeparatorWidth) / childCount;
    double maxHeight = _kMinSegmentedControlHeight;

    for (final RenderBox child in getChildrenAsList()) {
      childWidth = math.max(
          childWidth,
          child.getMaxIntrinsicWidth(double.infinity) +
              2 * _kSegmentMinPadding);
    }

    childWidth = math.min(
      childWidth,
      (constraints.maxWidth - totalSeparatorWidth) / childCount,
    );

    RenderBox child = firstChild;
    while (child != null) {
      final double boxHeight = child.getMaxIntrinsicHeight(childWidth);
      maxHeight = math.max(maxHeight, boxHeight);
      child = childAfter(child);
    }

    constraints.constrainHeight(maxHeight);

    final BoxConstraints childConstraints = BoxConstraints.tightFor(
      width: childWidth,
      height: maxHeight,
    );

    // Layout children.
    child = firstChild;
    while (child != null) {
      child.layout(childConstraints, parentUsesSize: true);
      child = childAfter(child);
    }

    double start = 0;
    child = firstChild;

    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData as _SegmentedControlContainerBoxParentData;
      final Offset childOffset = Offset(start, 0);
      childParentData.offset = childOffset;
      start +=
          child.size.width + _kSeparatorWidth + _kSeparatorInset.horizontal;
      child = childAfter(child);
    }

    size = constraints.constrain(
        Size(childWidth * childCount + totalSeparatorWidth, maxHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final List<RenderBox> children = getChildrenAsList();

    // Paint thumb if highlightedIndex is not null.
    if (highlightedIndex != null) {
      if (_childAnimations == null) {
        _childAnimations = <RenderBox, _ChildAnimationManifest>{};
        for (int i = 0; i < childCount - 1; i += 1) {
          // The separator associated with the last child will not be painted (unless
          // a new trailing segment is added), and its opacity will always be 1.
          final bool shouldFadeOut =
              i == highlightedIndex || i == highlightedIndex - 1;
          final RenderBox child = children[i];
          _childAnimations[child] =
              _ChildAnimationManifest(separatorOpacity: shouldFadeOut ? 0 : 1);
        }
      }

      final RenderBox selectedChild = children[highlightedIndex];

      final _SegmentedControlContainerBoxParentData childParentData =
          selectedChild.parentData as _SegmentedControlContainerBoxParentData;
      final Rect unscaledThumbTargetRect = _kThumbInsets
          .inflateRect(childParentData.offset & selectedChild.size);

      // Update related Tweens before animation update phase.
      if (_needsThumbAnimationUpdate) {
        // Needs to ensure _currentThumbRect is valid.
        _currentThumbTween = RectTween(
            begin: currentThumbRect ?? unscaledThumbTargetRect,
            end: unscaledThumbTargetRect);

        for (int i = 0; i < childCount - 1; i += 1) {
          // The separator associated with the last child will not be painted (unless
          // a new segment is appended to the child list), and its opacity will always be 1.
          final bool shouldFadeOut =
              i == highlightedIndex || i == highlightedIndex - 1;
          final RenderBox child = children[i];
          final _ChildAnimationManifest manifest = _childAnimations[child];
          assert(manifest != null);
          manifest.separatorTween = Tween<double>(
            begin: manifest.separatorOpacity,
            end: shouldFadeOut ? 0 : 1,
          );
        }

        _needsThumbAnimationUpdate = false;
      } else if (_currentThumbTween != null &&
          unscaledThumbTargetRect != _currentThumbTween.begin) {
        _currentThumbTween = RectTween(
            begin: _currentThumbTween.begin, end: unscaledThumbTargetRect);
      }

      for (int index = 0; index < childCount - 1; index += 1) {
        _paintSeparator(context, offset, children[index]);
      }

      currentThumbRect = _currentThumbTween?.evaluate(state.thumbController) ??
          unscaledThumbTargetRect;

      currentThumbScale = _thumbScaleTween.evaluate(state.thumbScaleController);

      final Rect thumbRect = Rect.fromCenter(
        center: currentThumbRect.center,
        width: currentThumbRect.width * currentThumbScale,
        height: currentThumbRect.height * currentThumbScale,
      );

      _paintThumb(context, offset, thumbRect);
    } else {
      // Reset all animations when there's no thumb.
      currentThumbRect = null;
      _childAnimations = null;

      for (int index = 0; index < childCount - 1; index += 1) {
        _paintSeparator(context, offset, children[index]);
      }
    }

    for (int index = 0; index < children.length; index++) {
      _paintChild(context, offset, children[index], index);
    }
  }

  // Paint the separator to the right of the given child.
  void _paintSeparator(
      PaintingContext context, Offset offset, RenderBox child) {
    assert(child != null);
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData as _SegmentedControlContainerBoxParentData;

    final Paint paint = Paint();

    final _ChildAnimationManifest manifest =
        _childAnimations == null ? null : _childAnimations[child];
    final double opacity =
        manifest?.separatorTween?.evaluate(state.separatorOpacityController) ??
            1;
    manifest?.separatorOpacity = opacity;
    paint.color =
        _kSeparatorColor.withOpacity(_kSeparatorColor.opacity * opacity);

    final Rect childRect = (childParentData.offset + offset) & child.size;
    final Rect separatorRect = _kSeparatorInset.deflateRect(
      childRect.topRight &
          Size(_kSeparatorInset.horizontal + _kSeparatorWidth,
              child.size.height),
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(separatorRect, _kSeparatorRadius),
      paint,
    );
  }

  void _paintChild(
      PaintingContext context, Offset offset, RenderBox child, int childIndex) {
    assert(child != null);
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData as _SegmentedControlContainerBoxParentData;
    context.paintChild(child, childParentData.offset + offset);
  }

  void _paintThumb(PaintingContext context, Offset offset, Rect thumbRect) {
    // Colors extracted from https://developer.apple.com/design/resources/.
    const List<BoxShadow> thumbShadow = <BoxShadow>[
      BoxShadow(
        color: Color(0x1F000000),
        offset: Offset(0, 3),
        blurRadius: 8,
      ),
      BoxShadow(
        color: Color(0x0A000000),
        offset: Offset(0, 3),
        blurRadius: 1,
      ),
    ];

    final RRect thumbRRect =
        RRect.fromRectAndRadius(thumbRect.shift(offset), _kThumbRadius);

    for (final BoxShadow shadow in thumbShadow) {
      context.canvas
          .drawRRect(thumbRRect.shift(shadow.offset), shadow.toPaint());
    }

    context.canvas.drawRRect(
      thumbRRect.inflate(0.5),
      Paint()..color = const Color(0x0A000000),
    );

    context.canvas.drawRRect(
      thumbRRect,
      Paint()..color = thumbColor,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {@required Offset position}) {
    assert(position != null);
    RenderBox child = lastChild;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData as _SegmentedControlContainerBoxParentData;
      if ((childParentData.offset & child.size).contains(position)) {
        final Offset center = (Offset.zero & child.size).center;
        return result.addWithRawTransform(
          transform: MatrixUtils.forceToPoint(center),
          position: center,
          hitTest: (BoxHitTestResult result, Offset position) {
            assert(position == center);
            return child.hitTest(result, position: center);
          },
        );
      }
      child = childParentData.previousSibling;
    }
    return false;
  }
}
