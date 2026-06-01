import '../../../home/data/models/meal_model.dart';

abstract class RecipeDetailState {}

class RecipeDetailInitial extends RecipeDetailState {}
class RecipeDetailLoading extends RecipeDetailState {}
class RecipeDetailLoaded extends RecipeDetailState {
  final MealModel meal;
  RecipeDetailLoaded({required this.meal});
}
class RecipeDetailError extends RecipeDetailState {
  final String message;
  RecipeDetailError({required this.message});
}