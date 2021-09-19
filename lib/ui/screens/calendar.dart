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
              border: Border.all(color: CustomColors.primaryColor, width: 2),
              shape: BoxShape.rectangle,
            ),
            todayHighlightColor: CustomColors.primaryColor,
            view: CalendarView.month,
              /*monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) {
                  print("Here are visible dates : ${details.visibleDates}");
                    DateTime date = details.date;
                    DateTime today = DateTime.now();
                    bool isToday = date.year == today.year && today.month == date.month && date.day == today.day;
                    bool isVisible = details.visibleDates.contains(date);
                    print("Date $date \n VisibleDates ${details.visibleDates}");
                    if(isVisible){
                      print("Date $date \n VisibleDates ${details.visibleDates}");
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black, width: 0.5),
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
                        color: CustomColors.primaryColor,
                        child: Text(
                          details.date.day.toString(),
                          style: TextStyle(
                                       fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black54
                                    ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },*/
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
}
