import 'package:flutter/material.dart';

class OnboardingOne extends StatefulWidget {
  OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> with SingleTickerProviderStateMixin{
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
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
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
        const SizedBox(height: 48),
        Stack(
            children: [
              Transform.translate(
                offset: Offset(-60, -25),
                child: SlideTransition(
                    position: _offsetAnimation,
                    child: Image.asset(
                      'assets/img/onboarding/Image1.png',
                      fit: BoxFit.cover,
                      width: 500,
                      height: 500,
                    ),
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
                    Opacity(
                      opacity: 0.4,
                      child: Text(
                        'Мы собрали всё в одном',

                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500

                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      'Питайся вкусно!',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 30
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Text(
                      'База рецептов, различные категории, '
                          'статьи и другое теперь в одном приложении',
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
