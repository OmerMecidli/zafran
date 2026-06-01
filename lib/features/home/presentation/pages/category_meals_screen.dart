import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../cubit/category_meals_cubit.dart';
import '../cubit/category_meals_state.dart';

class CategoryMealsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryMealsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: BlocBuilder<CategoryMealsCubit, CategoryMealsState>(
        builder: (context, state) {
          if (state is CategoryMealsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryMealsError) {
            return Center(child: Text(state.message));
          } else if (state is CategoryMealsLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: state.meals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final meal = state.meals[index];
                return GestureDetector(
                  onTap: () => context.push('/recipe/${meal.id}'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: meal.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            meal.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
