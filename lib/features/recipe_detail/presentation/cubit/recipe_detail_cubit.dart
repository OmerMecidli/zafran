import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/recipe_detail_repository.dart';
import 'recipe_detail_state.dart';

class RecipeDetailCubit extends Cubit<RecipeDetailState> {
  final RecipeDetailRepository repository;

  RecipeDetailCubit({required this.repository}) : super(RecipeDetailInitial());

  Future<void> fetchMealDetails(String id) async {
    emit(RecipeDetailLoading());
    try {
      final meal = await repository.getMealDetails(id);
      emit(RecipeDetailLoaded(meal: meal));
    } catch (e) {
      emit(RecipeDetailError(message: e.toString()));
    }
  }
}


