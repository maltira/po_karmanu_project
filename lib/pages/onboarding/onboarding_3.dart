import 'package:flutter/material.dart';
import 'package:po_karmanu_project/models/carousel/image_carousel.dart';

class OnboardingThree extends StatefulWidget {
  OnboardingThree({super.key});

  @override
  State<OnboardingThree> createState() => _OnboardingThreeState();
}

class _OnboardingThreeState extends State<OnboardingThree> with SingleTickerProviderStateMixin{
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
        const Spacer(flex: 2,),
        SlideTransition(
            position: _offsetAnimation,
            child: CarouselWidget()
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
                      'Хочешь узнать больше о еде?',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 30
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Text(
                      'Читай статьи, пополняй свои кулинарные '
                          'знания или делись своим опытом с другими',
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
