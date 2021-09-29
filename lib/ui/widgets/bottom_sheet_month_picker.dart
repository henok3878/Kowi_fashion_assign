import 'package:flutter/material.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:kowi_fashion/utils/date_util.dart';

import 'button.dart';

class MonthPicker extends StatefulWidget {
   MonthPicker({required this.selectedMonth, required this.selectedYear, this.minYear = 1990, this.maxYear = 2050, Key? key}) : super(key: key);
  final int minYear;
  final int maxYear;
   int selectedYear;
   int selectedMonth;

  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    int index = 0;
    for(int i = 0; i < 4; i++){
      List<Widget> singleRow = [];
      for(int j = 0; j < 3; j++){
        String label = DateUtil.months[index];
        singleRow.add(buildRoundedButton(index : index, label: label, onPressed: (ind)=>{
         setState((){
            widget.selectedMonth = ind;
        })

        }, isSelected: index == widget.selectedMonth));
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
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          child: new Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),

              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: widget.selectedYear == widget.minYear ? null : ()=>{
                          setState((){
                            widget.selectedYear--;
                          })
                        }, icon: Icon(Icons.arrow_back_ios,
                          color: widget.selectedYear == widget.minYear ? KowiColours.boarderColor
                              :KowiColours.mainColor,)),
                        Text("${widget.selectedYear}",
                          style: TextStyle(
                            color: KowiColours.mainColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),),
                        IconButton(onPressed: widget.selectedYear == widget.maxYear ? null : ()=>{
                          setState((){
                            widget.selectedYear++;
                          })
                        }, icon: Icon(Icons.arrow_forward_ios,
                          color:  widget.selectedYear == widget.maxYear ? KowiColours.boarderColor
                          : KowiColours.mainColor,)),
                      ],
                    ),
                    SizedBox(height: 8),
                    ...children
                  ],
                ),
              )),
        ));
  }



  Widget buildRoundedButton({bool isSelected = false,required String label, required Function onPressed,

  required int index}){
    return    InkWell(
      borderRadius: BorderRadius.circular(18.0),
      overlayColor: MaterialStateColor.resolveWith(
            (states) => Color(0xffff5a5a),
      ),
      focusColor: Color(0xffff5a5a),
      splashColor: Color(0xffff5a5a),
      onTap: (){
        onPressed(index);
      },
      child: Button(
        type: "$label",
        isSelected: isSelected,
      ),
    );
  }
}
