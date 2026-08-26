# 🎯 Guia de Uso da Nova Arquitetura MVC

## 📱 Como Executar o Aplicativo

1. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

2. **Execute o app:**
   ```bash
   flutter run
   ```

3. **Escolha um perfil para testar:**
   - Student (Aluno)
   - Admin (Administrador)
   - Donor (Doador)

## 📂 Onde Adicionar Novos Componentes

### Novo Widget para a tela do Student?
Adicione em: `lib/views/student/widgets/`

### Novo Widget para a tela do Admin?
Adicione em: `lib/views/admin/widgets/`

### Nova Lógica de Negócio (Controller)?
Adicione em: `lib/controllers/`

### Novo Modelo de Dados?
Adicione em: `lib/models/`

### Nova Chamada de API?
Implemente em: `lib/services/api_service.dart`

## 🔄 Fluxo de Dados (MVC)

```
┌─────────────────────────────────────────────────┐
│                    USER INTERACTION             │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
        ┌────────────────┐
        │   Views (.dart)│  ◄─ Renderiza a interface
        │  (Telas/UI)    │
        └────────┬───────┘
                 │
    ┌────────────▼──────────────┐
    │   Controllers (.dart)     │  ◄─ Gerencia estado
    │  (Lógica de Navegação)    │
    └────────────┬──────────────┘
                 │
    ┌────────────▼──────────────┐
    │   Services (.dart)        │  ◄─ Busca dados (API, Auth)
    │   & Database (.dart)      │
    └────────────┬──────────────┘
                 │
    ┌────────────▼──────────────┐
    │   Models (.dart)          │  ◄─ Define estrutura dos dados
    │   (Classes de Dados)      │
    └──────────────────────────┘
```

## ✨ Exemplo: Adicionar Nova Aba no Student

### 1. Criar o Widget
**Arquivo:** `lib/views/student/widgets/student_new_tab.dart`
```dart
import 'package:flutter/material.dart';

class StudentNewTab extends StatelessWidget {
  const StudentNewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Nova Aba'),
    );
  }
}
```

### 2. Atualizar StudentHomeView
**Arquivo:** `lib/views/student/student_home_view.dart`
```dart
// Adicionar import
import 'widgets/student_new_tab.dart';

// Atualizar _buildBody
Widget _buildBody(int index) {
  switch (index) {
    case 0: return const StudentMyArea();
    case 1: return const StudentAgenda();
    case 2: return const StudentActivities();
    case 3: return const StudentScholarships();
    case 4: return const StudentNewTab();  // ← NOVO
    default: return const StudentMyArea();
  }
}
```

### 3. Atualizar StudentBottomNav
**Arquivo:** `lib/views/student/widgets/student_bottom_nav.dart`
```dart
// Adicionar novo item
BottomNavigationBarItem(
  icon: Icon(Icons.new_releases_outlined),
  activeIcon: Icon(Icons.new_releases),
  label: 'Nova Aba',
),
```

## 🎓 Boas Práticas

✅ **DO:**
- Mantenha Views simples - apenas renderização
- Coloque lógica nos Controllers
- Use Models para definir estruturas de dados
- Separe responsabilidades em diferentes camadas

❌ **DON'T:**
- Não coloque lógica complexa em Widgets
- Não faça requisições HTTP diretas em Views
- Não misture Models com Views
- Não ignore a estrutura de pastas

## 🐛 Troubleshooting

**Erro: "Target of URI doesn't exist"**
- Verifique se o caminho do import está correto
- Certifique-se de que a pasta foi criada corretamente

**Erro: "ConsumerWidget not found"**
- Execute `flutter pub get` para instalar flutter_riverpod
- Descomente `ProviderScope` no main.dart após instalação

**Widgets não aparecem**
- Verifique se o widget é retornado em `_buildBody()`
- Confirme que o índice está correto no BottomNavigationBar

## 📚 Recursos Úteis

- [Flutter MVC Architecture](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [State Management Best Practices](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

---

**Última atualização:** 17/08/2026
**Versão:** 1.0.0
