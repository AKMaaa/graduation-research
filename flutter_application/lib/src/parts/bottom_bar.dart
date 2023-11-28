import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.quiz, size: 25), label: "Quiz"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, size: 25), label: "Add"),
            BottomNavigationBarItem(
                icon: Icon(Icons.psychology, size: 25), label: "AI"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 25), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
