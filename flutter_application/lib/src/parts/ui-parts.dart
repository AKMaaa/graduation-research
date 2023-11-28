import 'package:flutter/material.dart';
import 'package:flutter_application/src/quiz.dart';
import 'package:flutter_application/src/add.dart';
import 'package:flutter_application/src/ai.dart';
import 'package:flutter_application/src/profile.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_application/src/parts/bottom_bar.dart';

class MyButtomNavBar extends StatefulWidget {
  const MyButtomNavBar({super.key});

  @override
  State<MyButtomNavBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyButtomNavBar> {
  int myCurrentIndex = 0;
  List pages = const [
    QuizPage(),
    AddPage(),
    AIPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: myCurrentIndex,
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
      ),
      body: pages[myCurrentIndex],
    );
  }
}
