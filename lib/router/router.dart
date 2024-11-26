import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:po_karmanu_project/pages/auth/authorization.dart';
import 'package:po_karmanu_project/pages/auth/email_code.dart';
import 'package:po_karmanu_project/pages/auth/registration_email.dart';
import 'package:po_karmanu_project/pages/auth/registration_pass.dart';
import 'package:po_karmanu_project/pages/main/main_page.dart';

import '../pages/content_page/noname.dart';
class Routes {
  static String main = "/";
  static String auth = "/auth";
  static String reg = "/reg";
  static String regpass = "/regpass";
  static String code = "/code";
  static String noname = "/noname";
}

final pages = [
  GetPage(
    name: Routes.main,
    page: () => MainPage(),
  ),
  GetPage(
      name: Routes.auth,
      page: () => AuthorizationPage(),
      transition: Transition.downToUp,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 300)),
  GetPage(
      name: Routes.reg,
      page: () => RegistrationPage(),
      transition: Transition.upToDown,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 300)),
  GetPage(
      name: Routes.regpass,
      page: () => RegistrationPagePassword(),
      transition: Transition.upToDown,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 300)),
  GetPage(
      name: Routes.code,
      page: () => EmailCode(),
      transition: Transition.downToUp,
      curve: Curves.easeOutCirc,
      transitionDuration: Duration(milliseconds: 300)),
  GetPage(
      name: Routes.noname,
      page: () => NoNamePage()
  ),
];