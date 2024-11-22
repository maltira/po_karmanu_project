import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
import 'package:po_karmanu_project/database/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../theme/theme.dart';

class RegistrationPagePassword extends StatefulWidget {
  const RegistrationPagePassword({super.key});

  @override
  State<RegistrationPagePassword> createState() => _RegistrationPagePasswordState();
}

class _RegistrationPagePasswordState extends State<RegistrationPagePassword> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordControllerRepeat = TextEditingController();
  var _errorMessages = {'type': "", 'desc': ""};
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;
  var parameters = Get.parameters;
  final List<FocusNode> _focusNodes = [];
  final List<Color> _colors = [];
  bool _passHide = true;

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

  bool _isCorrectPassword(){
    bool firstCond = _passwordController.text.length < 8 || _passwordControllerRepeat.text.length < 8;
    bool secondCond = _passwordControllerRepeat.text.trim() != _passwordController.text.trim();
    if (firstCond) {
      setState(() {
        _errorMessages['type'] = "Слишком короткий пароль!";
        _errorMessages['desc'] = "Пароль должен содержать минимум 8 символов";
      });
      return false;
    }
    else if (secondCond) {
      setState(() {
        _errorMessages['type'] = "Пароли не совпадают!";
        _errorMessages['desc'] = "Проверьте правильность введённых паролей";
      });
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    _passwordControllerRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    print(parameters['from']);
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
                              // Назад
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 28),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _controller.duration = const Duration(milliseconds: 300);
                                      });
                                      _controller.reverse();
                                      Future.delayed(const Duration(milliseconds: 300), () => Get.offAndToNamed(parameters['from']!));
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.arrow_back_ios_new),
                                        const SizedBox(width: 12,),
                                        Text(
                                          'Назад',
                                          style: Theme.of(context).textTheme.displaySmall,
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              const SizedBox(height: 64,),
                              // ! Заголовок
                              Text(
                                'Последний шаг',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 32),
                              ),
                              const SizedBox(height: 8,),
                              Opacity(
                                opacity: 0.6,
                                child: Text(
                                  'Укажите надёжный пароль',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              const SizedBox(height: 48,),

                              // ! Поля ввода
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Пароль
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
                                          obscureText: true,
                                          focusNode: _focusNodes[0],
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock_open_outlined,
                                                  color: _colors[0]),
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

                                    // Повторить пароль
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 33, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5,color: _colors[1])
                                      ),
                                      child: TextField(
                                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                          controller: _passwordControllerRepeat,
                                          focusNode: _focusNodes[1],
                                          obscureText: _passHide,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock_open_outlined, color: _colors[1]),
                                              hintText: 'Повторите пароль',
                                              border: InputBorder.none,
                                              hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                  color: ListOfColors.primaryBlack.withOpacity(0.25)
                                              )
                                          ),
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontSize: 18,
                                              decorationThickness: 0
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 144,),
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
                                          onPressed: () async{
                                            if (_isCorrectPassword()) {
                                              final UserResponse res = await supabase.auth.updateUser(
                                                UserAttributes(
                                                    password: _passwordController.text
                                                )
                                              );
                                            }
                                            else {
                                              InAppNotifications.show(
                                                  title: _errorMessages['type'],
                                                  duration: Duration(seconds: 5),
                                                  leading: Icon(Icons.error_outline, size: 32, color: Colors.red,),
                                                  description: _errorMessages['desc']
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
                                            setState(() => _controller.duration = const Duration(milliseconds: 300));
                                            _controller.reverse();
                                            Future.delayed(const Duration(milliseconds: 300),
                                                    () => Get.offAndToNamed(parameters['from']!));
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStatePropertyAll(ListOfColors.primaryWhite),
                                            side: WidgetStatePropertyAll(BorderSide(width: 1.5, color: ListOfColors.primaryBlack)),
                                          ),
                                          child: Text(
                                            'Вернуться',
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
