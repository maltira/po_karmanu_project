import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/img/onboarding/Image1.png'),
          TextButton.icon(
              onPressed: (){},
              icon: Icon(Icons.arrow_forward_outlined),
              label: Text(
                  'Начать'
              )
          )
        ],
      ),
    );
  }
}
