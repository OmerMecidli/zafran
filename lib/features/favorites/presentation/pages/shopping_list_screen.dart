import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zafran/core/theme/app_theme.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/shopping_list_cubit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Alış-veriş Siyahısı'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Favoritlərdən yenilə',
            onPressed: () {
              final favorites = context.read<FavoritesCubit>().state.favoriteMeals;
              if (favorites.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Favoritlərdə yemək yoxdur!')),
                );
                return;
              }

              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (BuildContext ctx) {
                  final List<dynamic> selectedMeals = List.from(favorites);

                  return StatefulBuilder(
                    builder: (context, setModalState) {
                      return SafeArea(
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hansı yeməklərin ərzaqları əlavə edilsin?',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: favorites.length,
                                  itemBuilder: (context, index) {
                                    final meal = favorites[index];
                                    final isSelected = selectedMeals.contains(meal);
                                    return CheckboxListTile(
                                      value: isSelected,
                                      title: Text(meal.title),
                                      onChanged: (val) {
                                        setModalState(() {
                                          if (val == true) {
                                            selectedMeals.add(meal);
                                          } else {
                                            selectedMeals.remove(meal);
                                          }
                                        });
                                      },
                                      activeColor: AppTheme.primaryColor,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: selectedMeals.isEmpty ? null : () {
                                    context.read<ShoppingListCubit>().generateFromFavorites(selectedMeals.cast());
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Siyahı yeniləndi!')),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryColor,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Siyahını Yarat',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Siyahını təmizlə',
            onPressed: () {
              context.read<ShoppingListCubit>().clearList();
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: BlocBuilder<ShoppingListCubit, ShoppingListState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Siyahı boşdur',
                      style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Yenilə düyməsinə basaraq favoritlərdəki ərzaqları bura əlavə edə bilərsiniz.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ).animate().fadeIn(),
              );
            }

            final itemsList = state.items.entries.toList();

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: itemsList.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = itemsList[index];
                final itemName = entry.key;
                final isChecked = entry.value;

                return Container(
                  decoration: BoxDecoration(
                    color: isChecked ? AppTheme.surfaceContainer : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isChecked ? AppTheme.primaryColor.withValues(alpha: 0.3) : Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CheckboxListTile(
                    value: isChecked,
                    onChanged: (val) {
                      context.read<ShoppingListCubit>().toggleItem(itemName);
                    },
                    title: Text(
                      itemName,
                      style: TextStyle(
                        decoration: isChecked ? TextDecoration.lineThrough : null,
                        color: isChecked ? Colors.grey : AppTheme.onSurface,
                        fontWeight: isChecked ? FontWeight.normal : FontWeight.w500,
                      ),
                    ),
                    activeColor: AppTheme.primaryColor,
                    checkColor: Colors.white,
                    secondary: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                      onPressed: () {
                        context.read<ShoppingListCubit>().removeItem(itemName);
                      },
                    ),
                  ),
                ).animate().fadeIn(delay: (30 * index).ms).slideX(begin: 0.1);
              },
            );
          },
        ),
      ),
    );
  }
}
