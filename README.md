# app_ong

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#Estrutura
lib/
├── models/
│   ├── student_model.dart         # Estrutura dos dados (classes)
│   └── donation_model.dart
├── views/
│   ├── student/
│   │   ├── student_home_view.dart # Telas principais
│   │   └── widgets/               # Componentes visuais extraídos da tela
│   │       ├── student_bottom_nav.dart
│   │       ├── student_my_area.dart
│   │       └── student_agenda.dart
│   └── donor/
│       └── donor_home_view.dart
├── controllers/
│   ├── student_nav_controller.dart # Gerenciamento de estado e regras de negócio (Riverpod)
│   └── auth_controller.dart
├── services/
│   ├── api_service.dart           # Comunicação com APIs externas
│   └── auth_service.dart
├── database/
│   ├── mock_database.dart         # Dados simulados (enquanto a API não está pronta)
│   └── local_storage.dart         # Banco de dados local (SQLite, SharedPreferences)
└── main.dart