import 'package:flutter/material.dart';
import 'package:quiz_app/utils/color_constants.dart';
import 'package:quiz_app/view/Question_screen/Question_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: ColorConstants.primarycolor),
      debugShowCheckedModeBanner: false,
      home: QuestionScreen(),
    );
  }
}
