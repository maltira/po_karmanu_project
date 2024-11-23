import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
import 'package:po_karmanu_project/database/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/waiting_page/wait_indicator.dart';
import '../../theme/theme.dart';

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});


  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends State<ForgotPassword> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;
  final List<FocusNode> _focusNodes = [];
  final List<Color> _colors = [];
  bool _waiting = false;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _nameController = TextEditingController();
  }

  Future<bool> _PasswordEmail() async{
    try {
      await SignUpOptResponse(_emailController.text, '********');
      return true;
    }
    catch (e) {
      print(e);
      return false;
    }
  }

  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Восстановление пароля",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Введите email, на который будет отправлен код для восстановления пароля.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 32),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 32),
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 64),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () async{
                setState(() {
                  _controller.duration = const Duration(milliseconds: 300);
                  _waiting = true;
                });
                await _PasswordEmail().then((bool value) {
                  setState(() {
                    _waiting = false;
                  });
                  if (value && _nameController.text.length > 0) {
                    _controller.reverse();
                    Future.delayed(const Duration(milliseconds: 300), () => Get.toNamed('/code', parameters: {'from': '/reg', 'name': _nameController.text, 'email': _emailController.text}));
                  }
                  else {
                    InAppNotifications.show(
                        title: "Неудачная попытка",
                        duration: Duration(seconds: 5),
                        leading: Icon(Icons.error_outline, size: 32, color: Colors.red,),
                        description: "Убедитесь в правильности ввода данных и повторите попытку"
                    );
                  }
                });

              },
              child: Center(
                child: Text(
                  "Отправить код",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        )],
        ),
      ),
    );
  }
}
