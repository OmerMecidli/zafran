import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe_detail_cubit.dart';
import '../cubit/recipe_detail_state.dart';
import '../widgets/recipe_image_header.dart';
import '../widgets/ingredient_item.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<RecipeDetailCubit, RecipeDetailState>(
        builder: (context, state) {
          if (state is RecipeDetailLoading || state is RecipeDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecipeDetailError) {
            return Center(child: Text(state.message));
          } else if (state is RecipeDetailLoaded) {
            final meal = state.meal;

            return CustomScrollView(
              slivers: [
                RecipeImageHeader(meal: meal),

                SliverToBoxAdapter(
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -24.0, 0.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5ECE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            meal.category,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          meal.title,
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge?.copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              meal.time,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 24),
                            Icon(
                              Icons.restaurant_menu,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              meal.difficulty,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        Text(
                          "İnqrediyentlər",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),

                        ...meal.ingredients.map(
                          (ingredient) =>
                              IngredientItem(ingredient: ingredient),
                        ),

                        const SizedBox(height: 32),

                        Text(
                          "Hazırlanma Qaydası",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          meal.instructions,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                height: 1.6,
                                color: const Color(0xFF1E1B18),
                              ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
