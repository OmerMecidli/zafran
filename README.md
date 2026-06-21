# Zafran Recipe App 🍳

**Zafran** is a modern and elegant recipe application built with Flutter. It allows users to explore world cuisines, discover new recipes, search by ingredients, and manage their cooking process efficiently with dedicated cooking modes and shopping lists.

## 🚀 Features

- **World Cuisine Exploration:** Browse meals categorized by origin (Italian, Turkish, Mexican, etc.) and category (Beef, Chicken, Dessert).
- **Ingredient Search:** Find recipes by typing a specific ingredient (e.g., 'chicken').
- **Smart Shopping List:** Add ingredients from your favorite meals into a unified shopping list with a checklist feature. Easily select which favorite recipes you want to shop for today.
- **Immersive Cooking Mode:** A distraction-free, full-screen step-by-step cooking guide with a progress bar to help you follow instructions easily while in the kitchen.
- **Favorites & Local Storage:** Save recipes to your favorites and manage your shopping list offline using `GetStorage`.
- **YouTube Integration:** Watch recipe tutorials directly on the YouTube app with a single click.
- **Beautiful UI:** A sleek, minimal design with custom themes, smooth animations, and optimized safe areas for all devices.

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** [Flutter BLoC / Cubit](https://pub.dev/packages/flutter_bloc)
- **Routing:** [GoRouter](https://pub.dev/packages/go_router) with ShellRoute for nested navigation.
- **Local Storage:** [GetStorage](https://pub.dev/packages/get_storage) for fast, synchronous key-value storage.
- **Dependency Injection:** [GetIt](https://pub.dev/packages/get_it)
- **Networking:** [Dio](https://pub.dev/packages/dio)
- **Animations:** [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **API Integration:** Powered by [TheMealDB API](https://www.themealdb.com/).

## 📥 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/zafran.git
   cd zafran
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

## 🏗 Architecture & Folder Structure

The project follows a clean, feature-based architecture pattern:
- `lib/core/` - Contains app-wide themes, networking (Dio client), routing, and generic widgets.
- `lib/features/` - Divided by domains (`home`, `search`, `favorites`, `recipe_detail`), each containing its own `data`, `domain`, and `presentation` layers.

## ✨ Recent Updates

- **Cooking Mode:** Added a full-screen instruction reader.
- **Shopping List Generator:** Consolidated favorite ingredients into an interactive checklist.
- UI Layout optimizations and overflow fixes.

---
*Developed with ❤️ using Flutter.*
