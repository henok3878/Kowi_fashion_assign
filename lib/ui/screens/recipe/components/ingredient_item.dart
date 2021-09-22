import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/models/ingredient.dart';
import 'package:sizer/sizer.dart';

class IngredientItem extends StatelessWidget {
  final Color backgroundColor;
  final Ingredient ingredient;
  const IngredientItem({required this.ingredient, required this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: backgroundColor,
    child: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
          ingredient.iconPath,width: 32,height: 32,
          semanticsLabel: ingredient.name
          ),
          Text(ingredient.name,style: GoogleFonts.quicksand(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal
          ),),
          Text(ingredient.description,style: GoogleFonts.quicksand(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal
          ),),
        ],
      ),
    ),

      );
  }
}
