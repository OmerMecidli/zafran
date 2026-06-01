import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../home/data/models/meal_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetStorage box = GetStorage();

  FavoritesCubit() : super(FavoritesState(favoriteMeals: [])) {
    loadFavorites();
  }

  void loadFavorites() {
    List<dynamic>? storedFavorites = box.read<List<dynamic>>('favorites');
    if (storedFavorites != null) {
      final meals = storedFavorites.map((e) => MealModel.fromMap(e)).toList();
      emit(FavoritesState(favoriteMeals: meals));
    }
  }

  void toggleFavorite(MealModel meal) {
    final currentMeals = List<MealModel>.from(state.favoriteMeals);

    final index = currentMeals.indexWhere((m) => m.id == meal.id);

    if (index >= 0) {
      currentMeals.removeAt(index);
    } else {
      currentMeals.add(meal);
    }

    box.write('favorites', currentMeals.map((m) => m.toMap()).toList());

    emit(FavoritesState(favoriteMeals: currentMeals));
  }

  bool isFavorite(String id) {
    return state.favoriteMeals.any((m) => m.id == id);
  }
}
