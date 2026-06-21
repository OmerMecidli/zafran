import 'package:flutter/material.dart';
import 'package:zafran/core/theme/app_theme.dart';
import 'package:zafran/features/home/data/models/meal_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CookingModeScreen extends StatefulWidget {
  final MealModel meal;

  const CookingModeScreen({super.key, required this.meal});

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  late PageController _pageController;
  late List<String> _steps;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _steps = widget.meal.instructions
        .split(RegExp(r'\r\n|\r|\n'))
        .where((step) => step.trim().isNotEmpty && step.length > 3)
        .toList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_steps.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Bişirmə Rejimi')),
        body: const Center(child: Text('Təlimatlar tapılmadı.')),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.onSurface, // Dark background for cooking mode
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.meal.title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _steps.length,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              minHeight: 6,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Addım ${index + 1}/${_steps.length}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
                        const SizedBox(height: 40),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                _steps[index].trim(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  height: 1.5,
                                ),
                              ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.9, 0.9)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'prev',
                    onPressed: _currentIndex > 0 ? _previousPage : null,
                    backgroundColor: _currentIndex > 0
                        ? AppTheme.surfaceContainer
                        : Colors.grey.withValues(alpha: 0.2),
                    elevation: 0,
                    child: Icon(Icons.arrow_back,
                        color: _currentIndex > 0 ? AppTheme.onSurface : Colors.grey),
                  ),
                  if (_currentIndex == _steps.length - 1)
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Bitir', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ).animate().scale(delay: 200.ms)
                  else
                    FloatingActionButton(
                      heroTag: 'next',
                      onPressed: _nextPage,
                      backgroundColor: AppTheme.primaryColor,
                      elevation: 0,
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
