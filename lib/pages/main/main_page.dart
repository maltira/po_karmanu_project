import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:po_karmanu_project/pages/auth/registration_email.dart';

import '../onboarding/onboarding_page.dart';

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

    // return OnboardingPage();
    // в памяти сохраняем информацию о том, зарегистировался ли пользователь
    // если да, то кидаем на страницу с контентом
    // если нет, то на регистрацию
    return OnboardingPage();
    //return RegistrationPage();
  }
}