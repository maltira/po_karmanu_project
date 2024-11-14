import 'package:get/get.dart';
import 'package:po_karmanu_project/pages/main/main_page.dart';
import 'package:po_karmanu_project/pages/onboarding/onboarding_3.dart';

class Routes {
  static String page1 = "/";
}

final pages = [
  GetPage(
      name: Routes.page1,
      page: () => MainPage() // go to page
  ),
];