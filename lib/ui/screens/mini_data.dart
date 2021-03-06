
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kowi_fashion/ui/screens/calendar.dart';
import 'package:kowi_fashion/ui/widgets/custom_height_picker.dart';
import 'package:kowi_fashion/ui/widgets/custom_number_picker.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';

class MiniDataScreen extends StatefulWidget {
  MiniDataScreen({Key? key, required this.title}) : super(key: key);
  final String minDateTime = '2019-05-15 20:10:55';
  final String maxDateTime = '2019-07-01 12:30:40';
  final String initDateTime = '2019-05-16 09:00:58';
  final String dateFormat = 'dd-MMM-yyyy';
  final double kgToPound = 2.20462;
  final double poundToKg = 0.453592;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MiniDataScreen> {
  int _currentWeightValue = 130;
  int _minWeightValue = 110;
  int _maxWeightValue = 220;
  int _currentHeightValue = 172;
  int _minHeightValue = 1;
  int _maxHeightValue = 300;
  int _currentHorizontalIntValue = 172;

  //num showValue = 0;
  bool poundSelected = true;
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KowiColours.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: KowiColours.backgroundColor,
          title: Row(
            children: [
              IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: KowiColours.mainColor,
                  )),
              Text("About Me",
                  style: TextStyle(color: KowiColours.mainColor)),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 64, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //DOB label
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('DOB',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: KowiColours.mainColor)),
                  ),
                  buildDatePicker(),
                  SizedBox(height: 16),
                  //Height Picker label
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Height',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: KowiColours.mainColor),
                        ),
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                              unSelectedColor: KowiColours.mainColor),
                          enableShape: true,
                          elevation: 0,
                          defaultSelected: "Meters",
                          enableButtonWrap: true,
                          width: 100,
                          autoWidth: false,
                          unSelectedColor: KowiColours.backgroundColor,
                          buttonLables: [
                            "Feet",
                            "Meters",
                          ],
                          buttonValues: [
                            "Feet",
                            "Meters",
                          ],
                          radioButtonValue: (value) {
                            print(value);
                          },
                          unSelectedBorderColor: KowiColours.boarderColor,
                          selectedColor: KowiColours.mainColor,
                          selectedBorderColor: KowiColours.mainColor,
                        ),
                      ],
                    ),
                  ),
                  CustomHeightPicker(
                    key: ValueKey("custom_ruler_picker"),
                    limit: 200,
                    interval: 4,
                    scaleSize: 100,
                    selectedTextStyle: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: KowiColours.mainColor),
                    textStyle: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: KowiColours.secondaryTextColor),
                    itemCount: 8,
                    itemHeight: 150,
                    itemWidth: 100,
                    value: _currentHeightValue,
                    minValue: _minHeightValue,
                    maxValue: _maxHeightValue,
                    step: 1,
                    haptics: true,
                    axis: Axis.horizontal,
                    onChanged: (value) =>
                        setState(() => _currentHeightValue = value),
                  ),
                  //Weight Picker label
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Weight',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: KowiColours.mainColor)),
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                              unSelectedColor: KowiColours.mainColor),
                          enableShape: true,
                          elevation: 0,
                          defaultSelected: "Pound",
                          enableButtonWrap: true,
                          width: 100,
                          autoWidth: false,
                          unSelectedColor: KowiColours.backgroundColor,
                          buttonLables: [
                            "Kg",
                            "Pound",
                          ],
                          buttonValues: [
                            "Kg",
                            "Pound",
                          ],
                          radioButtonValue: (value) {
                            setState(() {
                              if (poundSelected && value == "Kg") {
                                _currentWeightValue =
                                    (_currentWeightValue * widget.poundToKg)
                                        .toInt();
                                _minWeightValue =
                                    (_minWeightValue * widget.poundToKg)
                                        .toInt();
                                _maxWeightValue =
                                    (_maxWeightValue * widget.poundToKg)
                                        .toInt();
                                poundSelected = false;
                              } else if (!poundSelected && value == "Pound") {
                                _currentWeightValue =
                                    (_currentWeightValue * widget.kgToPound)
                                        .toInt();
                                _minWeightValue =
                                    (_minWeightValue * widget.kgToPound)
                                        .toInt();
                                _maxWeightValue =
                                    (_maxWeightValue * widget.kgToPound)
                                        .toInt();
                                poundSelected = true;
                              }
                            });
                          },
                          unSelectedBorderColor: KowiColours.boarderColor,
                          selectedColor: KowiColours.mainColor,
                          selectedBorderColor: KowiColours.mainColor,
                        ),
                      ],
                    ),
                  ),
                  CustomNumberPicker(
                    key: ValueKey("number_picker"),
                    selectedTextStyle: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: KowiColours.mainColor),
                    textStyle: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: KowiColours.secondaryTextColor),
                    itemCount: 7,
                    itemHeight: 150,
                    itemWidth: 64,
                    value: _currentWeightValue,
                    minValue: _minWeightValue,
                    maxValue: _maxWeightValue,
                    step: 1,
                    haptics: true,
                    axis: Axis.horizontal,
                    onChanged: (value) =>
                        setState(() => _currentWeightValue = value),
                  ),
                  /*Text("Number Picker Library"),
                  NumberPicker(
                    value: _currentHorizontalIntValue,
                    minValue: 0,
                    maxValue: 250,
                    step: 1,
                    itemCount: 4,
                    itemHeight: 100,
                    axis: Axis.horizontal,
                    onChanged: (value) =>
                        setState(() => _currentHorizontalIntValue = value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black26),
                    ),
                  ),*/
                ],
              ),
            ),
            //Action Button
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 16),
                margin: EdgeInsets.symmetric(horizontal: 128),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                CalendarScreen()
                            ))},
                        child: Text("CONFIRM"),
                        style: ElevatedButton.styleFrom(
                            primary: KowiColours.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildDatePicker() => SizedBox(
    height: 120,
    child: CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: CupertinoTheme.of(context)
              .textTheme
              .dateTimePickerTextStyle
              .copyWith(
            fontSize: 20,
            letterSpacing: 0.15,
            fontWeight: FontWeight.w500,
            color: KowiColours.mainColor,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      child: CupertinoDatePicker(
        minimumYear: 1900,
        maximumYear: 2022,
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) =>
            setState(() => this.dateTime = dateTime),
      ),
    ),
  );
}
