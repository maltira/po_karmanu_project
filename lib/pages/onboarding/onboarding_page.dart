import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:po_karmanu_project/models/onboarding_slider.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_1.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_2.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_3.dart';

import '../../theme/theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  Map<int, Widget> page = {
    0 : OnboardingOne(),
    1 : const OnboardingTwo(),
    2 : OnboardingThree()
  };

  @override
  Widget build(BuildContext context) {
    Color currentButtonColor = currentIndex == 0 ? ListOfColors.primaryBlack : Colors.transparent;
    String currentText = currentIndex == 0 ? 'Начать' : (currentIndex == 2 ? "Регистрация" : "Далее");
    return Scaffold(
      backgroundColor: ListOfColors.primaryWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  child: page[currentIndex]!
              )
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 64
              ),
              child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      if (currentIndex == 2) {
                        // переход
                        Get.offAllNamed('/reg');
                      } else {
                        currentIndex++;
                      }
                    });
                  },
                  icon: Icon(Icons.arrow_forward_outlined, size: 20, color: currentIndex == 0 ? ListOfColors.primaryWhite : ListOfColors.primaryBlack,),
                  iconAlignment: IconAlignment.end,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(currentButtonColor),
                    side: WidgetStatePropertyAll(
                        BorderSide(
                            width: currentIndex == 0 ? 0 : 1.5,
                            color: currentIndex == 0 ? Colors.transparent : ListOfColors.primaryBlack,
                        )
                    )
                  ),
                  label: Text(
                      currentText,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: currentIndex == 0 ? ListOfColors.primaryWhite : ListOfColors.primaryBlack,
                        fontWeight: FontWeight.w600
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
