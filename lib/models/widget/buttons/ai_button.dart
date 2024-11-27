import 'package:flutter/material.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class AIButton extends StatelessWidget {
  const AIButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2.5, color: ListOfColors.primaryOrange),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/icons/ai_icon.png', color: ListOfColors.primaryOrange,),
            const SizedBox(width: 8,),
            Text(
              'ИИ-помощник',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: ListOfColors.primaryOrange,
                fontSize: 18,
                fontWeight: FontWeight.w900
              ),
            )
          ],
        ),
      ),
    );
  }
}
