import '../../../home/data/models/meal_model.dart';

abstract class SearchRepository {
  Future<List<MealModel>> searchMeals(String query);
  Future<List<MealModel>> searchMealsByIngredient(String query);
}


