import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> with SingleTickerProviderStateMixin{
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
      begin: const Offset(0.5, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetAnimationSecondImage = Tween<Offset>(
      begin: const Offset(-0.5, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetTextAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1), // Начальная позиция
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
                child: Padding(
                  padding: EdgeInsets.only(top: 148, bottom: keyboardSpace),
                  child: Indexed(
                    index: 1,
                    child: SlideTransition(
                      position: _offsetTextAnimation,
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            // Заголовок
                            const Spacer(flex: 4,),
                            Text(
                              'Авторизация',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(height: 8,),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 42
                              ),
                              child: Opacity(
                                opacity: 0.6,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Войти в существующий аккаунт',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48,),

                            // Поля ввода
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 28),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

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

                                  // Забыли пароль?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: (){},
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: Text(
                                              'Забыли пароль?',
                                              style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                          Future.delayed(const Duration(milliseconds: 300), () => Get.toNamed('/code', parameters: {'from': '/auth'}));
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
                            const SizedBox(height: 24,),

                            // Нет аккаунта?
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Opacity(
                                  opacity: 0.6,
                                  child: Text(
                                    'Нет аккаунта?',
                                    style: Theme.of(context).textTheme.displaySmall,
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _controller.duration = const Duration(milliseconds: 300);
                                      _controller.reverse();
                                      Future.delayed(const Duration(milliseconds: 300), () =>  Get.offAndToNamed('/reg'));
                                    });
                                  },
                                  child: Text(
                                    'Регистрация',
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
                          offset: const Offset(400, 450),
                          child: Transform.rotate(
                            angle: 1,
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
                          offset: const Offset(-40, -120),
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
