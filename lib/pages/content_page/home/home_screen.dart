import 'package:flutter/material.dart';
import 'package:po_karmanu_project/database/supabase.dart';
import 'package:po_karmanu_project/models/widget/buttons/ai_button.dart';
import 'package:po_karmanu_project/models/widget/buttons/search_button.dart';
import 'package:po_karmanu_project/models/widget/home_category.dart';
import 'package:po_karmanu_project/models/widget/recipe_model.dart';
import 'package:po_karmanu_project/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final recipes = getRecipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListOfColors.primaryWhite,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          margin: EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              SearchButton(),
              const SizedBox(height: 36,),
              AIButton(),
              const SizedBox(height: 24,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'Категории',
                            style: Theme.of(context).textTheme.headlineMedium!,
                        ),
                        const SizedBox(width: 8,),
                        Icon(Icons.arrow_forward_ios_rounded, size: 18, color: ListOfColors.primaryBlack,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  HomeCategory(
                      format: SizeOfContainer.big,
                      title: 'Осенние блюда',
                      description: 'Подборка рецептов, чтобы спастить от тоскливой осенней погоды...',
                      imageName: 'one',
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCategory(
                          format: SizeOfContainer.small,
                          title: "Подборка дня",
                          description: 'Что сегодня едят чаще всего?',
                          imageName: 'two',
                      ),
                      HomeCategory(
                          format: SizeOfContainer.small,
                          title: "Топ недели",
                          description: 'Эти блюда завоюют ваше доверие!',
                          imageName: "three",
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Популярные рецепты',
                    style: Theme.of(context).textTheme.headlineMedium!,
                  ),
                  const SizedBox(height: 12,),
                  for (var index = 0; index < recipes.length; index++)
                    RecipeModel(
                        category: recipes[index]['category'],
                        title: recipes[index]['title'],
                        time: recipes[index]['cooking_time'],
                        rate: recipes[index]['rate'],
                        stat: {
                          'calories': recipes[index]['calories'],
                          'protein': recipes[index]['protein'],
                          'carbohydrates': recipes[index]['carbohydrates'],
                          'fats': recipes[index]['fats'],
                        }
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
