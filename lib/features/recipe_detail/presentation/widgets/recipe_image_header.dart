import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/meal_model.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../../favorites/presentation/cubit/favorites_state.dart';

class RecipeImageHeader extends StatelessWidget {
  final MealModel meal;

  const RecipeImageHeader({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350.0,
      pinned: true,
      backgroundColor: Theme.of(context).primaryColor,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: .9),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: .9),

            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFav = context.read<FavoritesCubit>().isFavorite(
                  meal.id,
                );

                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xFF9F402D),
                  ),
                  onPressed: () {
                    context.read<FavoritesCubit>().toggleFavorite(meal);

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFav
                              ? "Favoritlərdən silindi"
                              : "Favoritlərə əlavə edildi",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: meal.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
