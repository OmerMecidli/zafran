import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'category_meals_state.dart';

class CategoryMealsCubit extends Cubit<CategoryMealsState> {
  final HomeRepository repository;

  CategoryMealsCubit({required this.repository}) : super(CategoryMealsInitial());

  Future<void> fetchMealsByCategory(String categoryName) async {
    emit(CategoryMealsLoading());
    try {
      final meals = await repository.getMealsByCategory(categoryName);
      emit(CategoryMealsLoaded(meals: meals));
    } catch (e) {
      emit(CategoryMealsError(message: e.toString()));
    }
  }

  Future<void> fetchMealsByArea(String areaName) async {
    emit(CategoryMealsLoading());
    try {
      final meals = await repository.getMealsByArea(areaName);
      emit(CategoryMealsLoaded(meals: meals));
    } catch (e) {
      emit(CategoryMealsError(message: e.toString()));
    }
  }
}


