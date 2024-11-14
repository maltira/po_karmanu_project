import 'package:flutter/material.dart';

import '../../models/onboarding_slider.dart';

class OnboardingTwo extends StatefulWidget {
  const OnboardingTwo({super.key});

  @override
  State<OnboardingTwo> createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends State<OnboardingTwo> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _offsetTextAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.1), // Начальная позиция
      end: Offset.zero, // Конечная позиция (на месте)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );
    _offsetTextAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.05), // Начальная позиция
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
    return Column(
      children: [
        const SizedBox(height: 56),
        Stack(
            children: [
              Transform.translate(
                offset: Offset(0, -25),
                child: SlideTransition(
                    position: _offsetAnimation,
                    child: Image.asset(
                      'assets/img/onboarding/Image2.png',
                      fit: BoxFit.cover,
                      width: 500,
                      height: 500,
                    )
                ),
              )
            ]
        ),
        const Spacer(),
        SlideTransition(
          position: _offsetTextAnimation,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Хочется чего-то необычного...',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 30
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Text(
                      'Попробуй что-то новое или поделись '
                          'своим фирменным блюдом с другими пользователями!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 48,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}