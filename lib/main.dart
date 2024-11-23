import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:po_karmanu_project/models/constants.dart';
import 'package:po_karmanu_project/router/router.dart';
import 'package:po_karmanu_project/theme/theme.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ! comment
// * comment
// ? comment

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: Constants.supabaseUrl, anonKey: Constants.supabaseAnnonKey
  );

  runApp(
    GetMaterialApp(
      builder: InAppNotifications.init(),
      theme: app_theme,
      initialRoute: '/',
      getPages: pages,
    )
  );
}
