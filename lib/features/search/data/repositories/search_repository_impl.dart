import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../home/data/models/meal_model.dart';

import '../../domain/repositories/search_repository.dart';
import '../../../../core/error/exceptions.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ApiClient apiClient;

  SearchRepositoryImpl({required this.apiClient});

  @override
  Future<List<MealModel>> searchMeals(String query) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.searchByName}$query',
      );

      if (response.statusCode == 200) {
        final meals = response.data['meals'];

        if (meals == null) {
          return [];
        }

        return (meals as List).map((meal) {
          return MealModel.fromJson({
            'meals': [meal],
          });
        }).toList();
      } else {
        throw ServerException('Axtarış zamanı xəta baş verdi');
      }
    } catch (e) {
      throw ServerException('Xəta: $e');
    }
  }

  @override
  Future<List<MealModel>> searchMealsByIngredient(String query) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiConstants.filterByIngredient}$query',
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
            area: '',
            instructions: 'Hazırlanma qaydasını görmək üçün klikləyin.',
            ingredients: [],
            youtubeUrl: '',
          );
        }).toList();
      } else {
        throw ServerException('Axtarış zamanı xəta baş verdi');
      }
    } catch (e) {
      throw ServerException('Xəta: $e');
    }
  }
}
