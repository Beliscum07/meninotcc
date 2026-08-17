# 🚀 Próximas Implementações

## Passo 1: Instalar Dependências
```bash
cd c:\3ds\app_ong
flutter pub get
```

## Passo 2: Testar a Estrutura
```bash
flutter run
```

Você verá uma tela com 3 botões para escolher o tipo de usuário:
- Student (Aluno)
- Admin (Administrador)  
- Donor (Doador)

## Passo 3: Descomentar ProviderScope (depois de flutter pub get)
**Arquivo:** `lib/main.dart` (linha 7)

Descomente:
```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

## Passo 4: Implementar Controllers com Riverpod

### Exemplo: Admin Navigation Controller
**Arquivo:** `lib/controllers/admin_nav_controller.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminNavController = StateProvider<int>((ref) => 0);
```

### Exemplo: Donor Navigation Controller
**Arquivo:** `lib/controllers/donor_nav_controller.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final donorNavController = StateProvider<int>((ref) => 0);
```

## Passo 5: Atualizar Views para usar Riverpod

### Exemplo: admin_home_view.dart (para usar Riverpod)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/admin_nav_controller.dart';
import 'widgets/admin_bottom_nav.dart';
import 'widgets/admin_dashboard.dart';

class AdminHomeView extends ConsumerWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(adminNavController);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: _buildBody(selectedIndex),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(adminNavController.notifier).state = index;
        },
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0: return const AdminDashboard();
      case 1: return const Center(child: Text('Alunos'));
      case 2: return const Center(child: Text('Configurações'));
      default: return const AdminDashboard();
    }
  }
}
```

## Passo 6: Implementar Auth Service
**Arquivo:** `lib/services/auth_service.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    // Implementar login com API ou Firebase
    return true;
  }

  Future<void> logout() async {
    // Implementar logout
  }

  Future<bool> validateToken() async {
    // Validar token armazenado
    return true;
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
```

## Passo 7: Implementar API Service
**Arquivo:** `lib/services/api_service.dart`

```dart
class ApiService {
  final String baseUrl = 'https://sua-api.com';

  Future<dynamic> get(String endpoint) async {
    // Implementar GET request
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    // Implementar POST request
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    // Implementar PUT request
  }

  Future<void> delete(String endpoint) async {
    // Implementar DELETE request
  }
}
```

## Passo 8: Criar Theme Global
**Arquivo:** `lib/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
      ),
      useMaterial3: true,
      // Adicionar outras configurações de tema
    );
  }
}
```

## Passo 9: Implementar Modelos Completos
**Arquivo:** `lib/models/user_model.dart` (novo)

```dart
class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'admin', 'donor'

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
```

## Passo 10: Preparar para Testes
**Arquivo:** `test/widget_test.dart` (atualizar)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_ong/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Selecionar Perfil'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
```

---

## 📝 Checklist de Implementação

- [ ] Executar `flutter pub get`
- [ ] Testar HomeSelector no emulador/device
- [ ] Criar `admin_nav_controller.dart`
- [ ] Criar `donor_nav_controller.dart`
- [ ] Uncomment ProviderScope no main.dart
- [ ] Atualizar admin_home_view.dart para ConsumerWidget
- [ ] Atualizar donor_home_view.dart para ConsumerWidget
- [ ] Implementar auth_service.dart completo
- [ ] Implementar api_service.dart completo
- [ ] Criar theme/app_theme.dart
- [ ] Criar models/user_model.dart
- [ ] Executar testes
- [ ] Fazer commit no git

---

**Estimativa:** 3-5 dias de desenvolvimento  
**Dificuldade:** Média  
**Prioridade:** Alta
