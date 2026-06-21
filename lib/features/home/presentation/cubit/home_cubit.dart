import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zafran/features/home/data/models/category_model.dart';
import 'package:zafran/features/home/data/models/meal_model.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({required this.repository}) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        repository.getCategories(),
        repository.getAreas(),
        repository.getRandomMeal(),
      ]);

      final categories = results[0] as List<CategoryModel>;
      final areas = results[1] as List<String>;
      final dailyMeal = results[2] as MealModel;

      emit(HomeLoaded(categories: categories, areas: areas, dailyMeal: dailyMeal));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}


