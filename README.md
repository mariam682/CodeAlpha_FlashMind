# FlashMind 🃏

A Flutter flashcard study app built with MVVM architecture.

## Stack
Flutter 3.x • Provider • SharedPreferences • UUID • MVVM

## Structure
```
lib/
├── constants/app_colors.dart
├── models/flashcard.dart
├── viewmodels/flashcard_viewmodel.dart
├── views/ (welcome, home, study, manage)
└── widgets/ (flip_card, card_form_modal)
```

## Features
- Animated welcome screen with floating cards
- Home dashboard with deck stats
- 3D flip card study mode with progress bar
- Full CRUD card management (bottom sheet modal)
- Persistent local storage (SharedPreferences)
- Starts empty — build your own deck

## Data Model
```dart
Flashcard { id, question, answer, createdAt }
// stored as JSON under key: flashcards_v1
```


## Navigation
`Welcome → Home → Study / Manage`

MIT License
