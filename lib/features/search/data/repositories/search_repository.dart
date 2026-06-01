import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../home/data/models/meal_model.dart';

class SearchRepository {
  final ApiClient apiClient;

  SearchRepository({required this.apiClient});

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
        throw Exception('Axtarış zamanı xəta baş verdi');
      }
    } catch (e) {
      throw Exception('Xəta: $e');
    }
  }
}
