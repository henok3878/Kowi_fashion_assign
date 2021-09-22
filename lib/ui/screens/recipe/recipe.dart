import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/models/ingredient.dart';
import 'package:kowi_fashion/models/instruction.dart';
import 'package:kowi_fashion/ui/screens/recipe/components/scrollable_section.dart';
import 'package:kowi_fashion/ui/screens/recipe/components/video_player.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:sizer/sizer.dart';

class RecipeScreen extends StatelessWidget {
  RecipeScreen({Key? key}) : super(key: key);


  final List<Instruction> instructions = [
    Instruction(isFollowed: true,
        instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. "),
    Instruction(isFollowed: true,
        instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. "),
    Instruction(isFollowed: false,
        instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. "),
    Instruction(isFollowed: false,
        instruction: "To begin making the Masala Karela Recipe, de-seed the karela and slice. Do not remove the skin as the skin has all the nutrients. "),

  ];

  final List<Ingredient> ingredients = [

    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),
    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),
    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),
    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),
    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),
    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),
    Ingredient(name: "Cumin seeds", description: "2 sliced", iconPath: "assets/Paprika.svg"),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(children: [
          IconButton(onPressed: ()=>{}, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
          CircleAvatar(backgroundImage: NetworkImage("https://images.generated.photos/oYMWf2yqFM2yG3_PKN0iXwfNVfNQ86QjQJPmYOxhInE/rs:fit:256:256/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/MDA2NjkxLmpwZw.jpg"),radius: 21,)
        ],),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoPlayerItem(videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',),
              Row(children: [
                Icon(Icons.timer, size: 28,color: CustomColors.primaryColor,),
                SizedBox(width: 8,),
                Text("Time 30 Min", style: GoogleFonts.quicksand(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal
                ),)
              ],),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Chicken Curry", style: GoogleFonts.quicksand(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal
                ),),
                Text("250 Grams", style: GoogleFonts.quicksand(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal
                ),)
              ],),
          SizedBox(height: 8,),
          Expanded(child: ScrollableSection(instructions: instructions,ingredients: ingredients))
        ]),
      ),
    );
  }
}
