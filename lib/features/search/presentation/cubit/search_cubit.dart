import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  SearchCubit({required this.repository}) : super(SearchInitial());

  Future<void> searchMeals(String query, {bool isIngredientSearch = false}) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final meals = isIngredientSearch
          ? await repository.searchMealsByIngredient(query)
          : await repository.searchMeals(query);
      emit(SearchLoaded(meals: meals));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}


