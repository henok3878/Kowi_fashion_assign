import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:sizer/sizer.dart';

class InstructionItem extends StatefulWidget {
  final String instruction;
  final bool isFollowed;
  final Function(bool) onPressed;
  const InstructionItem({required this.onPressed, required this.instruction, required this.isFollowed, Key? key}) : super(key: key);

  @override
  _InstructionItemState createState() => _InstructionItemState();
}

class _InstructionItemState extends State<InstructionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(onTap: ()=>{
            widget.onPressed(!widget.isFollowed)
          },child: widget.isFollowed ? Icon(Icons.check_circle, color: CustomColors.primaryColor,) :
          Icon(Icons.radio_button_unchecked, color: CustomColors.primaryColor,),),
          SizedBox(width: 8,),
          Expanded(child: Text(widget.instruction,style: GoogleFonts.quicksand(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal
          ),))
        ],
      ),
    );
  }
}
