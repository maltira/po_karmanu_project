import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
import 'package:po_karmanu_project/database/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../theme/theme.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;
  final List<FocusNode> _focusNodes = [];
  final List<Color> _colors = [];

  @override
  void initState() {

    // Фокус поля
    for (int i = 0; i < 2; i++) {
      _focusNodes.add(FocusNode());
      _colors.add(ListOfColors.primaryBlack.withOpacity(0.25)); // Начальный цвет
    }
    for (int i = 0; i < 2; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          if (_focusNodes[i].hasFocus) {
            _colors[i] = const Color(0xff7489F3); // Цвет при фокусе

          } else {
            _colors[i] = ListOfColors.primaryBlack.withOpacity(0.25); // Цвет без фокуса
          }
        });
      });
    }

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _offsetAnimationFirstImage = Tween<Offset>(
      begin: const Offset(1, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetAnimationSecondImage = Tween<Offset>(
      begin: const Offset(-1, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetTextAnimation = Tween<Offset>(
      begin: const Offset(0.0, -5), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListOfColors.primaryWhite,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Indexer(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Indexed(
                  index: 1,
                  child: SingleChildScrollView(
                    child: SlideTransition(
                      position: _offsetTextAnimation,
                      child: Padding(
                        padding: EdgeInsets.only(top: 90, bottom: 48),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              // ! Заголовок
                              Text(
                                'Регистрация',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                      fontSize: 32,
                                    ),
                              ),
                              const SizedBox(height: 8,),
                              Opacity(
                                opacity: 0.6,
                                child: Text(
                                  'Создайте новый аккаунт',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              const SizedBox(height: 48,),

                              // ! Поля ввода
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Имя
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: ListOfColors.primaryWhite,
                                          border: Border.all(width: 1.5, color: _colors[0])),
                                      child: TextField(
                                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.person,
                                              color: _colors[0],
                                            ),
                                            hintText: 'Ваше имя',
                                            border: InputBorder.none,
                                            hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                color: const Color(0xff01d1b19).withOpacity(0.25))
                                        ),
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                          fontSize: 18,
                                          decorationThickness: 0
                                        ),
                                        focusNode: _focusNodes[0],
                                        controller: _nameController,
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    // Email
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[1])),
                                      child: TextField(
                                          onEditingComplete: (){
                                            FocusScope.of(context).nextFocus();
                                          },
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.email_outlined, color: _colors[1]),
                                              hintText: 'Укажите почту',
                                              border: InputBorder.none,
                                              hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                  color: ListOfColors.primaryBlack.withOpacity(0.25))),
                                          focusNode: _focusNodes[1],
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontSize: 18,
                                              decorationThickness: 0
                                          ),
                                          controller: _emailController,

                                      ),
                                    ),
                                    const SizedBox(height: 48,),

                                    // Соц сети
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/img/auth/google.png',
                                          width: 78,
                                          height: 78,
                                        ),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Image.asset(
                                          'assets/img/auth/vk.png',
                                          width: 78,
                                          height: 78,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 96,),

                              // ! Войти
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: double.infinity,
                                          minHeight: 64),
                                      child: TextButton(
                                          onPressed: ()async{
                                            if (_emailController.text.contains('@')) { // проверка
                                              final response = await SignUpOptResponse(_emailController.text, '********');
                                              setState(() {
                                                _controller.duration = const Duration(milliseconds: 300);
                                              });
                                              _controller.reverse();
                                              Future.delayed(const Duration(milliseconds: 300), () => Get.toNamed('/code', parameters: {'from': '/reg', 'name': _nameController.text, 'email': _emailController.text}));
                                            }
                                            else {
                                              InAppNotifications.show(
                                                title: "Неверный формат почты",
                                                duration: Duration(seconds: 5),
                                                leading: Icon(Icons.error_outline, size: 32, color: Colors.red,),
                                                description: "Убедитесь в правильности ввода и повторите попытку регистрации"
                                              );
                                            }
                                          },
                                          style: TextButtonTheme.of(context).style,
                                          child: Text(
                                            'Регистрация',
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ListOfColors.primaryWhite,
                                              letterSpacing: 0.5,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(height: 12,),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 64),
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _controller.duration = const Duration(milliseconds: 300);
                                              _controller.reverse();
                                              Future.delayed(
                                                  const Duration(milliseconds: 300),
                                                  () => Get.offAndToNamed('/auth'));
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStatePropertyAll(ListOfColors.primaryWhite),
                                            side: WidgetStatePropertyAll(BorderSide(width: 1.5, color: ListOfColors.primaryBlack)),
                                          ),
                                          child: Text(
                                            'У меня есть аккаунт',
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Фотки на фоне
              Indexed(
                index: 0,
                child: Opacity(
                  opacity: 0.7,
                  child: Stack(
                    children: [
                      SlideTransition(
                        position: _offsetAnimationFirstImage,
                        child: Transform.translate(
                          offset: const Offset(50, 80),
                          child: Transform.rotate(
                            angle: -3,
                            child: SizedBox(
                              width: 500,
                              height: 500,
                              child: Image.asset(
                                'assets/img/auth/image1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _offsetAnimationSecondImage,
                        child: Transform.translate(
                          offset: const Offset(-40, 240),
                          child: Transform.rotate(
                            angle: 0.35,
                            child: SizedBox(
                              width: 500,
                              height: 500,
                              child: Image.asset(
                                'assets/img/auth/image1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
