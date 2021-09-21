import 'package:flutter/material.dart';
import 'package:kowi_fashion/ui/widgets/bottom_sheet_month_picker.dart' as customMonthPicker;
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: buildAppBar(context),
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        child: Container(

          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16,16,16,32),
          child: SfCalendar(
            onViewChanged:(ViewChangedDetails details){

            },
            onSelectionChanged:(CalendarSelectionDetails details){

            },
            headerDateFormat: 'MMM yyy',
            headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(
                color: CustomColors.primaryColor,
                  fontSize: 20
              )
          ),
            firstDayOfWeek: 1,
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              //border: Border.all(color: CustomColors.primaryColor, width: 2),
              shape: BoxShape.rectangle,
            ),
            todayHighlightColor: CustomColors.primaryColor,
            view: CalendarView.month,
            monthViewSettings: MonthViewSettings(
                monthCellStyle: MonthCellStyle(
                  trailingDatesBackgroundColor: CustomColors.inactiveDate,
                  leadingDatesBackgroundColor: CustomColors.inactiveDate
                ),
                dayFormat: 'EEE',
                showAgenda: false,
                navigationDirection: MonthNavigationDirection.vertical),
                monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) => monthCellBuilder(buildContext,details),
          ),
        ),
      ),
    );
  }


  buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: CustomColors.primaryColor,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // ProfileView().shortProfile(context, data);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: Color(0xffFFB800),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    CircleAvatar(backgroundImage: NetworkImage("https://images.generated.photos/oYMWf2yqFM2yG3_PKN0iXwfNVfNQ86QjQJPmYOxhInE/rs:fit:256:256/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/MDA2NjkxLmpwZw.jpg"), radius: 17),
              ),
            ),
          ],
        ),
        leadingWidth: 30,
        actions: [
          IconButton(
              onPressed: () => {_modalBottomSheetMenu(context)},
              icon: Icon(Icons.calendar_today_outlined),)
        ]);
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return  customMonthPicker.MonthPicker(minYear: 2010, selectedMonth: DateTime.now().month - 1,selectedYear: DateTime.now().year,);
        });

  }

  monthCellBuilder(context,details){
    DateTime date = details.date;
    DateTime today = DateTime.now();
    bool isToday = date.year == today.year && today.month == date.month && date.day == today.day;
    List<int> list = [];
    List<DateTime> plannedByUser = [
      DateTime(2021,9,1),
      DateTime(2021,9,3),
      DateTime(2021,10,3),
      DateTime(2021,9,11),
    ];
    List<DateTime> plannedByKowi = [
      DateTime(2021,9,15),
      DateTime(2021,9,25),
      DateTime(2021,10,25),
      DateTime(2021,9,27),
    ];
    int currentMonth  = details.visibleDates[15].month;
    bool notActive = date.month > currentMonth || date.month < currentMonth;
    bool isPlannedByKowi = plannedByKowi.contains(date);
    bool isPlannedByUser = plannedByUser.contains(date);
    if(!notActive){
      return Container(
        decoration: BoxDecoration(
          color: isPlannedByKowi ? CustomColors.primaryColor : (isPlannedByUser ? CustomColors.pink :  Colors.transparent),
          border: Border.all(color: isToday ? CustomColors.primaryColor :  Colors.black26, width: isToday ? 2 : 0.5),
          shape: BoxShape.rectangle,
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          details.date.day.toString(),
          textAlign: TextAlign.center,
        ),
      );
    }
    else{
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: CustomColors.inactiveDate,
          border: Border.all(color: CustomColors.boarderColor, width: 0.5),
          shape: BoxShape.rectangle,
        ),
        child: Text(
          details.date.day.toString(),
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black54
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

}
