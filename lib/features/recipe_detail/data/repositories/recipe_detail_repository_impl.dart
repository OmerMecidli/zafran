import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../home/data/models/meal_model.dart';

import '../../domain/repositories/recipe_detail_repository.dart';
import '../../../../core/error/exceptions.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  final ApiClient apiClient;

  RecipeDetailRepositoryImpl({required this.apiClient});

  @override
  Future<MealModel> getMealDetails(String id) async {
    try {
      final response = await apiClient.dio.get('${ApiConstants.lookupById}$id');
      
      if (response.statusCode == 200 && response.data['meals'] != null) {
        return MealModel.fromJson(response.data);
      } else {
        throw ServerException('Resepti tapmaq mümkün olmadı');
      }
    } catch (e) {
      throw ServerException('Xəta baş verdi: $e');
    }
  }
}


