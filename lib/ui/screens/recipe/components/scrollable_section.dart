import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/models/ingredient.dart';
import 'package:kowi_fashion/models/instruction.dart';
import 'package:kowi_fashion/ui/screens/recipe/components/instruction_item.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:sizer/sizer.dart';

import '../recipe_viewmodel.dart';
import 'ingredients_carousel_slider.dart';

class ScrollableSection extends StatelessWidget {
  final List<Instruction> instructions;
  final List<Ingredient> ingredients;
  const ScrollableSection({required this.instructions, Key? key, required this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        buildIngredientSection(),
        SizedBox(height: 8,),
        ...buildInstructionSection()

      ],);
  }

  Widget buildIngredientSection(){

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ingredients",style: GoogleFonts.quicksand(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal
          ),),
          SizedBox(height: 16,),
          IngredientsCarouselWithIndicator(ingredients: ingredients,)
        ],
      );

  }

  List<Widget> buildInstructionSection(){
    RecipeViewModel controller = Get.find<RecipeViewModel>();

    List<Widget> instructionWidgets =  List<Widget>.from(instructions.map((e) => InstructionItem(onPressed: (value)=>{}, instruction: e)));

    List<Widget> children = [
      Text("Instructions",style: GoogleFonts.quicksand(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal
      ),),
      SizedBox(height: 8,),
      ...instructionWidgets,
      SizedBox(height: 16,),
      buildBonAppetit(),
      SizedBox(height: 8,),
      Text("Upload Your Cooked Food, And Enjoy Awesome Rewards",style: GoogleFonts.quicksand(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: Color(0xff929292),
      ),
        textAlign: TextAlign.center,),
      SizedBox(height: 12,),
      buildUploadButton(onPressed: controller.pickImage),
      SizedBox(height: 16,),
      buildBottomButtons(),
    ];
    return children;
  }

  Widget buildUploadButton({required VoidCallback onPressed}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Upload",style: GoogleFonts.quicksand(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: KowiColours.mainColor
            )),SizedBox(width: 16,),
              SvgPicture.asset(
                  'assets/Camera.svg',width: 32,height: 32,
                  semanticsLabel: 'Camera Logo'
              ),],
          ),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: KowiColours.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
      ),
    );
  }
  Widget buildBottomButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Row(
            children: [
              IconButton(onPressed: ()=>{}, icon: Icon(Icons.favorite, size: 32, color: KowiColours.mainColor,)),
              Text("169",style: GoogleFonts.quicksand(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: KowiColours.mainColor

              ))
            ],
          ),
          Row(
            children: [
              buildButtonFromSvg(onPressed: ()=>{},svgName: "Thumbs Down.svg"),
              Text("169",style: GoogleFonts.quicksand(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: KowiColours.mainColor
              ))
            ],
          )
        ],),
        buildButtonFromSvg(onPressed: ()=>{},svgName: "Share.svg")

      ],
    );
  }
  Widget buildBonAppetit(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
            'assets/Greek Salad.svg',width: 32,height: 32,
            semanticsLabel: 'Greek Salad Logo'
        ),
        SizedBox(width: 8,),
        Text("Bon Appetit!", style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal
        ),)

      ],
    );
  }





  Widget buildButtonFromSvg({required String svgName,required VoidCallback onPressed}){
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
            'assets/$svgName',width: 32,height: 32,
            semanticsLabel: '$svgName Logo'
        ),
      ),
    );
  }
}
