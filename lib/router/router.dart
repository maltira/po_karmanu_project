import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:po_karmanu_project/pages/auth/authorization.dart';
import 'package:po_karmanu_project/pages/auth/email_code.dart';
import 'package:po_karmanu_project/pages/auth/registration.dart';
import 'package:po_karmanu_project/pages/main/main_page.dart';

class Routes {
  static String main = "/";
  static String auth = "/auth";
  static String reg = "/reg";
  static String code = "/code";
}

final pages = [
  GetPage(
      name: Routes.main,
      page: () => MainPage() // go to page
  ),
  GetPage(
      name: Routes.auth,
      page: () => AuthorizationPage(),
      transition: Transition.downToUp,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 350)
  ),
  GetPage(
      name: Routes.reg,
      page: () => RegistrationPage(),
      transition: Transition.upToDown,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 350)
  ),
  GetPage(
      name: Routes.code,
      page: () => EmailCode(),
      transition: Transition.downToUp,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 350)
  )
];