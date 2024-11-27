import 'package:flutter/material.dart';
import 'package:po_karmanu_project/pages/content_page/home/home_screen.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class ToggleScreenHome extends StatefulWidget {
  const ToggleScreenHome({super.key});


  @override
  State<ToggleScreenHome> createState() => _ToggleScreenHomeState();
}

class _ToggleScreenHomeState extends State<ToggleScreenHome> {
  var _activeScreen = 'main';
  double _opacityLevelMain = 1, _opacityLevelFeed = 0.3;

  void _setScreen(String page) {
    setState(() {
      _activeScreen = page;
      _opacityLevelFeed = page == 'feed' ? 1 : 0.3;
      _opacityLevelMain = page == 'main' ? 1 : 0.3;
    });
  }


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) =>[
          SliverAppBar(
            floating: true,
            centerTitle: true,
            expandedHeight: 96,
            shadowColor: ListOfColors.primaryBlack,
            backgroundColor: ListOfColors.primaryWhite,
            title: Column(
              children: [
                const SizedBox(height: 34,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_activeScreen != 'main') _setScreen('main');
                      },
                      child: AnimatedOpacity(
                        opacity: _opacityLevelMain,
                        duration: Duration(milliseconds: 100),
                        child: Text(
                            "Главная",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: ListOfColors.primaryBlack,
                                letterSpacing: 0.65,
                                fontSize: 26
                            )
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        if (_activeScreen != 'feed') _setScreen('feed');
                      },
                      child: AnimatedOpacity(
                        opacity: _opacityLevelFeed,
                        duration: Duration(milliseconds: 100),
                        child: Text(
                            "Лента",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: ListOfColors.primaryBlack,
                                letterSpacing: 0.65,
                                fontSize: 26
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
        body: HomeScreen(),
    );
  }
}
