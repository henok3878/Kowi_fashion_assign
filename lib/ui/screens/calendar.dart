import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kowi_fashion/ui/widgets/button.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:kowi_fashion/utils/date_util.dart';
import 'package:sizer/sizer.dart';
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

  Container headerWidget(BuildContext context){
    List<Widget> children = [];
    int index = 0;
    for(int i = 0; i < 4; i++){
      List<Widget> singleRow = [];
      for(int j = 0; j < 3; j++){
        String label = DateUtil.months[index];
        singleRow.add(buildRoundedButton(label: label, onPressed: ()=>{}));
        index++;
      }
      children.add( Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: singleRow
      ),);
      if(index != 11){
        children.add( SizedBox(height: 16,),);
      }
    }
    
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: ()=>{}, icon: Icon(Icons.arrow_back_ios,
                color: CustomColors.primaryColor,)),
              Text("2021",
                style: TextStyle(
                color: CustomColors.primaryColor,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),),
              IconButton(onPressed: ()=>{}, icon: Icon(Icons.arrow_forward_ios,
                color: CustomColors.primaryColor,)),
            ],
          ),
          SizedBox(height: 8),
         ...children
        ],
      ),
    );
  }


  Widget buildRoundedButton({bool isSelected = false,required String label, required VoidCallback onPressed}){
    return    InkWell(
      borderRadius: BorderRadius.circular(18.0),
      overlayColor: MaterialStateColor.resolveWith(
            (states) => Color(0xffff5a5a),
      ),
      focusColor: Color(0xffff5a5a),
      splashColor: Color(0xffff5a5a),
      onTap: onPressed,
      child: Button(
        type: "$label",
        isSelected: isSelected,
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
          return  Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                child: new Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),

                  child: headerWidget(context),
                )),
          );
        });
  }
}
