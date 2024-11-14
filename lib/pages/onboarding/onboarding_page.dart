import 'package:flutter/material.dart';
import 'package:po_karmanu_project/models/onboarding_slider.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_1.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_2.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_3.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  Map<int, Widget> page = {
    0 : OnboardingOne(),
    1 : OnboardingTwo(),
    2 : OnboardingThree()
  };

  @override
  Widget build(BuildContext context) {
    Color currentButtonColor = currentIndex == 0 ? Color(0xff01D1B19) : Colors.transparent;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: page[currentIndex]!
              )
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 64
              ),
              child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      if (currentIndex == 2)
                        currentIndex = 0;
                      else currentIndex++;
                    });
                  },
                  icon: Icon(Icons.arrow_forward_outlined, size: 20, color: currentIndex == 0 ? Colors.white : Color(0xff01D1B19),),
                  iconAlignment: IconAlignment.end,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(currentButtonColor),
                    side: WidgetStatePropertyAll(
                        BorderSide(
                            width: currentIndex == 0 ? 0 : 1.5,
                            color: currentIndex == 0 ? Colors.transparent : Color(0xff01D1B19),
                        )
                    )
                  ),
                  label: Text(
                      currentIndex == 0 ? 'Начать' : 'Далее',
                      style: TextStyle(
                          color: currentIndex == 0 ? Colors.white : Color(0xff01D1B19),
                      )
                  )
              ),
            ),
          ),
          const SizedBox(height: 20),
          SliderPage(currIndex: currentIndex),
          const SizedBox(height: 36,)
        ],
      ),
    );
  }
}
