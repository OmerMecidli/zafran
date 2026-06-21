import 'package:zafran/features/home/data/models/meal_model.dart';

import '../../data/models/category_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final List<String> areas;
  final MealModel dailyMeal;

  HomeLoaded({required this.categories, required this.areas, required this.dailyMeal});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

