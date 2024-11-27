import 'package:flutter/material.dart';
import 'package:po_karmanu_project/models/bottom_nav_bar.dart';
import 'package:po_karmanu_project/pages/content_page/home/home_screen.dart';
import 'package:po_karmanu_project/pages/content_page/home/toggle_screen_home.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  // final parameters = Get.parameters;
  var _activeScreen = ToggleScreenHome();

  void _changeCurrentPage(int index) {
    switch (index) {
      case 0: setState(() {
        _activeScreen = ToggleScreenHome();
      });
      case 1: setState(() {
        _activeScreen = ToggleScreenHome();
      });
      case 2: setState(() {
        _activeScreen = ToggleScreenHome();
      });
      case 3: setState(() {
        _activeScreen = ToggleScreenHome();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListOfColors.primaryWhite,
      body: SafeArea(
        child: Stack(
          children: [
            _activeScreen,
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const BottomNavBar(currentIndex: 0,)
            )
          ],
        ),
      ),
    );
  }
}
