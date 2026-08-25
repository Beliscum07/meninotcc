# 🎨 Guia Visual - Estrutura MVC do App ONG

## 🏗️ Estrutura do Projeto

```
╔════════════════════════════════════════════════════════════════╗
║                    📱 APP ONG - ESTRUTURA MVC                  ║
╚════════════════════════════════════════════════════════════════╝

                          ┌─────────────┐
                          │  main.dart  │
                          │             │
                          │  ProviderScope (ProviderContainer)
                          │  MaterialApp │
                          └──────┬──────┘
                                 │
                    ┌────────────▼────────────┐
                    │  HomeSelector          │
                    │  (Choose Profile)      │
                    │ ┌────┐ ┌────┐ ┌────┐  │
                    │ │Stud│ │Adm │ │Don │  │
                    │ └────┘ └────┘ └────┘  │
                    └────────┬───────────────┘
                             │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
      ┌───▼────┐        ┌────▼──┐         ┌───▼────┐
      │STUDENT │        │ ADMIN │         │ DONOR  │
      │  VIEW  │        │ VIEW  │         │  VIEW  │
      └───┬────┘        └────┬──┘         └───┬────┘
          │                  │                │
      ┌───▼─────────────┐ ┌──▼───────────┐ ┌──▼───────────┐
      │   WIDGETS       │ │   WIDGETS    │ │   WIDGETS    │
      ├─────────────────┤ ├──────────────┤ ├──────────────┤
      │• BottomNav      │ │• BottomNav   │ │• BottomNav   │
      │• MyArea         │ │• Dashboard   │ │• Home        │
      │• Agenda         │ │• ...         │ │• Donations   │
      │• Activities     │ │              │ │• Profile     │
      │• Scholarships   │ │              │ │              │
      └───┬─────────────┘ └──┬───────────┘ └──┬───────────┘
          │                  │                │
          └──────────────────┼────────────────┘
                             │
              ┌──────────────▼───────────────┐
              │     CONTROLLERS/SERVICES     │
              ├──────────────────────────────┤
              │ student_nav_controller       │
              │ admin_nav_controller (TODO)  │
              │ donor_nav_controller (TODO)  │
              │ auth_controller              │
              │ api_service                  │
              │ auth_service                 │
              └──────────────┬────────────────┘
                             │
              ┌──────────────▼───────────────┐
              │       MODELS/DATABASE        │
              ├──────────────────────────────┤
              │ student_model.dart           │
              │ donation_model.dart          │
              │ mock_database.dart           │
              │ local_storage.dart           │
              └──────────────────────────────┘
```

## 🎯 Fluxo de Interação do Usuário

```
╔═══════════════════════════════════════════════════════════════╗
║                   CICLO DE VIDA MVC - STUDENT                 ║
╚═══════════════════════════════════════════════════════════════╝

  USER TAPS AGENDA
        │
        ▼
  ┌─────────────────┐
  │ BottomNavBar    │  ← TAP INDEX 1 (AGENDA)
  │ Current Index:0 │
  └────────┬────────┘
           │
  ┌────────▼──────────────┐
  │ onTap(1) ──┐          │
  │            ├─→ Update State
  └────────────┴──────────┘
               │
      ┌────────▼──────────┐
      │ student_nav_      │
      │ controller        │
      │ (StateProvider)   │
      │ state = 1         │  ← CONTROLLER (Estado)
      └────────┬──────────┘
               │
      ┌────────▼──────────────────┐
      │ Listeners Notificados     │
      │ (StudentHomeView watches) │
      └────────┬──────────────────┘
               │
      ┌────────▼──────────────────┐
      │ Rebuild StudentHomeView   │
      │ selectedIndex = 1         │
      └────────┬──────────────────┘
               │
      ┌────────▼──────────────────┐
      │ _buildBody(1)             │
      │ case 1: StudentAgenda     │
      └────────┬──────────────────┘
               │
      ┌────────▼──────────────────┐
      │ StudentAgenda Widget      │
      │ Renders on Screen         │
      │                           │
      │ ┌─────────────────────┐   │
      │ │   📅 AGENDA        │   │
      │ │ ─────────────────── │   │
      │ │ Next Event: ...     │   │
      │ └─────────────────────┘   │
      └───────────────────────────┘
```

## 🔄 Padrão MVC Aplicado

```
╔════════════════════════════════════════════════════════════════╗
║                  MVC = Model View Controller                    ║
╠════════════════════════════════════════════════════════════════╣
║                                                                 ║
║  M - MODEL (lib/models/)                                       ║
║  ├─ StudentModel ← Define como é um Aluno                      ║
║  ├─ DonationModel ← Define como é uma Doação                   ║
║  └─ UserModel ← Define como é um Usuário                       ║
║                                                                 ║
║  V - VIEW (lib/views/)                                         ║
║  ├─ StudentHomeView ← Interface do Aluno                       ║
║  ├─ AdminHomeView ← Interface do Admin                         ║
║  ├─ DonorHomeView ← Interface do Doador                        ║
║  └─ Widgets/ ← Componentes da UI                               ║
║                                                                 ║
║  C - CONTROLLER (lib/controllers/)                             ║
║  ├─ student_nav_controller ← Gerencia estado                   ║
║  ├─ admin_nav_controller ← (TODO)                              ║
║  ├─ donor_nav_controller ← (TODO)                              ║
║  └─ auth_controller ← Autenticação                             ║
║                                                                 ║
║  S - SERVICES (lib/services/)                                  ║
║  ├─ api_service ← Conexão com API                              ║
║  └─ auth_service ← Login/Logout                                ║
║                                                                 ║
║  D - DATABASE (lib/database/)                                  ║
║  ├─ mock_database ← Dados de teste                             ║
║  └─ local_storage ← Armazenamento local                        ║
║                                                                 ║
╚════════════════════════════════════════════════════════════════╝
```

## 🎭 Três Perfis de Usuário

```
╔════════════════════════════════════════════════════════════════╗
║                    TIPOS DE USUÁRIOS                           ║
╚════════════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────────────┐
│ 🎓 STUDENT (Aluno)                                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Tela Principal: lib/views/student/student_home_view.dart       │
│                                                                 │
│  ┌──────────────────────────────────────┐                      │
│  │ 📱 Student App                       │                      │
│  ├──────────────────────────────────────┤                      │
│  │ ┌────────────────────────────────┐   │                      │
│  │ │                                │   │                      │
│  │ │  Conteúdo da Aba Atual        │   │                      │
│  │ │                                │   │                      │
│  │ └────────────────────────────────┘   │                      │
│  ├──────────────────────────────────────┤                      │
│  │ 🏠│📅│📌│🎓 (BottomNav)            │                      │
│  │   0  1   2  3                        │                      │
│  └──────────────────────────────────────┘                      │
│                                                                 │
│  Widgets:                                                       │
│  • StudentBottomNav (4 abas)                                   │
│  • StudentMyArea (Aba 0)                                       │
│  • StudentAgenda (Aba 1)                                       │
│  • StudentActivities (Aba 2)                                   │
│  • StudentScholarships (Aba 3)                                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 👨‍💼 ADMIN (Administrador)                                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Tela Principal: lib/views/admin/admin_home_view.dart           │
│                                                                 │
│  ┌──────────────────────────────────────┐                      │
│  │ 📱 Admin App                         │                      │
│  ├──────────────────────────────────────┤                      │
│  │ ┌────────────────────────────────┐   │                      │
│  │ │                                │   │                      │
│  │ │  Conteúdo da Aba Atual        │   │                      │
│  │ │                                │   │                      │
│  │ └────────────────────────────────┘   │                      │
│  ├──────────────────────────────────────┤                      │
│  │ 📊│👥│⚙️  (BottomNav)              │                      │
│  │   0   1   2                          │                      │
│  └──────────────────────────────────────┘                      │
│                                                                 │
│  Widgets:                                                       │
│  • AdminBottomNav (3 abas)                                     │
│  • AdminDashboard (Aba 0)                                      │
│  • Alunos (Aba 1)                                              │
│  • Configurações (Aba 2)                                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 💝 DONOR (Doador)                                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Tela Principal: lib/views/donor/donor_home_view.dart           │
│                                                                 │
│  ┌──────────────────────────────────────┐                      │
│  │ 📱 Donor App                         │                      │
│  ├──────────────────────────────────────┤                      │
│  │ ┌────────────────────────────────┐   │                      │
│  │ │                                │   │                      │
│  │ │  Conteúdo da Aba Atual        │   │                      │
│  │ │                                │   │                      │
│  │ └────────────────────────────────┘   │                      │
│  ├──────────────────────────────────────┤                      │
│  │ 🏠│❤️│👤 (BottomNav)                │                      │
│  │   0   1   2                          │                      │
│  └──────────────────────────────────────┘                      │
│                                                                 │
│  Widgets:                                                       │
│  • DonorBottomNav (3 abas)                                     │
│  • Home (Aba 0)                                                │
│  • Minhas Doações (Aba 1)                                      │
│  • Perfil (Aba 2)                                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 📊 Árvore de Dependências

```
main.dart
│
├─ MyApp (MaterialApp)
│  └─ HomeSelector
│     ├─ ElevatedButton("Student") → StudentHomeView
│     ├─ ElevatedButton("Admin") → AdminHomeView
│     └─ ElevatedButton("Donor") → DonorHomeView
│
├─ StudentHomeView
│  ├─ StudentBottomNav
│  │  └─ BottomNavigationBar (4 items)
│  └─ _buildBody(selectedIndex)
│     ├─ StudentMyArea
│     ├─ StudentAgenda
│     ├─ StudentActivities
│     └─ StudentScholarships
│
├─ AdminHomeView
│  ├─ AdminBottomNav
│  │  └─ BottomNavigationBar (3 items)
│  └─ _buildBody(selectedIndex)
│     ├─ AdminDashboard
│     ├─ Students List
│     └─ Settings
│
└─ DonorHomeView
   ├─ DonorBottomNav
   │  └─ BottomNavigationBar (3 items)
   └─ _buildBody(selectedIndex)
      ├─ Home Screen
      ├─ Donations List
      └─ Profile
```

## 🎯 Como Navegar

```
┌──────────────────────────────────────────────────────────────┐
│  NAVEGAÇÃO NO APP ONG                                        │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  1. App inicia → main.dart                                  │
│                 ↓                                            │
│  2. HomeSelector (escolha de perfil)                        │
│                 ↓                                            │
│  3. Seleciona um perfil (Student/Admin/Donor)              │
│                 ↓                                            │
│  4. Abre a tela correspondente (StudentHomeView, etc)      │
│                 ↓                                            │
│  5. BottomNavBar controla qual widget mostrar              │
│                 ↓                                            │
│  6. User tapa um ícone → índice muda → widget muda        │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## 📈 Crescimento do Projeto

```
┌──────────────────────────────────────────────────────────────┐
│  FASES DE DESENVOLVIMENTO                                   │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  FASE 1: Estrutura MVC ✅ COMPLETO                          │
│  ├─ Pastas organizadas                                      │
│  ├─ Widgets separados                                       │
│  ├─ Main.dart com ProviderScope                             │
│  └─ Documentação                                            │
│                                                              │
│  FASE 2: Riverpod (Próxima)                                 │
│  ├─ Controllers com StateNotifier                           │
│  ├─ Auth State Management                                   │
│  └─ Global State                                            │
│                                                              │
│  FASE 3: Services                                           │
│  ├─ API Integration                                         │
│  ├─ Authentication                                          │
│  └─ Data Sync                                               │
│                                                              │
│  FASE 4: Features                                           │
│  ├─ Telas específicas                                       │
│  ├─ Formulários                                             │
│  └─ Validações                                              │
│                                                              │
│  FASE 5: Deploy                                             │
│  ├─ Build para iOS/Android                                  │
│  ├─ App Store/Play Store                                    │
│  └─ CI/CD                                                   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

**Estrutura Completa e Pronta!** 🎉

Próximo: Abra `INICIO_RAPIDO.md` para começar!
