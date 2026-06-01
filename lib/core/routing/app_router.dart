import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zafran2/features/home/data/repositories/home_repository.dart';
import 'package:zafran2/features/home/presentation/cubit/category_meals_cubit.dart';
import 'package:zafran2/features/home/presentation/pages/all_categories_screen.dart';
import 'package:zafran2/features/home/presentation/pages/category_meals_screen.dart';
import 'package:zafran2/features/search/presentation/pages/search_screen.dart';

import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/recipe_detail/data/repositories/recipe_detail_repository.dart';
import '../../features/recipe_detail/presentation/cubit/recipe_detail_cubit.dart';
import '../../features/recipe_detail/presentation/pages/recipe_detail_screen.dart';
import '../../features/favorites/presentation/pages/favorites_screen.dart';
import '../network/api_client.dart';
import 'main_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeScreen();
          },
        ),

        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),

        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
      ],
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/recipe/:id',
      builder: (context, state) {
        final recipeId = state.pathParameters['id']!;
        return BlocProvider(
          create: (context) => RecipeDetailCubit(
            repository: RecipeDetailRepository(apiClient: ApiClient()),
          )..fetchMealDetails(recipeId),
          child: const RecipeDetailScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/all-categories',
      builder: (context, state) => const AllCategoriesScreen(),
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/category/:name',
      builder: (context, state) {
        final categoryName = state.pathParameters['name']!;
        return BlocProvider(
          create: (context) => CategoryMealsCubit(
            repository: HomeRepository(apiClient: ApiClient()),
          )..fetchMealsByCategory(categoryName),
          child: CategoryMealsScreen(categoryName: categoryName),
        );
      },
    ),
  ],
);
