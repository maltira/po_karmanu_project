import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
import 'package:po_karmanu_project/database/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/waiting_page/wait_indicator.dart';
import '../../theme/theme.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _emailController = TextEditingController(), _passController = TextEditingController();
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;
  final List<FocusNode> _focusNodes = [];
  final List<Color> _colors = [];
  bool _waiting = false;


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
      begin: const Offset(0.0, 5), // Начальная позиция
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
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListOfColors.primaryWhite,
      body: Stack(
        children: [
          Indexer(
            children: [
              if (_waiting)
                Indexed(index: 2, child: WaitingIndicator()),

              Indexed(
                index: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: SlideTransition(
                      position: _offsetTextAnimation,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 48),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              // ! Заголовок
                              Text(
                                'Авторизация',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      fontSize: 32,
                                    ),
                              ),
                              const SizedBox(height: 8,),
                              ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 42),
                                child: Opacity(
                                  opacity: 0.6,
                                  child: SizedBox(
                                    width: 240,
                                    child: Text(
                                      'Войти в существующий аккаунт',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 48,),

                              // ! Поля ввода
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ! Email
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[0])),
                                      child: TextField(
                                          onEditingComplete: (){
                                            FocusScope.of(context).nextFocus();
                                          },
                                          focusNode: _focusNodes[0],
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.email_outlined, color: _colors[0]),
                                              hintText: 'Укажите почту',
                                              border: InputBorder.none,
                                              hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                      color: ListOfColors.primaryBlack.withOpacity(0.25))),
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontSize: 18,
                                              decorationThickness: 0
                                          ),
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    // ! Пароль
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[1])),
                                      child: TextField(
                                          onEditingComplete: (){
                                            FocusScope.of(context).nextFocus();
                                          },
                                          obscureText: true,
                                          focusNode: _focusNodes[1],
                                          controller: _passController,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock_open_outlined, color: _colors[1]),
                                              hintText: 'Укажите пароль',
                                              border: InputBorder.none,
                                              hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: ListOfColors.primaryBlack.withOpacity(0.25))),
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontSize: 18,
                                              decorationThickness: 0
                                          ),
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    // ! Забыли пароль?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
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

                                    // ! Соц сети
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

                              // !  Войти
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: double.infinity,
                                          minHeight: 64),
                                      child: TextButton(
                                          onPressed: () async{
                                            setState(() {
                                              _waiting = true;
                                            });
                                            await SignInWithEmail(_emailController.text.trim(), _passController.text.trim()).then(
                                                (value) async {
                                                  setState(() {
                                                    _waiting = false;
                                                  });
                                                  if (value == true) {
                                                    setState(() {
                                                      _controller.duration = const Duration(milliseconds: 300);
                                                    });
                                                    _controller.reverse();
                                                    final userId = supabase.auth.currentUser!.id;
                                                    final parameters = await supabase.from('users').select('*').eq('id', userId).single();
                                                    final mapParameters = parameters.map((key, value) => MapEntry(key, value as String));

                                                    Future.delayed(Duration(milliseconds: 300), () => Get.toNamed('noname', parameters: mapParameters));
                                                  }
                                                  else InAppNotifications.show(
                                                      title: "Неудачная попытка авторизации",
                                                      duration: Duration(seconds: 5),
                                                      leading: Icon(Icons.error_outline, size: 32, color: Colors.red,),
                                                      description: "Убедитесь в правильности ввода данных и повторите попытку авторизации"
                                                  );
                                                }
                                            );
                                          },
                                          style: TextButtonTheme.of(context).style,
                                          child: Text(
                                            'Войти',
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
                                                      () => Get.offAndToNamed('/reg'));
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStatePropertyAll(ListOfColors.primaryWhite),
                                            side: WidgetStatePropertyAll(BorderSide(width: 1.5, color: ListOfColors.primaryBlack)),
                                          ),
                                          child: Text(
                                            'Создать аккаунт',
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ! Фотки на фоне
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
