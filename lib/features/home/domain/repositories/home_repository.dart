import '../../data/models/category_model.dart';
import '../../data/models/meal_model.dart';

abstract class HomeRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<String>> getAreas();
  Future<MealModel> getRandomMeal();
  Future<List<MealModel>> getMealsByCategory(String categoryName);
  Future<List<MealModel>> getMealsByArea(String areaName);
}

