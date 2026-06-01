import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zafran2/features/home/data/models/category_model.dart';
import 'package:zafran2/features/home/data/models/meal_model.dart';
import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({required this.repository}) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        repository.getCategories(),
        repository.getRandomMeal(),
      ]);

      final categories = results[0] as List<CategoryModel>;
      final dailyMeal = results[1] as MealModel;

      emit(HomeLoaded(categories: categories, dailyMeal: dailyMeal));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
