import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
    _offsetAnimationFirstImage = Tween<Offset>(
      begin: const Offset(0.4, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetAnimationSecondImage = Tween<Offset>(
      begin: const Offset(-0.4, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetTextAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1), // Начальная позиция
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Indexer(
            children: [
              SingleChildScrollView(
                child: Indexed(
                    index: 1,
                    child: SlideTransition(
                      position: _offsetTextAnimation,
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.only(top: 90, bottom: keyboardSpace),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              // Заголовок
                              const Spacer(flex: 4,),
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
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              const SizedBox(height: 48,),

                              // Поля ввода
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    // Имя
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                        border: Border.all(color: const Color(0xff01d1b19))
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.email_outlined, color: const Color(0xff01d1b19).withOpacity(0.5),),
                                            hintText: 'Ваше имя',
                                            border: InputBorder.none,
                                            hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              color: const Color(0xff01d1b19).withOpacity(0.5)
                                            )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    // Email
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: const Color(0xff01d1b19))
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.email_outlined, color: const Color(0xff01d1b19).withOpacity(0.5)),
                                          hintText: 'Укажите почту',
                                          border: InputBorder.none,
                                          hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              color: const Color(0xff01d1b19).withOpacity(0.5)
                                          )
                                        ),
                                        style: Theme.of(context).textTheme.displaySmall
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    // Пароль
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: const Color(0xff01d1b19))
                                      ),
                                      child: TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.lock_open_outlined, color: const Color(0xff01d1b19).withOpacity(0.5)),
                                            hintText: 'Укажите пароль',
                                            border: InputBorder.none,
                                            hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                color: const Color(0xff01d1b19).withOpacity(0.5)
                                            )
                                        ),
                                        style: Theme.of(context).textTheme.displaySmall
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    // Повторный пароль
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: const Color(0xff01d1b19))
                                      ),
                                      child: TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.lock_open_outlined, color: const Color(0xff01d1b19).withOpacity(0.5)),
                                            hintText: 'Повторите пароль',
                                            border: InputBorder.none,

                                            hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                color: const Color(0xff01d1b19).withOpacity(0.5)
                                            )
                                        ),
                                        style: Theme.of(context).textTheme.displaySmall
                                      ),
                                    ),
                                    const SizedBox(height: 48,),

                                    // Войти
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: double.infinity,
                                          minHeight: 64
                                      ),
                                      child: TextButton(
                                          onPressed: (){
                                            _controller.duration = const Duration(milliseconds: 300);
                                            _controller.reverse();
                                            Future.delayed(const Duration(milliseconds: 300), () => Get.toNamed('/code', parameters: {'from': '/reg'}));
                                          },
                                          style: TextButtonTheme.of(context).style,
                                          child: Text(
                                            'Войти',
                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Есть аккаунт?
                              const SizedBox(height: 24,),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Opacity(
                                    opacity: 0.6,
                                    child: Text(
                                      'Есть аккаунт?',
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                  const SizedBox(width: 6,),
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        _controller.duration = const Duration(milliseconds: 300);
                                        _controller.reverse();
                                        Future.delayed(const Duration(milliseconds: 300), () => Get.offAndToNamed('/auth'));
                                      });
                                    },
                                    child: Text(
                                      'Авторизация',
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        color: const Color(0xff669D4F),
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 48,),

                              // Соц сети
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/img/auth/google.png', width: 78, height: 78,),
                                  const SizedBox(width: 24,),
                                  Image.asset('assets/img/auth/vk.png', width: 78, height: 78,),
                                ],
                              ),
                              const Spacer(flex: 3,)
                            ],
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
