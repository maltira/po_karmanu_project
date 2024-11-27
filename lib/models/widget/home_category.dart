import 'package:flutter/material.dart';
import 'package:po_karmanu_project/theme/theme.dart';

enum SizeOfContainer {
  small,
  big
}

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
    required this.format,
    required this.title,
    required this.description,
    required this.imageName
  });

  final title, description;
  final SizeOfContainer format;
  final String imageName;



  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry _padding = format == SizeOfContainer.big
        ? EdgeInsets.only(left: 24, right: 72)
        : EdgeInsets.symmetric(horizontal: 24);

    return InkWell(
      onTap: (){},
      child: Container(
        height: format == SizeOfContainer.big ? 144 : 144,
        width: format == SizeOfContainer.big ? double.infinity : 172,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  'assets/img/cards_bg/$imageName.png',
              )
          ),
          borderRadius: BorderRadius.circular(12)
        ),
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 20,
                  color: ListOfColors.primaryWhite,
                  letterSpacing: 0.6
                ),
            ),
            const SizedBox(height: 4,),
            Text(
              description,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 12,
                  color: ListOfColors.primaryWhite.withOpacity(0.6),
              ),
            )
          ],
        )
      ),
    );
  }
}
