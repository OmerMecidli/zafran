# 🍳 Zafran

A modern, high-performance, and pixel-perfect Recipe Application built with Flutter. The project fetches dynamic culinary data from **TheMealDB API** and showcases industry-standard architectural patterns, clean state management, and fluid user experiences.

---

## 🚀 Key Features

* **Dynamic Home Feed:** Displays a curated "Meal of the Day" alongside a horizontally scrollable categories list, smoothly built with decoupled API states.
* **Smart Search System:** Real-time recipe search with seamless state cleaning (`TextEditingController` integrated with Cubit logic).
* **Persistent Favorites Layer:** Users can bookmark recipes. Data is securely cached in local storage using `GetStorage`, remaining intact even after app restarts.
* **Advanced Detail Views:** Implements high-fidelity UI animations with `SliverAppBar`, dynamic ingredient listings, and step-by-step cooking instructions.
* **Adaptive Bottom Navigation:** Implements complex nested navigation where the bottom bar persists across core tabs but elegantly hides on detail pages.

---

## 🛠 Tech Stack & Architecture

This project follows **Feature-First Layered Architecture** (Data, Domain/Model, Presentation) to maximize maintainability and scalability.

* **State Management:** `Flutter BLoC (Cubit)` — chosen for predictable, reactive, and unidirectional data flow.
* **Routing:** `GoRouter` — utilizing advanced `ShellRoute` configurations for sophisticated tab switching and clean deep-linking.
* **Networking:** `Dio` — wrapped inside a centralized `ApiClient` for clean HTTP client handling and interceptor flexibility.
* **Local Caching:** `GetStorage` — lightweight, fast key-value storage for offline favorites tracking.
* **Image Caching:** `CachedNetworkImage` — optimizes image memory consumption and handles smooth loading/error states.

---

## 📁 Folder Structure

```text
lib/
│
├── core/                  # Core utilities shared across features
│   ├── constants/         # API endpoints and design tokens
│   ├── network/           # Central HTTP/Dio client
│   ├── routing/           # GoRouter & ShellRoute configuration
│   └── theme/             # Material 3 typography and design system
│
└── features/              # Feature-driven modules
    ├── home/              # Data sources, Cubits, and widgets for Feed
    ├── recipe_detail/     # Dynamic detail screens and Slivers
    ├── favorites/         # Local caching layer and persistent UI
    └── search/            # Search engine cubits and interactive views