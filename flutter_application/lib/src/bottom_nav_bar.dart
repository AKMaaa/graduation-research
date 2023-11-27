import 'package:flutter/material.dart';
import 'package:flutter_application/src/quiz.dart';
import 'package:flutter_application/src/add.dart';
import 'package:flutter_application/src/ai.dart';
import 'package:flutter_application/src/profile.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bottom Navigation Bar"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 25,
              offset: const Offset(0, 2))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: const Color(0xFF7A8EF8),
              unselectedItemColor: Color(0xffE1E1E1),
              currentIndex: myCurrentIndex,
              onTap: (index){
                setState((){
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.quiz,size:25), label: "Quiz"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle,size:25), label: "Add"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.psychology,size:25), label: "AI"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle,size:25), label: "Profile"),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
