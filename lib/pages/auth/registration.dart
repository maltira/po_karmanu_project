import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with SingleTickerProviderStateMixin{
  bool isAuthorization = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    );
    _offsetAnimationFirstImage = Tween<Offset>(
      begin: Offset(0.2, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetAnimationSecondImage = Tween<Offset>(
      begin: Offset(-0.2, 0), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _offsetTextAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.1), // Начальная позиция
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Indexer(
            children: [
              Indexed(
                  index: 1,
                  child: SlideTransition(
                    position: _offsetTextAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 3,),
                        Text(
                          isAuthorization ? 'Авторизация' : 'Регистрация',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Opacity(
                          opacity: 0.6,
                          child: Text(
                            isAuthorization ? 'Войдите в аккаунт' : 'Создайте новый аккаунт',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email_outlined),
                                  hintText: 'Укажите почту',
                                  border: InputBorder.none,
                                  hintStyle: Theme.of(context).textTheme.displaySmall
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    icon: Icon(Icons.lock_open_outlined),
                                    hintText: 'Пароль',
                                    border: InputBorder.none,
                                    hintStyle: Theme.of(context).textTheme.displaySmall
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    icon: Icon(Icons.lock_open_outlined),
                                    hintText: 'Повторите пароль',
                                    border: InputBorder.none,
                                    hintStyle: Theme.of(context).textTheme.displaySmall
                                ),
                              ),

                              const SizedBox(height: 36,),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: double.infinity,
                                    minHeight: 64
                                ),
                                child: TextButton(
                                    onPressed: (){},
                                    style: TextButtonTheme.of(context).style,
                                    child: Text(
                                      isAuthorization ? "Войти" : 'Регистрация',
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Opacity(
                              opacity: 0.6,
                              child: Text(
                                isAuthorization ? "Нет аккаунта?" : 'Есть аккаунт?',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            const SizedBox(width: 6,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isAuthorization = !isAuthorization;
                                });
                              },
                              child: Text(
                                isAuthorization ? 'Регистрация' : 'Авторизация',
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: const Color(0xff669D4F),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 36,),
                        Opacity(
                          opacity: 0.4,
                          child: Text(
                            'или',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(height: 36,),
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
              Indexed(
                  index: 0,
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
              )
            ],
          )
        ],
      ),
    );
  }
}
