import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class RecipeModel extends StatefulWidget {
  const RecipeModel({
    super.key,
    required this.category,
    required this.title,
    required this.time,
    required this.rate,
    required this.stat,
  });

  final String category;
  final String title;
  final rate;
  final Map<String, dynamic> stat;
  final int time;

  @override
  State<RecipeModel> createState() => _RecipeModelState();
}

class _RecipeModelState extends State<RecipeModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 32,
            color: ListOfColors.primaryBlack.withOpacity(0.1),
            offset: Offset(0, 0)
          )
        ]
      ),
      margin: EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 24),
          color: ListOfColors.primaryWhite,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://san-like.ru/image/cache/catalog/easyphoto/64992/rakovina-vstraivaemaya-ideal-standard-tempo-50x43-t059201-5-1200x800.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 148,
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Padding(
                          padding: EdgeInsets.only(left: 12, top: 12),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 6,
                                  sigmaY: 6
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: ListOfColors.primaryBlack.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.timer, color: ListOfColors.primaryOrange, size: 24,),
                                    const SizedBox(width: 8,),
                                    Text(
                                        "${widget.time} минут",
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                            fontSize: 14,
                                            color: ListOfColors.primaryWhite
                                        ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Padding(
                          padding: EdgeInsets.only(right: 12, top: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: InkWell(
                                onTap: (){},
                                child: Container(
                                  color: ListOfColors.primaryWhite.withOpacity(0.2),
                                  padding: EdgeInsets.all(7),
                                  child: Icon(
                                      Icons.favorite_outline, size: 24, color: ListOfColors.primaryWhite.withOpacity(0.8)
                                  )
                                ),
                              ),
                            ),
                          ),
                      ),
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.category,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 12,
                          color: ListOfColors.primaryBlack.withOpacity(0.6)
                        ),
                    ),
                    const SizedBox(height: 6,),
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlutterRating(
                          rating: widget.rate.toDouble(),
                          starCount: 5,
                          color: ListOfColors.primaryBlack,
                          borderColor: ListOfColors.primaryBlack.withOpacity(0.8),
                          size: 24,
                        ),
                        Text(
                          "КБЖУ: ${widget.stat['calories']} / ${widget.stat['protein']} / ${widget.stat['carbohydrates']} / ${widget.stat['fats']}",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 12,
                              color: ListOfColors.primaryBlack.withOpacity(0.6)
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
