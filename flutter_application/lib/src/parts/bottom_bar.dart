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
    const double radiusValue = 50;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusValue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusValue),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: Colors.transparent,
            iconTheme: MaterialStateProperty.all(
              const IconThemeData(color: Color(0xffE1E1E1)),
            ),
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 0),
            ),
          ),
          child: NavigationBar(
            elevation: 0.0,
            selectedIndex: currentIndex,
            onDestinationSelected: onTap,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.quiz, size: 30),
                selectedIcon:
                    Icon(Icons.quiz, color: Color(0xFF7A8EF8), size: 30),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle, size: 30),
                selectedIcon:
                    Icon(Icons.add_circle, color: Color(0xFF7A8EF8), size: 30),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.psychology, size: 30),
                selectedIcon:
                    Icon(Icons.psychology, color: Color(0xFF7A8EF8), size: 30),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle, size: 30),
                selectedIcon: Icon(Icons.account_circle,
                    color: Color(0xFF7A8EF8), size: 30),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
