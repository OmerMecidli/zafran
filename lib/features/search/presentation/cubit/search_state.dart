import '../../../home/data/models/meal_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {} 
class SearchLoading extends SearchState {} 
class SearchLoaded extends SearchState {
  final List<MealModel> meals;
  SearchLoaded({required this.meals});
}
class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}

