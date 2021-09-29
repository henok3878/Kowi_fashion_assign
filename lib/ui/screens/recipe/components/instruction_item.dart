import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/models/instruction.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:sizer/sizer.dart';

class InstructionItem extends StatefulWidget {
  final Instruction instruction;
  final Function(bool) onPressed;
  const InstructionItem({required this.onPressed, required this.instruction, Key? key}) : super(key: key);

  @override
  _InstructionItemState createState() => _InstructionItemState();
}

class _InstructionItemState extends State<InstructionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(onTap: ()=>{
            widget.onPressed(!widget.instruction.isFollowed)
          },child: widget.instruction.isFollowed ? Icon(Icons.check_circle, color: KowiColours.mainColor,) :
          Icon(Icons.radio_button_unchecked, color: KowiColours.mainColor,),),
          SizedBox(width: 8,),
          Expanded(child: Text(widget.instruction.instruction,style: GoogleFonts.quicksand(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            color: widget.instruction.isFollowed ? Color(0xff929292) : Colors.black
          ),))
        ],
      ),
    );
  }
}
