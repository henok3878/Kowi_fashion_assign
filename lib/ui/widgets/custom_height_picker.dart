import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
typedef TextMapper = String Function(String numberText);

class CustomHeightPicker extends StatefulWidget {
  final int interval;
  final double scaleSize;
  /// total numbers on scale
  final int limit;

  /// starting number of scale to show marker
  final int lowerLimit;

  /// ending number of scale  to show marker
  final int upperLimit;

  /// mid starting number of scale (Optional)
  final int midLimitLower;

  /// mid ending number of scale (Optional)
  final int midLimitUpper;

  // Number picker


  /// Min value user can pick
  final int minValue;

  /// Max value user can pick
  final int maxValue;

  /// Currently selected value
  final int value;

  /// Called when selected value changes
  final ValueChanged<int> onChanged;

  /// Specifies how many items should be shown - defaults to 3
  int itemCount;

  /// Step between elements. Only for integer datePicker
  /// Examples:
  /// if step is 100 the following elements may be 100, 200, 300...
  /// if min=0, max=6, step=3, then items will be 0, 3 and 6
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// height of single item in pixels
  final double itemHeight;

  /// width of single item in pixels
  final double itemWidth;

  /// Direction of scrolling
  final Axis axis;

  /// Style of non-selected numbers. If null, it uses Theme's bodyText2
  final TextStyle textStyle;

  /// Style of non-selected numbers. If null, it uses Theme's headline5 with accentColor
  final TextStyle selectedTextStyle;

  /// Whether to trigger haptic pulses or not
  final bool haptics;

  /// Build the text of each item on the picker
  final TextMapper? textMapper;

  /// Pads displayed integer values up to the length of maxValue
  final bool zeroPad;

  /// Decoration to apply to central box where the selected value is placed
  final Decoration? decoration;

  double spacing;
  CustomHeightPicker({
    this.spacing = 8, required this.scaleSize,
    Key? key,
    required this.minValue,
    required this.maxValue,

    required this.value,
    required this.onChanged,
    this.itemCount = 3,
    this.step = 1,
    this.itemHeight = 50,
    this.itemWidth = 100,
    this.axis = Axis.vertical,
    required this.textStyle,
    required this.selectedTextStyle,
    this.haptics = false,
    this.decoration,
    this.zeroPad = false,
    this.textMapper,
    this.interval = 4,
    this.lowerLimit = 0,
    this.midLimitLower = 0,
    this.midLimitUpper = 0,
    this.upperLimit = 0,
    required this.limit
  })  : assert(minValue <= value),
        assert(value <= maxValue),
        super(key: key);

  @override
  _CustomHeightPickerState createState() => _CustomHeightPickerState();
}

class _CustomHeightPickerState extends State<CustomHeightPicker> {

  //from ruler picker
  late List<Widget> scaleWidgetList;
  double lastOffset = 0;
  bool isPosFixed = false;
  late String value;
  late ScrollController scrollController;


  //from ruler picker
  int type = 1;

  @override
  void initState() {
    super.initState();
    final initialOffset = (widget.value - widget.minValue) ~/ widget.step * itemExtent;
    scrollController = ScrollController(initialScrollOffset: initialOffset);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {

    var indexOfMiddleElement = (scrollController.offset / itemExtent).round();
    indexOfMiddleElement = indexOfMiddleElement.clamp(0, itemCount - 1);
    final intValueInTheMiddle =
    _intValueFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);

    if (widget.value != intValueInTheMiddle) {
      widget.onChanged(intValueInTheMiddle);
      if (widget.haptics) {
        HapticFeedback.selectionClick();
      }
    }
    Future.delayed(
      Duration(milliseconds: 100),
          () => _maybeCenterValue(),
    );
  }

  @override
  void didUpdateWidget(CustomHeightPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _maybeCenterValue();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool get isScrolling => scrollController.position.isScrollingNotifier.value;

  double get itemExtent => (widget.spacing*2 + 2) * (widget.interval + 1);
  int get itemCount => (widget.maxValue - widget.minValue) ~/ widget.step + 1;

  int get listItemsCount => itemCount + 2 * additionalItemsOnEachSide;

  int get additionalItemsOnEachSide => (widget.itemCount - 1) ~/ 2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.itemCount = (width/itemExtent).round();
    return Center(
      child: SizedBox(
        width: widget.axis == Axis.vertical
            ? widget.itemWidth
            : widget.itemCount * widget.itemWidth,
        height: widget.axis == Axis.vertical
            ? widget.itemCount * widget.itemHeight
            : widget.itemHeight,
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (not) {
            if (not.dragDetails?.primaryVelocity == 0) {
              Future.microtask(() => _maybeCenterValue());
            }
            return true;
          },
          child: Stack(
            children: [
              ListView.builder(
                itemCount: listItemsCount,
                scrollDirection: widget.axis,
                controller: scrollController,
                itemExtent: itemExtent,
                itemBuilder: _singleScaleItemBuilder,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }


  int _intValueFromIndex(int index) {
    index -= additionalItemsOnEachSide;
    index %= itemCount;
    return widget.minValue + index * widget.step;
  }

  void _maybeCenterValue() {
    if (scrollController.hasClients && !isScrolling) {
      int diff = widget.value - widget.minValue;
      int index = diff ~/ widget.step;
      scrollController.animateTo(
        index * itemExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }


  Widget _singleScaleItemBuilder(BuildContext context, index){
    List<Widget> singleScale = [];
    final defaultStyle = widget.textStyle;
    final selectedStyle = widget.selectedTextStyle;

    final value = _intValueFromIndex(index % itemCount);
    final isExtra = (index < additionalItemsOnEachSide ||
        index >= listItemsCount - additionalItemsOnEachSide);
    bool isItemSelected = value == widget.value;
    final itemStyle = isItemSelected ? selectedStyle : defaultStyle;
    singleScale.add(

        isExtra
            ? Container(
            margin: EdgeInsets.symmetric(horizontal: widget.spacing,vertical: 5),
            width:2,
            height:widget.itemHeight,
            child: SizedBox.shrink())
            :
        Container(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: widget.spacing,vertical: 5),
                  color: isItemSelected ? CustomColors.primaryColor :CustomColors.secondaryTextColor,
                  width: 2,
                  height: 32,
                ),
              ),
              Positioned(
                bottom: -40,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                      value.toString(),
                      style:  isItemSelected ? selectedStyle : itemStyle),
                ),
              ),
            ],
          ),
        ));
    for(int i = 0; i < widget.interval; i++){
      singleScale.add(
          isExtra
              ? Container(
              margin: EdgeInsets.symmetric(horizontal: widget.spacing,vertical: 5),
              width:2,
              height:widget.itemHeight,
              child: SizedBox.shrink()) :
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: widget.spacing,vertical: 5),
              color: CustomColors.secondaryTextColor,
              width: 2,
              height: 16,
            ),
          ));
    }
    return
      Container(
        height: 100,
        child:Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: singleScale,
        ),
      );
  }
}

