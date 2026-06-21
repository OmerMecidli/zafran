import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zafran/features/home/presentation/widgets/daily_recipe_card.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/category_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salam,',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 32),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
              Text(
                'nə bişirmək istəyirsiniz?',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.2),
              const SizedBox(height: 24),

              const CustomSearchBar().animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.2),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Populyar Kateqoriyalar',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/all-categories');
                    },
                    child: Text(
                      'Hamısına bax',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
              const SizedBox(height: 16),

              SizedBox(
                height: 120,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is HomeLoaded) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: List.generate(state.categories.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index == state.categories.length - 1 ? 0 : 16.0),
                              child: CategoryItem(
                                category: state.categories[index],
                              ).animate().fadeIn(delay: (300 + 50 * index).ms).slideX(begin: 0.2),
                            );
                          }),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              const SizedBox(height: 32),
              
              Text(
                'Dünya Mətbəxi',
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(duration: 400.ms, delay: 350.ms),
              const SizedBox(height: 16),
              
              SizedBox(
                height: 40,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: List.generate(state.areas.length, (index) {
                            final area = state.areas[index];
                            return Padding(
                              padding: EdgeInsets.only(right: index == state.areas.length - 1 ? 0 : 12.0),
                              child: ActionChip(
                                label: Text(area),
                                onPressed: () {
                                  context.push('/area/$area');
                                },
                                backgroundColor: Theme.of(context).colorScheme.surface,
                                side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: 0.3)),
                                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ).animate().fadeIn(delay: (350 + 30 * index).ms).slideX(begin: 0.2),
                            );
                          }),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              const SizedBox(height: 40),
              Text(
                'Günün Resepti',
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
              const SizedBox(height: 16),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return DailyRecipeCard(meal: state.dailyMeal)
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 500.ms)
                        .scaleXY(begin: 0.95);
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

