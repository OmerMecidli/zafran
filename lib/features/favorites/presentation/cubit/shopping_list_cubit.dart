import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../home/data/models/meal_model.dart';

class ShoppingListState {
  final Map<String, bool> items;
  ShoppingListState({required this.items});
}

class ShoppingListCubit extends Cubit<ShoppingListState> {
  final GetStorage box = GetStorage();
  
  ShoppingListCubit() : super(ShoppingListState(items: {})) {
    loadList();
  }

  void loadList() {
    final Map<String, dynamic>? storedItems = box.read('shopping_list');
    if (storedItems != null) {
      emit(ShoppingListState(items: Map<String, bool>.from(storedItems)));
    }
  }

  void generateFromFavorites(List<MealModel> favorites) {
    final currentItems = Map<String, bool>.from(state.items);
    
    for (var meal in favorites) {
      for (var ingredient in meal.ingredients) {
        if (!currentItems.containsKey(ingredient)) {
          currentItems[ingredient] = false;
        }
      }
    }
    
    box.write('shopping_list', currentItems);
    emit(ShoppingListState(items: currentItems));
  }

  void toggleItem(String item) {
    final currentItems = Map<String, bool>.from(state.items);
    if (currentItems.containsKey(item)) {
      currentItems[item] = !currentItems[item]!;
      box.write('shopping_list', currentItems);
      emit(ShoppingListState(items: currentItems));
    }
  }

  void removeItem(String item) {
    final currentItems = Map<String, bool>.from(state.items);
    currentItems.remove(item);
    box.write('shopping_list', currentItems);
    emit(ShoppingListState(items: currentItems));
  }
  
  void clearList() {
    box.remove('shopping_list');
    emit(ShoppingListState(items: {}));
  }
}
