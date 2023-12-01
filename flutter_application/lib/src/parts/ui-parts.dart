import 'package:flutter/material.dart';
import 'package:flutter_application/src/quiz.dart';
import 'package:flutter_application/src/add.dart';
import 'package:flutter_application/src/ai.dart';
import 'package:flutter_application/src/profile.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_application/src/parts/bottom_bar.dart';
import 'package:flutter_application/src/quiz-list.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;

  final List<Widget> pages = [
    QuizPage(),
    AddPage(),
    AIPage(),
    ProfilePage(),
  ];

  void _navigateToPage(int index) {
    setState(() {
      myCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: myCurrentIndex,
        onTap: _navigateToPage,
      ),
      body: pages[myCurrentIndex], // 表示するページのウィジェット
    );
  }
}
