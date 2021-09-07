import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kowi_fashion/custom_colors.dart';
typedef TextMapper = String Function(String numberText);

class CustomRulerPicker extends StatefulWidget {
  final int interval;
  final double totalWidth;
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
  final int itemCount;

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


  const CustomRulerPicker({
    required this.totalWidth,
    required this.scaleSize,
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
  _CustomRulerPickerState createState() => _CustomRulerPickerState();
}

class _CustomRulerPickerState extends State<CustomRulerPicker> {

  //from ruler picker
  late List<Widget> scaleWidgetList;
  double lastOffset = 0;
  bool isPosFixed = false;
  late String value;
  late ScrollController scrollController;

  //from ruler picker
  int type = 1;


  static const int BIG_BAR = 1;
  static const int SMALL_BAR = 2;

  @override
  void initState() {
    super.initState();
    final initialOffset = (widget.value - widget.minValue) ~/ widget.step * itemExtent;
    scrollController = ScrollController(initialScrollOffset: initialOffset);
    scrollController.addListener(_scrollListener);

    //from ruler picker

  }
  List<Widget> _generateScale(BuildContext context) {
    List<Widget> scaleWidgetList = [];
    for (int i = 0; i < widget.limit; i++) {
      scaleWidgetList.add(makeRulerBar(
        textStyle: widget.textStyle,
        key: ValueKey(i),
        num: i,
        context: context,
        type: BIG_BAR,
        lowerLimit: widget.lowerLimit,
        upperLimit: widget.upperLimit,
        midLimitLower: widget.midLimitLower,
        midLimitUpper: widget.midLimitUpper,
        midInterval: widget.interval,
        normalBarColor: CustomColors.primaryColor,
        axis: widget.axis,
      ));
    }

    if (mounted) setState(() {});
    return scaleWidgetList;
  }

  void _scrollListener() {

    var indexOfMiddleElement = (scrollController.offset / itemExtent).round();
    indexOfMiddleElement = indexOfMiddleElement.clamp(0, itemCount - 1);
    final intValueInTheMiddle =
    _intValueFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);
      print("Scroll offset: " + scrollController.offset.toString());
    print("item extent: "+ itemExtent.toString());
    print("index of middle : " + indexOfMiddleElement.toString());
    print("intValueInTheMiddle "+ intValueInTheMiddle.toString());

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
  void didUpdateWidget(CustomRulerPicker oldWidget) {
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

  double get itemExtent =>
      widget.axis == Axis.vertical ? widget.itemHeight : widget.itemWidth;

  int get itemCount => (widget.maxValue - widget.minValue) ~/ widget.step + 1;

  int get listItemsCount => itemCount + 2 * additionalItemsOnEachSide;

  int get additionalItemsOnEachSide => (widget.itemCount - 1) ~/ 2;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
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
            SingleChildScrollView(
              controller: scrollController,
              scrollDirection: widget.axis,
              child: RotatedBox(
                quarterTurns: widget.axis == Axis.horizontal ? 4 : 3,
                child: Row(
                  children: _generateScale(context),
                ),
              ),),

            _NumberPickerSelectedItemDecoration(
              axis: widget.axis,
              itemExtent: itemExtent,
              decoration: widget.decoration,
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayedValue(int value) {
    final text = widget.zeroPad
        ? value.toString().padLeft(widget.maxValue.toString().length, '0')
        : value.toString();
    if (widget.textMapper != null) {
      return widget.textMapper!(text);
    } else {
      return text;
    }
  }

  int _intValueFromIndex(int index) {
    //print("IntValueFromIndex : $index}");
    index -= additionalItemsOnEachSide;
    index %= itemCount;
    return widget.minValue + index * widget.step;
  }

  void _maybeCenterValue() {
    if (scrollController.hasClients && !isScrolling) {
      int diff = widget.value - widget.minValue;
      int index = diff ~/ widget.step;
      print("Ruler picker widget.value : ${widget.value} - widget.minValue : ${widget.minValue}");
      print("Ruler picker Difference : $diff");
      print("Ruler Picker step : ${widget.step}");
      print("Ruler picker Index : $index");
      print("Ruler picker Index*itemExtent : ${index*itemExtent}");
      double goTo = index * itemExtent;
      print("Ruler picker goTo: $goTo");

      scrollController.animateTo(
        goTo,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }
  Widget makeRulerBar({
    required Key? key,
    required TextStyle textStyle,
    required  num,
    required  type,
    required  lowerLimit,
    required  midLimitLower,
    required  midLimitUpper,
    required  upperLimit,
    required  midInterval,
    required  normalBarColor,
    Axis axis = Axis.horizontal,
    double spacing = 8.0,
    required  BuildContext context
  }){
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getSmallBars(context,spacing,num,type,midInterval,textStyle),
      ),
    );
  }





  /// get color of small bar according to range


  /// get color of bigger bar according to range

  List<Widget> _getSmallBars(BuildContext context, spacing,num,type,midInterval,textStyle){
    List<Widget> children = [];
    final defaultStyle = widget.textStyle;
    final selectedStyle = widget.selectedTextStyle ;
    final value = _intValueFromIndex(num % itemCount);
    /*print("Value from calculation: $value");
    print("Value from the parent: ${widget.value}");*/
    bool isItemSelected = value == widget.value;
    final isExtra =
    (num < additionalItemsOnEachSide ||
        num >= listItemsCount - additionalItemsOnEachSide);

    final itemStyle = isItemSelected ? selectedStyle : defaultStyle;


    children = [];

    children.add(
      Container(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: spacing,vertical: 5),
                color: isItemSelected ? CustomColors.primaryColor :CustomColors.secondaryTextColor,
                width: 2,
                height: 32,
              ),
            ),
            Positioned(

              bottom: -40,
              left: -12,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                    value.toString(),
                    style:  isItemSelected ? selectedStyle : itemStyle)
                ,
              ),
            ),
          ],
        ),
      ),
    );

    for (int i = 1; i <= midInterval; i++) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: spacing,vertical: 5),
          color: CustomColors.secondaryTextColor,
          width: 2,
          height: 16,
        ),
      ));
    }
    return children;
  }
}

class _NumberPickerSelectedItemDecoration extends StatelessWidget {
  final Axis axis;
  final double itemExtent;
  final Decoration? decoration;

  const _NumberPickerSelectedItemDecoration({
    Key? key,
    required this.axis,
    required this.itemExtent,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          width: isVertical ? double.infinity : itemExtent,
          height: isVertical ? itemExtent : double.infinity,
          decoration: decoration
          ,
        ),
      ),
    );
  }

  bool get isVertical => axis == Axis.vertical;

}

class SelectedItem extends StatelessWidget {
  SelectedItem({required this.value, required this.style, Key? key}) : super(key: key);
  String value;
  TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(value, style: this.style,),
        RotatedBox(
          quarterTurns: 3,
          child: Icon(
            Icons.play_arrow, size: 48,color: CustomColors.primaryColor,),
        )
      ],
    );
  }
}

