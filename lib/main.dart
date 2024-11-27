import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:po_karmanu_project/models/constants.dart';
import 'package:po_karmanu_project/router/router.dart';
import 'package:po_karmanu_project/theme/theme.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'database/supabase.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: Constants.supabaseUrl, anonKey: Constants.supabaseAnnonKey
  );
  await requestRecipeData();

  runApp(
    GetMaterialApp(
      builder: InAppNotifications.init(),
      theme: app_theme,
      initialRoute: '/mainhome',
      getPages: pages,
    )
  );
}
