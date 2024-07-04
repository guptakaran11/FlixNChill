//* Package
import 'package:flutter/material.dart';

//* Screens
import '../Screens/home_screen.dart';
import '../Screens/movies_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PageController pageController = PageController(initialPage: 0);
  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        controller: pageController,
        children: const [
          Center(
            child: HomePage(),
          ),
          Center(
            child: MoviesScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
        ],
      ),
    );
  }
}
