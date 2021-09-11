import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kowi_fashion/custom_colors.dart';
import 'package:kowi_fashion/custom_number_picker.dart';
import 'package:kowi_fashion/custom_ruler_picker.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
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

class _MyHomePageState extends State<MyHomePage> {
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
        backgroundColor: CustomColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.backgroundColor,
          title: Row(
            children: [
              IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: CustomColors.primaryColor,
                  )),
              Text("About Me",
                  style: TextStyle(color: CustomColors.primaryColor)),
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
                            .copyWith(color: CustomColors.primaryColor)),
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
                              .copyWith(color: CustomColors.primaryColor),
                        ),
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                              unSelectedColor: CustomColors.primaryColor),
                          enableShape: true,
                          elevation: 0,
                          defaultSelected: "Meters",
                          enableButtonWrap: true,
                          width: 100,
                          autoWidth: false,
                          unSelectedColor: CustomColors.backgroundColor,
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
                          unSelectedBorderColor: CustomColors.boarderColor,
                          selectedColor: CustomColors.primaryColor,
                          selectedBorderColor: CustomColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  CustomRulerPicker(
                    key: ValueKey("custom_ruler_picker"),
                    limit: 200,
                    interval: 4,
                    scaleSize: 100,
                    selectedTextStyle: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: CustomColors.primaryColor),
                    textStyle: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: CustomColors.secondaryTextColor),
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
                                .copyWith(color: CustomColors.primaryColor)),
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                              unSelectedColor: CustomColors.primaryColor),
                          enableShape: true,
                          elevation: 0,
                          defaultSelected: "Pound",
                          enableButtonWrap: true,
                          width: 100,
                          autoWidth: false,
                          unSelectedColor: CustomColors.backgroundColor,
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
                          unSelectedBorderColor: CustomColors.boarderColor,
                          selectedColor: CustomColors.primaryColor,
                          selectedBorderColor: CustomColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  CustomNumberPicker(
                    key: ValueKey("number_picker"),
                    selectedTextStyle: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: CustomColors.primaryColor),
                    textStyle: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: CustomColors.secondaryTextColor),
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
                        onPressed: () => {},
                        child: Text("CONFIRM"),
                        style: ElevatedButton.styleFrom(
                            primary: CustomColors.primaryColor,
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
                    color: CustomColors.primaryColor,
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
