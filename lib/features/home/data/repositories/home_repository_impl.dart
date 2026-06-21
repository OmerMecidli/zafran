import 'package:zafran/features/home/data/models/meal_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/category_model.dart';

import '../../domain/repositories/home_repository.dart';
import '../../../../core/error/exceptions.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;

  HomeRepositoryImpl({required this.apiClient});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiClient.dio.get(ApiConstants.categories);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['categories'];

        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw ServerException('Məlumatı yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw ServerException('Xəta baş verdi: $e');
    }
  }

  @override
  Future<MealModel> getRandomMeal() async {
    try {
      final response = await apiClient.dio.get(ApiConstants.randomMeal);

      if (response.statusCode == 200) {
        return MealModel.fromJson(response.data);
      } else {
        throw ServerException('Günün reseptini yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw ServerException('Xəta baş verdi: $e');
    }
  }

  @override
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
            area: '',
            instructions: 'Hazırlanma qaydasını görmək üçün klikləyin.',
            ingredients: [],
            youtubeUrl: '',
          );
        }).toList();
      } else {
        throw ServerException('Yeməkləri yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw ServerException('Xəta baş verdi: $e');
    }
  }

  @override
  Future<List<String>> getAreas() async {
    // Return a curated list of popular areas to avoid empty categories and API overhead
    return [
      'Italian',
      'Mexican',
      'Turkish',
      'American',
      'French',
      'Japanese',
      'Chinese',
      'Indian',
      'Spanish',
      'Greek',
      'Thai',
      'Moroccan'
    ];
  }

  @override
  Future<List<MealModel>> getMealsByArea(String areaName) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.filterByArea}$areaName',
      );

      if (response.statusCode == 200) {
        final meals = response.data['meals'];
        if (meals == null) return [];

        return (meals as List).map((meal) {
          return MealModel(
            id: meal['idMeal'],
            title: meal['strMeal'],
            imageUrl: meal['strMealThumb'],
            category: '',
            area: areaName,
            instructions: 'Hazırlanma qaydasını görmək üçün klikləyin.',
            ingredients: [],
            youtubeUrl: '',
          );
        }).toList();
      } else {
        throw ServerException('Yeməkləri yükləmək mümkün olmadı');
      }
    } catch (e) {
      throw ServerException('Xəta baş verdi: $e');
    }
  }
}
