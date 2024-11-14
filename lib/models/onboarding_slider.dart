import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key, required this.currIndex});

  final currIndex;

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  var currentIndex;

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.currIndex;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 8,
          width: currentIndex == 0 ? 14 : 8,
          decoration: BoxDecoration(
            color: currentIndex == 0 ? Color(0xff1D1B19) : Color(0xff1D1B19).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)
          ),
        ),
        const SizedBox(width: 8,),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 8,
          width: currentIndex == 1 ? 14 : 8,
          decoration: BoxDecoration(
              color: currentIndex == 1 ? Color(0xff1D1B19) : Color(0xff1D1B19).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)
          ),
        ),
        const SizedBox(width: 8,),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 8,
          width: currentIndex == 2 ? 14 : 8,
          decoration: BoxDecoration(
              color: currentIndex == 2 ? Color(0xff1D1B19) : Color(0xff1D1B19).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)
          ),
        )
      ],
    );
  }
}
