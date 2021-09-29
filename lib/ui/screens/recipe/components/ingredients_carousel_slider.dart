import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kowi_fashion/models/ingredient.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'ingredient_item.dart';


class IngredientsCarouselWithIndicator extends StatefulWidget {
  final List<Ingredient> ingredients;
  IngredientsCarouselWithIndicator({required this.ingredients});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<IngredientsCarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final indicatorMargin = 8;
    final width = MediaQuery.of(context).size.width;
    final itemLength = widget.ingredients.length;
    final indicatorWidth = (width - 48 - (2*indicatorMargin*itemLength))/itemLength;

    final List<Widget> imageSliders = widget.ingredients
        .map((item) => IngredientItem(ingredient: item,backgroundColor: widget.ingredients.indexOf(item) == _current ?KowiColours.pink : Colors.white,))
        .toList();
    return  Column(
         mainAxisSize: MainAxisSize.min,
        children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            height: 112,
              viewportFraction: 0.4,
              autoPlay: false,
              enlargeCenterPage: false,
              //aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.ingredients.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: indicatorWidth,
                height: 6.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    shape: BoxShape.rectangle,
                    color: _current == entry.key ? KowiColours.mainColor: KowiColours.inactivePageIndicatorColor),
              ),
            );
          }).toList(),
        ),
      ]);
  }
}