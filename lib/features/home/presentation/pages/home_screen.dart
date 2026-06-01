import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zafran2/features/home/presentation/widgets/daily_recipe_card.dart';
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
                "Salam,",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 32),
              ),
              Text(
                "nə bişirmək istəyirsiniz?",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              const CustomSearchBar(),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Populyar Kateqoriyalar",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/all-categories');
                    },
                    child: Text(
                      "Hamısına bax",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
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
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        clipBehavior: Clip.none,
                        separatorBuilder: (_, _) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return CategoryItem(
                            category: state.categories[index],
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              const SizedBox(height: 40),
              Text(
                "Günün Resepti",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return DailyRecipeCard(meal: state.dailyMeal);
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
