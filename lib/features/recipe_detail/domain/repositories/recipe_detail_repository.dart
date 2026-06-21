import '../../../home/data/models/meal_model.dart';

abstract class RecipeDetailRepository {
  Future<MealModel> getMealDetails(String id);
}


