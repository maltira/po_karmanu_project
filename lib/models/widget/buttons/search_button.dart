import 'package:flutter/material.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: double.infinity,
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
            color: ListOfColors.primaryBlack.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Opacity(
          opacity: 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Поиск',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 18,
                )
              ),
              Icon(
                Icons.search,
                color: ListOfColors.primaryBlack.withOpacity(0.8),
                size: 30,
              )
            ],
          ),
        ),
      ),
    );;
  }
}
