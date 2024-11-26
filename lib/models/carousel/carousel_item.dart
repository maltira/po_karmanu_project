
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselItem extends StatelessWidget {
  CarouselItem({super.key, required this.title, required this.description, required this.imgHref});

  String title;
  String description;
  String imgHref;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(imgHref, fit: BoxFit.cover, width: 1000, height: 1000,),
              Positioned(
                bottom: 0,
                left: 0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 320),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                            description,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}