import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Button extends StatelessWidget {
  final String type;
  final bool isSelected;

  Button({
    Key? key,
    required this.type,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.3.h,
      width: (MediaQuery.of(context).size.width - 46) / 3.5,
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xffff5a5a).withOpacity(0.9)
            : Color(0xffff5a5a).withOpacity(0),
        borderRadius: BorderRadius.circular(18),
        border: isSelected
            ? Border.all(color: Color(0xffff5a5a), width: 1)
            : Border.all(color: Color.fromRGBO(228, 228, 228, 1), width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              type,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: isSelected ? Color(0xffffffff) : Color(0xffff5a5a)),
            ),
          ],
        ),
      ),
    );
  }
}
