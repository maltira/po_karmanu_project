import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:po_karmanu_project/pages/auth/registration_email.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});



  @override
  Widget build(BuildContext context) {
    InAppNotifications.instance
      ..titleFontSize = 16.0
      ..descriptionFontSize = 15.0
      ..textColor = Colors.red
      ..shadow = false
      ..backgroundColor = Color(0xFFFFECEC);

    // Условия (какую страницу показывать)
    // return OnboardingPage();
    return RegistrationPage();
  }
}
