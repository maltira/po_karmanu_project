import 'package:flutter/material.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 80,
      decoration: BoxDecoration(
        color: ListOfColors.primaryWhite,
        boxShadow: [
          BoxShadow(
            color: ListOfColors.primaryBlack.withOpacity(0.2),
            blurRadius: 1.0
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              _selectPage(0);
            },
            child: Icon(Icons.home, size: 32),
          ),
          GestureDetector(
            onTap: (){
              _selectPage(1);
            },
            child: Icon(Icons.article_outlined, size: 32,),
          ),
          GestureDetector(
            onTap: (){
              _selectPage(2);
            },
            child: Icon(Icons.favorite_outline, size: 32),
          ),
          GestureDetector(
            onTap: (){
              _selectPage(3);
            },
            child: Icon(Icons.menu, size: 32),
          ),
        ],
      ),
    );
  }
}
