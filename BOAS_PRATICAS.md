# 📚 GUIA DE BOAS PRÁTICAS - ONG Apoio à Infância

## 1. Estrutura de Pastas

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── controllers/              # Controllers Riverpod
│   ├── admin_nav_controller.dart
│   ├── student_nav_controller.dart
│   └── auth_controller.dart
├── models/                   # Modelos de dados
│   ├── student_model.dart
│   └── donation_model.dart
├── services/                 # Serviços de negócio
│   ├── auth_service.dart
│   └── api_service.dart
├── views/                    # Telas da aplicação
│   ├── admin/
│   ├── student/
│   ├── donor/
│   └── auth/
└── database/                 # Persistência local
    ├── local_storage.dart
    └── mock_database.dart
```

## 2. Padrões de Nomeação

### Controllers
- Suffixo: `_controller.dart`
- Exemplo: `auth_controller.dart`, `admin_nav_controller.dart`
- Padrão: `final meuController = StateProvider<Tipo>((ref) => valor);`

### Models
- Sufixo: `_model.dart`
- Classe em PascalCase: `class Aluno`, `class Doacao`
- Métodos: `copyWith()`, `toJson()`, `fromJson()`, `toString()`

### Services
- Sufixo: `_service.dart`
- Classe em PascalCase: `class AuthService`
- Métodos em camelCase: `login()`, `logout()`

### Views
- Sufixo: `_view.dart` ou `_page.dart`
- Arquivo em snake_case: `aluno_home_view.dart`
- Widget em PascalCase: `class AdminHomeView`

### Widgets/Componentes
- Arquivo em snake_case: `admin_bottom_nav.dart`
- Widget em PascalCase: `class AdminBottomNav`

## 3. Padrões de Código

### 3.1 Comentários Documentation
```dart
/// Descrição breve do que faz
/// 
/// Descrição mais detalhada se necessário
/// Pode incluir exemplos de uso
class MinhaClasse {
  /// Descrição do campo
  final String campo;
  
  /// Descrição do método e seus parâmetros
  /// 
  /// Parâmetros:
  /// - param1: descrição
  /// - param2: descrição
  ///
  /// Retorna: tipo de retorno e descrição
  void meuMetodo(String param1, int param2) {
    // Implementação
  }
}
```

### 3.2 Constantes de Cores
```dart
class MyColors {
  static const Color primaryColor = Color(0xFF5153AA);
  static const Color accentColor = Color(0xFFD969E8);
  static const Color backgroundColor = Color(0xFFF5F1EA);
}

// Uso em widgets
Container(
  color: MyColors.primaryColor,
  child: Text('Hello'),
)
```

### 3.3 Responsividade
```dart
@override
Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  final isSmallScreen = screenSize.width < 600;

  return Column(
    children: [
      SizedBox(height: screenSize.height * 0.02),
      Text(
        'Title',
        style: TextStyle(
          fontSize: isSmallScreen ? 22 : 28,
        ),
      ),
    ],
  );
}
```

### 3.4 Validação de Input
```dart
bool _validarEmail(String email) {
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return regex.hasMatch(email);
}

bool _validarCampos() {
  if (_emailController.text.isEmpty) {
    _mostrarMensagem('Por favor, insira seu email');
    return false;
  }
  if (!_validarEmail(_emailController.text)) {
    _mostrarMensagem('Email inválido');
    return false;
  }
  return true;
}
```

## 4. Padrões Riverpod

### 4.1 StateProvider (Estado simples)
```dart
/// Controller que gerencia índice de navegação
final navIndexProvider = StateProvider<int>((ref) => 0);

// Usar em ConsumerWidget
final index = ref.watch(navIndexProvider);

// Atualizar
ref.read(navIndexProvider.notifier).state = newValue;
```

### 4.2 StateNotifierProvider (Estado complexo)
```dart
final myControllerProvider =
    StateNotifierProvider<MyController, AsyncValue<MyType>>((ref) {
  return MyController();
});

class MyController extends StateNotifier<AsyncValue<MyType>> {
  MyController() : super(const AsyncValue.data(null));

  Future<void> myMethod() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // lógica assíncrona
      return result;
    });
  }
}
```

## 5. Boas Práticas

### 5.1 Imutabilidade
```dart
class Aluno {
  // ✅ BOM: usar const e final
  const Aluno({required this.id, required this.nome});
  final String id;
  final String nome;

  // ✅ BOM: implementar copyWith()
  Aluno copyWith({String? nome}) {
    return Aluno(
      id: id,
      nome: nome ?? this.nome,
    );
  }
}
```

### 5.2 Tratamento de Erros
```dart
Future<void> fazerAlgo() async {
  try {
    // lógica
    await operacao();
  } on FormatException catch (e) {
    print('Erro de formato: $e');
  } on SocketException catch (e) {
    print('Erro de conexão: $e');
  } catch (e) {
    print('Erro desconhecido: $e');
  }
}
```

### 5.3 Organização de Widget
```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // ========== VARIÁVEIS E CONTROLADORES ==========
  late TextEditingController _controller;
  String _estado = '';

  // ========== CONSTANTES ==========
  static const Color _primaryColor = Color(0xFF5153AA);
  static const double _padding = 16.0;

  // ========== LIFECYCLE ==========
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ========== MÉTODOS PRIVADOS ==========
  void _fazerAlgo() {
    setState(() => _estado = 'novo valor');
  }

  Widget _buildWidget() {
    return Container();
  }

  // ========== BUILD ==========
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildWidget(),
    );
  }
}
```

## 6. Convenções de Commit

```bash
# Feature
git commit -m "feat: adicionar autenticação com Riverpod"

# Fix
git commit -m "fix: corrigir validação de email"

# Refactor
git commit -m "refactor: melhorar responsividade do login"

# Docs
git commit -m "docs: atualizar guia de boas práticas"

# Test
git commit -m "test: adicionar testes para auth_service"
```

## 7. Checklist para Novos Features

- [ ] Criar arquivo de model com `copyWith()`, `toJson()`, `fromJson()`
- [ ] Criar ou atualizar controller Riverpod
- [ ] Criar ou atualizar service com métodos necessários
- [ ] Criar view com responsividade (mobile/desktop)
- [ ] Adicionar comentários documentação em tudo
- [ ] Adicionar validação de input
- [ ] Adicionar tratamento de erros
- [ ] Adicionar loading indicators
- [ ] Adicionar feedback visual (mensagens)
- [ ] Testar em mobile e desktop
- [ ] Fazer commit com mensagem clara

## 8. Ferramentas Recomendadas

- **Flutter DevTools**: Para debug e profiling
- **Dart Analyzer**: Para verificar qualidade do código
- **Firebase**: Para backend e autenticação
- **Riverpod Generator**: Para gerar código boilerplate
- **Freezed**: Para gerar modelos imutáveis

## 9. Performance

### 9.1 Evitar rebuilds desnecessários
```dart
// ✅ BOM: usar Consumer apenas na parte que precisa observar
ConsumerBuilder(
  builder: (context, ref, child) {
    final value = ref.watch(myProvider);
    return Text(value);
  },
  child: ExpensiveWidget(), // não rebuild quando myProvider muda
)
```

### 9.2 Lazy loading
```dart
// ✅ BOM: usar FutureBuilder ou .maybeWhen para async
ref.watch(myFutureProvider).whenData((data) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) => Text(data[index]),
  );
})
```

## 10. Segurança

### 10.1 Não armazenar dados sensíveis localmente
```dart
// ❌ RUIM: armazenar senha localmente
SharedPreferences.getInstance().then((prefs) {
  prefs.setString('password', password);
});

// ✅ BOM: usar secure storage
final secureStorage = FlutterSecureStorage();
await secureStorage.write(key: 'token', value: accessToken);
```

### 10.2 Validar dados de entrada
```dart
// ✅ BOM: sempre validar dados do usuário
if (!_validarEmail(email) || password.isEmpty) {
  _mostrarMensagem('Dados inválidos');
  return;
}
```

---

**Versão:** 1.0  
**Última atualização:** Setembro 23, 2026