import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zafran2/features/search/data/repositories/search_repository.dart';
import 'package:zafran2/features/search/presentation/cubit/search_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/network/api_client.dart'; 
import 'features/favorites/presentation/cubit/favorites_cubit.dart';
import 'features/home/data/repositories/home_repository.dart'; 
import 'features/home/presentation/cubit/home_cubit.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(
          create: (context) => HomeCubit(repository: HomeRepository(apiClient: ApiClient()))..fetchHomeData(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(repository: SearchRepository(apiClient: ApiClient())),
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