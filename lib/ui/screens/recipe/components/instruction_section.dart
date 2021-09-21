import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/ui/screens/recipe/components/instruction_item.dart';
import 'package:sizer/sizer.dart';

class InstructionSection extends StatelessWidget {
  const InstructionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        InstructionItem(onPressed: (value)=>{}, instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. ", isFollowed: true),
        InstructionItem(onPressed: (value)=>{}, instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. ", isFollowed: true),
        InstructionItem(onPressed: (value)=>{}, instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. ", isFollowed: false),
        InstructionItem(onPressed: (value)=>{}, instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. ", isFollowed: false),
      ],);
  }
}
