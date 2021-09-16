import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kowi_fashion/ui/screens/mini_data.dart';

import 'ui/widgets/custom_height_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MiniDataScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
