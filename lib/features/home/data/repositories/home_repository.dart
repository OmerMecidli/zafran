import 'package:zafran2/features/home/data/models/meal_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/category_model.dart';

class HomeRepository {
  final ApiClient apiClient;

  HomeRepository({required this.apiClient});

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiClient.dio.get(ApiConstants.categories);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['categories'];

        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Məlumatı yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw Exception('Xəta baş verdi: $e');
    }
  }

  Future<MealModel> getRandomMeal() async {
    try {
      final response = await apiClient.dio.get(ApiConstants.randomMeal);

      if (response.statusCode == 200) {
        return MealModel.fromJson(response.data);
      } else {
        throw Exception('Günün reseptini yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw Exception('Xəta baş verdi: $e');
    }
  }

  Future<List<MealModel>> getMealsByCategory(String categoryName) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.filterByCategory}$categoryName',
      );

      if (response.statusCode == 200) {
        final meals = response.data['meals'];

        if (meals == null) return [];

        return (meals as List).map((meal) {
          return MealModel(
            id: meal['idMeal'],
            title: meal['strMeal'],
            imageUrl: meal['strMealThumb'],
            category: categoryName,
            instructions: 'Hazırlanma qaydasını görmək üçün klikləyin.',
            ingredients: [],
          );
        }).toList();
      } else {
        throw Exception('Yeməkləri yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw Exception('Xəta baş verdi: $e');
    }
  }
}
