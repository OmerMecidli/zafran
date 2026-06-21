import '../../data/models/meal_model.dart';

abstract class CategoryMealsState {}

class CategoryMealsInitial extends CategoryMealsState {}
class CategoryMealsLoading extends CategoryMealsState {}
class CategoryMealsLoaded extends CategoryMealsState {
  final List<MealModel> meals;
  CategoryMealsLoaded({required this.meals});
}
class CategoryMealsError extends CategoryMealsState {
  final String message;
  CategoryMealsError({required this.message});
}

