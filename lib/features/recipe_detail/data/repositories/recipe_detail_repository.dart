import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../home/data/models/meal_model.dart';

class RecipeDetailRepository {
  final ApiClient apiClient;

  RecipeDetailRepository({required this.apiClient});

  Future<MealModel> getMealDetails(String id) async {
    try {
      final response = await apiClient.dio.get('${ApiConstants.lookupById}$id');
      
      if (response.statusCode == 200 && response.data['meals'] != null) {
        return MealModel.fromJson(response.data);
      } else {
        throw Exception('Resepti tapmaq mümkün olmadı');
      }
    } catch (e) {
      throw Exception('Xəta baş verdi: $e');
    }
  }
}