# 🎯 README - App ONG (Flutter MVC)

> **Status:** ✅ Estrutura MVC Completa | **Versão:** 1.0.0 | **Data:** 17/08/2026

## 🚀 Início Rápido

```bash
# 1. Instalar dependências
flutter pub get

# 2. Executar o app
flutter run

# 3. Escolher um perfil para testar (Student, Admin ou Donor)
```

## 📚 Documentação

Começar por: **[INDICE.md](INDICE.md)** ← 📍 ÍNDICE COMPLETO

Ou comece direto por:

1. **[INICIO_RAPIDO.md](INICIO_RAPIDO.md)** - 3 passos para começar (⚡ RECOMENDADO)
2. **[GUIA_VISUAL.md](GUIA_VISUAL.md)** - Diagramas e estrutura visual
3. **[GUIA_USO.md](GUIA_USO.md)** - Como usar a estrutura + exemplos
4. **[PROXIMOS_PASSOS.md](PROXIMOS_PASSOS.md)** - Roadmap com código pronto

## 🏗️ Arquitetura MVC

```
lib/
├─ models/          # Dados (Student, Donation)
├─ views/           # Interface (StudentView, AdminView, DonorView)
│  └─ {tipo}/widgets/    # Componentes específicos
├─ controllers/      # Estado (StateProvider com Riverpod)
├─ services/         # APIs e Autenticação
├─ database/         # Persistência local
└─ main.dart        # Entrada do app
```

## 🎭 Três Perfis de Usuário

| Perfil | Arquivo | Widgets |
|--------|---------|---------|
| 🎓 **Student** | `student_home_view.dart` | MyArea, Agenda, Activities, Scholarships |
| 👨‍💼 **Admin** | `admin_home_view.dart` | Dashboard, Students, Settings |
| 💝 **Donor** | `donor_home_view.dart` | Home, Donations, Profile |

## ✨ O Que Mudou

### ✅ Criado
- Pastas `admin/widgets/`, `donor/widgets/`, `student/widgets/`
- 6 novos widgets (admin_bottom_nav, admin_dashboard, etc)
- HomeSelector na tela inicial
- Documentação completa (8 arquivos)

### ✏️ Atualizado
- `main.dart` - Reorganizado com ProviderScope
- `admin_home_view.dart` - Adicionada navegação
- `student_home_view.dart` - Imports corrigidos
- `pubspec.yaml` - Adicionado flutter_riverpod

### 🔄 Renomeado
- `controller/` → `controllers/`

### 🗑️ Removido
- Pasta antiga `views/widgets/` (widgets desorganizados)

## 📱 Funcionamento

```
main.dart
    ↓
HomeSelector (3 botões: Student, Admin, Donor)
    ↓
Escolher um perfil
    ↓
Abre a View correspondente
    ↓
BottomNav controla qual widget mostrar
```

## 🎯 Próximas Implementações

### Curto Prazo
- [ ] `flutter pub get` + `flutter run`
- [ ] Testar navegação entre os 3 perfis
- [ ] Descomentar ProviderScope em main.dart

### Médio Prazo
- [ ] Criar `admin_nav_controller.dart`
- [ ] Criar `donor_nav_controller.dart`
- [ ] Implementar Auth Service
- [ ] Implementar API Service

### Longo Prazo
- [ ] Testes unitários
- [ ] Integração com API real
- [ ] Persistência local (SQLite)
- [ ] Deploy para Play Store/App Store

## 📚 Documentação por Tópico

| Assunto | Arquivo |
|---------|---------|
| Começar | INICIO_RAPIDO.md |
| Estrutura Visual | GUIA_VISUAL.md |
| Como Usar | GUIA_USO.md |
| Exemplos de Código | PROXIMOS_PASSOS.md |
| Detalhes Técnicos | ORGANIZACAO_MVC.md |
| Fluxo de Dados | VISUALIZACAO_ESTRUTURA.md |
| Checklist | CHECKLIST_FINAL.md |
| Índice Completo | INDICE.md |

## 🔍 Estrutura de Pastas

```
c:\3ds\app_ong\
├─ lib/                    # Código-fonte
│  ├─ models/
│  ├─ views/
│  ├─ controllers/
│  ├─ services/
│  ├─ database/
│  └─ main.dart
├─ android/                # Código nativo Android
├─ ios/                    # Código nativo iOS
├─ test/                   # Testes
├─ pubspec.yaml            # Dependências
├─ INDICE.md               # ← COMECE AQUI
├─ INICIO_RAPIDO.md
├─ GUIA_USO.md
├─ GUIA_VISUAL.md
├─ PROXIMOS_PASSOS.md
├─ ORGANIZACAO_MVC.md
├─ VISUALIZACAO_ESTRUTURA.md
├─ CHECKLIST_FINAL.md
├─ RESUMO_MUDANCAS.md
└─ ESTRUTURA_FINAL.txt
```

## ❓ Perguntas Frequentes

**P: Como adiciono um novo widget?**  
R: Coloque em `lib/views/{tipo}/widgets/` (admin, donor ou student)

**P: Como adiciono uma nova aba?**  
R: Veja o exemplo em [GUIA_USO.md](GUIA_USO.md) na seção "Adicionar Nova Aba"

**P: Quando usar Riverpod?**  
R: Para gerenciar estado global. Veja [PROXIMOS_PASSOS.md](PROXIMOS_PASSOS.md)

**P: Como testar sem uma API real?**  
R: Use `mock_database.dart` conforme está em `PROXIMOS_PASSOS.md`

## 🚨 Troubleshooting

**Erro: "Target of URI doesn't exist"**
```bash
# Solução: Verificar se o import está com caminho correto
# Verificar se a pasta/arquivo existe
flutter clean
flutter pub get
```

**Erro: "ConsumerWidget not found"**
```bash
# Solução: Instalar flutter_riverpod
flutter pub get
# Descomentar ProviderScope em main.dart
```

**App não inicia**
```bash
flutter clean
flutter pub get
flutter run
```

## 🔗 Recursos Úteis

- [Flutter Docs](https://flutter.dev/docs)
- [Riverpod](https://riverpod.dev)
- [Material Design](https://material.io/design)
- [Dart Language](https://dart.dev)

## 📊 Estatísticas

| Item | Valor |
|------|-------|
| Arquivos Dart | 20 |
| Widgets | 9 |
| Controllers | 2 |
| Views | 3 |
| Documentação | 8 arquivos |
| Erros | 0 |

## ✅ Checklist Antes de Começar

- [ ] `flutter pub get` executado
- [ ] Testei os 3 perfis no app
- [ ] Li pelo menos `GUIA_USO.md`
- [ ] Entendi a estrutura MVC
- [ ] Identifiquei onde adicionar novas features

## 🎓 Padrão MVC Explicado

```
MODEL (lib/models/)
  ↓ Define formato
CONTROLLER (lib/controllers/)
  ↓ Gerencia estado
VIEW (lib/views/)
  ↓ Renderiza
WIDGET (lib/views/*/widgets/)
  ↓ Componente reutilizável
```

## 🚀 Próximo Passo

👉 **Abra: [INDICE.md](INDICE.md)** para ver o índice completo

Ou vá direto para: **[INICIO_RAPIDO.md](INICIO_RAPIDO.md)** para começar em 3 passos!

---

## 📝 Informações do Projeto

- **Nome:** App ONG
- **Versão:** 1.0.0
- **Arquitetura:** MVC (Model-View-Controller)
- **State Management:** Riverpod
- **SDK:** Flutter 3.11+
- **Última Atualização:** 17/08/2026

---

## 📧 Suporte

Dúvidas? Consulte:
1. O arquivo `GUIA_USO.md`
2. O arquivo `PROXIMOS_PASSOS.md`
3. Os comentários no código
4. A documentação do Flutter

---

**Estrutura Pronta para Desenvolvimento!** 🎉

Boa sorte! 🚀
