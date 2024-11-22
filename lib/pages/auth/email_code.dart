import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../database/supabase.dart';
import '../../theme/theme.dart';

class EmailCode extends StatefulWidget {
  const EmailCode({super.key});

  @override
  State<EmailCode> createState() => _EmailCodeState();
}

class _EmailCodeState extends State<EmailCode> with SingleTickerProviderStateMixin{
  final List<FocusNode> _focusNodes = [];
  final List<Color> _colors = [];
  var parameters = Get.parameters;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimationFirstImage;
  late Animation<Offset> _offsetAnimationSecondImage;
  late Animation<Offset> _offsetTextAnimation;
  int seconds = 30;
  Timer? _timer;
  List<String> code = ['0','0','0','0','0','0'];
  bool OTPvalid = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        if (seconds > 0) seconds--;
        else _timer?.cancel();
      });
    });
  }

  @override
  void initState() {
    _startTimer();

    // Фокус поля
    for (int i = 0; i < 6; i++) {
      _focusNodes.add(FocusNode());
      _colors.add(ListOfColors.primaryBlack.withOpacity(0.25)); // Начальный цвет
    }
    for (int i = 0; i < 6; i++) {
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
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
    // Анимация загрузки экрана
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
    _timer?.cancel();
    for (int i = 0; i < 4; i++) {
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(code);
    return Scaffold(
      backgroundColor: ListOfColors.primaryWhite,
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
                      const Spacer(flex: 4,),

                      // Назад
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 28),
                        child: GestureDetector(
                          onTap: () {
                            setState(() async{
                              Supabase.instance.client.auth.refreshSession();
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

                      // Заголовок
                      const SizedBox(height: 70,),
                      Text(
                        'Подтверждение',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Opacity(
                        opacity: 0.6,
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            'Укажите код, отправленный на почту ${parameters['email']}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      const SizedBox(height: 64,),

                      // Поле ввода
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Код
                            Form(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ListOfColors.primaryBlack.withOpacity(0.03),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(width: 1.5, color: _colors[0])
                                      ),
                                      child: TextFormField(
                                        onChanged: (value){
                                          if (value.length == 1) {
                                            FocusScope.of(context).nextFocus();
                                            setState(() {
                                              code[0] = value;
                                            });
                                          }
                                          else {
                                            FocusScope.of(context).previousFocus();
                                            code[0] = '0';
                                          };
                                        },
                                        focusNode: _focusNodes[0],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: code[0],
                                          hintStyle: TextStyle(
                                              color: ListOfColors.primaryBlack.withOpacity(0.25)
                                          ),
                                          focusColor: ListOfColors.primaryBlack
                                        ),
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryBlack.withOpacity(0.03),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[1])
                                      ),
                                      child: TextFormField(
                                        onChanged: (value){
                                          if (value.length == 1) {
                                            FocusScope.of(context).nextFocus();
                                            setState(() {
                                              code[1] = value;
                                            });
                                          }
                                          else {
                                            FocusScope.of(context).previousFocus();
                                            code[1] = '0';
                                          };
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        focusNode: _focusNodes[1],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: code[1],
                                            hintStyle: TextStyle(
                                                color: ListOfColors.primaryBlack.withOpacity(0.25)
                                            ),
                                            focusColor: ListOfColors.primaryBlack
                                        ),
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryBlack.withOpacity(0.03),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[2])
                                      ),
                                      child: TextFormField(
                                        onChanged: (value){
                                          if (value.length == 1) {
                                            FocusScope.of(context).nextFocus();
                                            setState(() {
                                              code[2] = value;
                                            });
                                          }
                                          else {
                                            FocusScope.of(context).previousFocus();
                                            code[2] = '0';
                                          };
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        focusNode: _focusNodes[2],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: code[2],
                                            hintStyle: TextStyle(
                                                color: ListOfColors.primaryBlack.withOpacity(0.25)
                                            ),
                                            focusColor: ListOfColors.primaryBlack
                                        ),
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryBlack.withOpacity(0.03),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[3])
                                      ),
                                      child: TextFormField(
                                        onChanged: (value){
                                          if (value.length == 1) {
                                            FocusScope.of(context).nextFocus();
                                            setState(() {
                                              code[3] = value;
                                            });
                                          }
                                          else {
                                            FocusScope.of(context).previousFocus();
                                            code[3] = '0';
                                          };
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        focusNode: _focusNodes[3],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: code[3],
                                            hintStyle: TextStyle(
                                                color: ListOfColors.primaryBlack.withOpacity(0.25)
                                            ),
                                            focusColor: ListOfColors.primaryBlack
                                        ),
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryBlack.withOpacity(0.03),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[4])
                                      ),
                                      child: TextFormField(
                                        onChanged: (value){
                                          if (value.length == 1) {
                                            FocusScope.of(context).nextFocus();
                                            setState(() {
                                              code[4] = value;
                                            });
                                          }
                                          else {
                                            FocusScope.of(context).previousFocus();
                                            code[4] = '0';
                                          };
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        focusNode: _focusNodes[4],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: code[4],
                                            hintStyle: TextStyle(
                                                color: ListOfColors.primaryBlack.withOpacity(0.25)
                                            ),
                                            focusColor: ListOfColors.primaryBlack
                                        ),
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ListOfColors.primaryBlack.withOpacity(0.03),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(width: 1.5, color: _colors[5])
                                      ),
                                      child: TextFormField(
                                        onChanged: (value)async{
                                          if (value.length == 1) {
                                            setState(() {
                                              code[5] = value;
                                            });
                                            String fullCode = code[0]+code[1]+code[2]+code[3]+code[4]+code[5];
                                            if (code.length == 6) {
                                              OTPvalid = await ConfirmOtpCode(parameters['email']!, fullCode);
                                              if (parameters['from'] != '/auth' && OTPvalid) {
                                                setState(() {
                                                  _controller.duration = const Duration(milliseconds: 300);
                                                });
                                                _controller.reverse();
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300),
                                                        () =>
                                                        Get.toNamed('/regpass',
                                                            parameters: {
                                                              'from': parameters['from']!,
                                                              'name': parameters['name']!,
                                                              'email': parameters['email']!
                                                            }));
                                              }
                                              else InAppNotifications.show(
                                                  title: "Неверный OTP код",
                                                  duration: Duration(seconds: 5),
                                                  leading: Icon(Icons.error_outline, size: 32, color: Colors.red,),
                                                  description: "Убедитесь в правильности кода подтверждения и повторите попытку"
                                              );
                                              FocusScope.of(context).nextFocus();
                                            }
                                            FocusScope.of(context).previousFocus();
                                          }
                                          else FocusScope.of(context).previousFocus();
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        focusNode: _focusNodes[5],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: code[5],
                                            hintStyle: TextStyle(
                                              color: ListOfColors.primaryBlack.withOpacity(0.25)
                                            ),
                                            focusColor: ListOfColors.primaryBlack
                                        ),
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            const SizedBox(height: 64,),
                            // Войти
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity,
                                  minHeight: 64
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    if (parameters['from'] != '/auth' && OTPvalid) {
                                      setState(() {
                                        _controller.duration =
                                        const Duration(milliseconds: 300);
                                      });
                                      _controller.reverse();
                                      Future.delayed(
                                          const Duration(milliseconds: 300),
                                              () =>
                                              Get.toNamed('/regpass',
                                                  parameters: {
                                                    'from': parameters['from']!,
                                                    'name': parameters['name']!,
                                                    'email': parameters['email']!
                                                  }));
                                    }
                                    else InAppNotifications.show(
                                        title: "Неверный OTP код",
                                        duration: Duration(seconds: 5),
                                        leading: Icon(Icons.error_outline, size: 32, color: Colors.red,),
                                        description: "Убедитесь в правильности кода подтверждения и повторите попытку"
                                    );
                                  },
                                  style: TextButtonTheme.of(context).style,
                                  child: Text(
                                    'Войти',
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        color: ListOfColors.primaryWhite,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64,),

                      // Не пришёл код?
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Text(
                              'Не пришёл код?',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          const SizedBox(width: 6,),
                          GestureDetector(
                            onTap: ()async {
                              await supabase.auth.resend(
                                type: OtpType.signup,
                                email: parameters['email']!,
                              );
                              if (seconds == 0) {
                                setState(() {
                                  seconds = 30;
                                });
                                _startTimer();
                              }
                            },
                            child: Text(
                              seconds == 0 ? 'Отправить' : '${seconds}с',
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: ListOfColors.primaryGreen,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(flex: 3,)
                    ],
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
