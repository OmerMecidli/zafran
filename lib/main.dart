import 'package:zafran/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zafran/features/search/domain/repositories/search_repository.dart';
import 'package:zafran/features/search/presentation/cubit/search_cubit.dart';
import 'core/routing/app_router.dart';

import 'features/favorites/presentation/cubit/favorites_cubit.dart';
import 'features/favorites/presentation/cubit/shopping_list_cubit.dart';
import 'features/home/domain/repositories/home_repository.dart'; 
import 'features/home/presentation/cubit/home_cubit.dart'; 
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupServiceLocator();
  
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => ShoppingListCubit()),
        BlocProvider(
          create: (context) => HomeCubit(repository: getIt<HomeRepository>())..fetchHomeData(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(repository: getIt<SearchRepository>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Recipe App',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}