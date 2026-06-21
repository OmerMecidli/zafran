import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/category_meals_cubit.dart';
import '../cubit/category_meals_state.dart';
import '../../../../core/widgets/meal_list_card.dart';

class CategoryMealsScreen extends StatelessWidget {
  final String title;

  const CategoryMealsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: BlocBuilder<CategoryMealsCubit, CategoryMealsState>(
        builder: (context, state) {
          if (state is CategoryMealsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryMealsError) {
            return Center(child: Text(state.message));
          } else if (state is CategoryMealsLoaded) {
            return SafeArea(
              bottom: true,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                itemCount: state.meals.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final meal = state.meals[index];
                  return MealListCard(
                    meal: meal,
                    showCategory: false,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

