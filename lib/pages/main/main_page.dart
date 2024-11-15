import 'package:flutter/material.dart';
import 'package:po_karmanu_project/pages/auth/registration.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Условия (какую страницу показывать)
    // return OnboardingPage();
    return RegistrationPage();
  }
}
