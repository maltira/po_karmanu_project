import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class NoNamePage extends StatelessWidget {
  NoNamePage({super.key});
  final parameters = Get.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Привет, ${parameters['username']}'),
      ),
    );
  }
}