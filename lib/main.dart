import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kowi_fashion/ui/screens/mini_data.dart';
import 'package:kowi_fashion/ui/screens/recipe/components/video_player.dart';
import 'package:kowi_fashion/ui/screens/recipe/components/youtube_video_player.dart';
import 'package:kowi_fashion/ui/screens/recipe/recipe.dart';
import 'package:kowi_fashion/ui/screens/video_example.dart';
import 'package:sizer/sizer.dart';

import 'ui/screens/home/home.dart';
import 'ui/widgets/custom_height_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType)
    {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Home()//RecipeScreen()//MiniDataScreen(title: 'Flutter Demo Home Page'),
      );
    });
  }
}
