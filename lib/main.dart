import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:po_karmanu_project/router/router.dart';
import 'package:po_karmanu_project/theme/theme.dart';
import 'pages/main/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      GetMaterialApp(
        theme: app_theme,
        initialRoute: '/',
        getPages: pages,
      )
  );
}
