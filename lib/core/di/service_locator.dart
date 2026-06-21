import 'package:get_it/get_it.dart';
import 'package:zafran/core/network/api_client.dart';
import 'package:zafran/features/home/domain/repositories/home_repository.dart';
import 'package:zafran/features/home/data/repositories/home_repository_impl.dart';
import 'package:zafran/features/search/domain/repositories/search_repository.dart';
import 'package:zafran/features/search/data/repositories/search_repository_impl.dart';
import 'package:zafran/features/recipe_detail/domain/repositories/recipe_detail_repository.dart';
import 'package:zafran/features/recipe_detail/data/repositories/recipe_detail_repository_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiClient: getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(apiClient: getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<RecipeDetailRepository>(
    () => RecipeDetailRepositoryImpl(apiClient: getIt<ApiClient>()),
  );
}


