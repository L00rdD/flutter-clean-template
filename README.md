# 🧱 Project Name

Short description of the project and its purpose.
Include high-level context, stakeholders, and primary objectives.

---

## 🧩 Architecture Overview

This project follows **Clean Architecture (Uncle Bob’s principles)**, structured for **testability, modularity, and maintainability**.

### 🧠 Philosophy

* **Domain-centric design**: the domain layer is independent and pure Dart.
* **Dependency inversion**: outer layers depend on abstractions, not the other way around.
* **Feature-based modularity**: each feature contains its own use cases, blocs, and entities.
* **Test-Driven Development (TDD)**: each layer is independently testable.

---

## 🧬 Directory Structure

```
lib/
├── data/                 → External data layer (I/O, APIs, persistence)
│   ├── datasources/      → Defines how data is fetched (REST, DB, local cache)
│   ├── models/           → External models / DTOs
│   ├── repositories/     → Implements domain repository contracts
│   ├── services/         → Optional helpers (network, cache, crypto, etc.)
│   ├── strategies/       → Algorithms or runtime behaviors
│   └── factories/        → Data layer factory patterns
│
├── domain/               → Core business logic (pure Dart)
│   ├── entities/         → Business entities (immutable)
│   │   ├── failure.dart  → Domain-level failure types
│   │   └── exception.dart → Domain-specific exceptions
│   ├── repositories/     → Abstract interfaces (contracts)
│   ├── usecases/         → Application logic (feature-based)
│   │   └── example/
│   │       └── get_example.dart
│   ├── strategies/       → Decision-making or policy logic
│   └── factories/        → Creation patterns for domain objects
│
├── presentation/         → UI and state management layer
│   ├── bloc/             → Business Logic Components (BLoC per feature)
│   │   └── example/
│   │       ├── example_bloc.dart
│   │       ├── example_event.dart
│   │       └── example_state.dart
│   ├── pages/            → Screens / Views
│   ├── widgets/          → Shared reusable UI components
│   ├── strategies/       → Presentation logic strategies
│   └── factories/        → Widget creation patterns
│
├── dependency_injection/
│   └── injector.dart     → Centralized dependency registry (GetIt)
│
├── app.dart              → Root widget / MaterialApp configuration
└── main.dart             → Application entry point
```

---

## 🧠 Clean Architecture Layers

| Layer            | Responsibility                           | Knows About                        |
| ---------------- | ---------------------------------------- | ---------------------------------- |
| **Presentation** | UI, BLoCs, user interaction              | Domain layer (via UseCases)        |
| **Domain**       | Business logic, entities, rules          | Nothing (pure Dart)                |
| **Data**         | I/O, API, persistence, external adapters | Domain (via repository interfaces) |

---

## 🥱 Core Principles

1. **Dependency Rule**
   Inner layers must not depend on outer ones.

2. **Communication Flow**
   Presentation → Domain → Data → External systems

3. **Entities are Pure**
   No imports from Flutter, only Dart core.

4. **Use Cases Define Behavior**
   Each use case describes one atomic business action.

5. **Repositories Abstract Data**
   Domain defines *what* data it needs,
   Data layer defines *how* it’s provided.

---

## ⚙️ Dependency Injection

All dependencies are declared and initialized in `dependency_injection/injector.dart` using **GetIt**:

```dart
final injector = GetIt.instance;

Future<void> initDependencies() async {
  // Example:
  // injector.registerLazySingleton<ExampleRepository>(
  //   () => ExampleRepositoryImpl(remoteDataSource: injector()),
  // );
}
```

This ensures clear separation between wiring and logic, and simplifies testing.

For **large-scale projects**, it is recommended to split dependency initialization into multiple files — one per **feature or domain module**.
This improves maintainability and readability, as each feature can manage its own injection scope independently.

Example structure:

```
dependency_injection/
├── injector.dart                   → Global entrypoint (calls all initializers)
├── core_injector.dart               → Shared / global dependencies
├── feature_a_injector.dart          → Registers Feature A repositories, usecases, blocs
├── feature_b_injector.dart          → Registers Feature B dependencies
└── ...
```

Example usage:

```dart
Future<void> initDependencies() async {
  await initCoreDependencies();
  await initFeatureADependencies();
  await initFeatureBDependencies();
}
```

---

## 🥪 Testing Structure

Tests are separated by layer to support **TDD and unit isolation**.

```
test/
├── data/
├── domain/
├── presentation/
├── fixtures/
└── mocks/
```

Guidelines:

* **Domain tests** → Validate pure logic (use cases, entities)
* **Data tests** → Mock datasources / verify repository behavior
* **Presentation tests** → Use `bloc_test` to verify UI logic

---

## 🧪 Tech Stack

| Tool                            | Purpose                                       |
| ------------------------------- | --------------------------------------------- |
| **Flutter BLoC**                | Reactive state management                     |
| **Freezed / build_runner**      | Code generation for unions & immutables       |
| **Dartz**                       | Functional programming (Either, Option, Unit) |
| **GetIt**                       | Dependency Injection / Service Locator        |
| **Mocktail / bloc_test / test** | Unit and integration testing                  |
| **TDD-ready structure**         | Independent, decoupled layers                 |

---

## 🦯 Workflow (to adapt per project)

### Adding a New Feature

1. Create a new folder under `domain/usecases/feature_name/`
2. Define:

   * Entity (in `domain/entities`)
   * Use Case
   * Repository interface
3. Implement data logic in:

   * `data/repositories/feature_name_repository_impl.dart`
   * `data/datasources/feature_name_remote_data_source.dart`
4. Create a Bloc in:

   * `presentation/bloc/feature_name/`
5. Register dependencies in `injector.dart`
6. Write tests per layer

---

## ⚙️ Build Commands

```bash
# Get dependencies
flutter pub get

# Generate code (Freezed, JsonSerializable, etc.)
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Run app 
flutter run
```

---

## 📦 Stack Summary

| Category                 | Packages                  |
| ------------------------ | ------------------------- |
| **Architecture**         | Clean, Feature-based      |
| **State Management**     | flutter_bloc              |
| **Code Generation**      | freezed, build_runner     |
| **Functional Core**      | dartz                     |
| **Dependency Injection** | get_it                    |
| **Testing**              | bloc_test, mocktail, test |

---

## 🧩 Adding Platforms Later

To add platforms (Android, iOS, Web, etc.) to this pure-logic template:

```bash
flutter create . --platforms=web,android,ios
```

---

## 📜 License

Distributed under the MIT License.
You are free to use, modify, and distribute this template in your own projects.
