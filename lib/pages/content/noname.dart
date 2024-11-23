import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoNamePage extends StatelessWidget {
  NoNamePage({super.key});
  final parameters = Get.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Приветствую,\n${parameters['name']}'),
      ),
    );
  }
}
