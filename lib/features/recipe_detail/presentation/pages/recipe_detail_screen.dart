import 'package:zafran/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe_detail_cubit.dart';
import '../cubit/recipe_detail_state.dart';
import '../widgets/recipe_image_header.dart';
import '../widgets/ingredient_item.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<RecipeDetailCubit, RecipeDetailState>(
        builder: (context, state) {
          if (state is RecipeDetailLoading || state is RecipeDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecipeDetailError) {
            return Center(child: Text(state.message));
          } else if (state is RecipeDetailLoaded) {
            final meal = state.meal;

            return CustomScrollView(
              slivers: [
                RecipeImageHeader(meal: meal),

                SliverToBoxAdapter(
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -24.0, 0.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                meal.category,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (meal.area.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  meal.area,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                        const SizedBox(height: 16),

                        Text(
                          meal.title,
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge?.copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            if (meal.time.isNotEmpty) ...[
                              Icon(
                                Icons.schedule,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                meal.time,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(width: 24),
                            ],
                            if (meal.difficulty.isNotEmpty) ...[
                              Icon(
                                Icons.restaurant_menu,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                meal.difficulty,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                SharePlus.instance.share(ShareParams(text: 'Möhtəşəm resept: ${meal.title}\nBax: ${meal.youtubeUrl.isNotEmpty ? meal.youtubeUrl : 'Zafran tətbiqində!'}'));
                              },
                              icon: const Icon(Icons.share),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                        const SizedBox(height: 32),

                        Text(
                          'İnqrediyentlər',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),

                        ...meal.ingredients.asMap().entries.map(
                              (entry) => IngredientItem(ingredient: entry.value)
                                  .animate()
                                  .fadeIn(delay: (500 + entry.key * 50).ms)
                                  .slideX(begin: 0.1),
                            ),

                        const SizedBox(height: 32),

                        Text(
                          'Hazırlanma Qaydası',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          meal.instructions,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                height: 1.6,
                                color: AppTheme.onSurface,
                              ),
                        ).animate().fadeIn(delay: 800.ms),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.push('/cooking-mode', extra: meal);
                            },
                            icon: const Icon(Icons.fullscreen, color: Colors.white),
                            label: const Text('Tam Ekran Bişirmə Rejimi', style: TextStyle(color: Colors.white, fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ).animate().fadeIn(delay: 850.ms).scaleXY(begin: 0.9),
                        if (meal.youtubeUrl.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final url = Uri.parse(meal.youtubeUrl);
                                try {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Videonu açmaq mümkün olmadı')),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                              label: const Text('Videonu İzlə (Youtube)', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ).animate().fadeIn(delay: 900.ms).scaleXY(begin: 0.9),
                        ],
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
