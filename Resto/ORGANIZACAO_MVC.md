# Reorganização da Arquitetura MVC - App ONG

## ✅ Mudanças Realizadas

A estrutura do projeto foi reorganizada seguindo o padrão MVC (Model-View-Controller) com melhor separação de responsabilidades.

### 📁 Estrutura Anterior → Nova Estrutura

```
lib/
├── controller/               →  controllers/
├── views/
│   ├── widgets/             →  admin/widgets/, donor/widgets/, student/widgets/
│   ├── admin/
│   ├── donor/
│   └── student/
```

### 🔄 Mudanças Específicas

#### 1. **Controllers (Lógica e Estado)**
- Pasta `controller/` renomeada para `controllers/`
- **Arquivos:**
  - `student_nav_controller.dart` - Gerencia navegação do aluno
  - `auth_controller.dart` - Gerencia autenticação

#### 2. **Views (Interface e Telas)**
- Widgets agora organizados dentro de suas respectivas views:
  - `views/admin/widgets/` - Componentes da tela Admin
    - `admin_bottom_nav.dart` ✅ (criado)
    - `admin_dashboard.dart` ✅ (criado)
  - `views/donor/widgets/` - Componentes da tela Doador
    - `donor_bottom_nav.dart` ✅ (criado)
  - `views/student/widgets/` - Componentes da tela Aluno
    - `student_bottom_nav.dart` (movido)
    - `student_agenda.dart` (movido)
    - `student_my_area.dart` (movido)
    - `student_activities.dart` ✅ (criado)
    - `student_scholarships.dart` ✅ (criado)

#### 3. **Telas Principais (Views)**
- `admin_home_view.dart` - Tela principal do admin ✅ (atualizada com navegação)
- `donor_home_view.dart` - Tela principal do doador ✅ (criada)
- `student_home_view.dart` - Tela principal do aluno ✅ (atualizada com imports corretos)

#### 4. **Models (Estrutura de Dados)**
- Sem mudanças - já estava bem organizado
- `models/student_model.dart`
- `models/donation_model.dart`

#### 5. **Services (Comunicação Externa)**
- Sem mudanças - já estava bem organizado
- `services/api_service.dart`
- `services/auth_service.dart`

#### 6. **Database (Armazenamento)**
- Sem mudanças - já estava bem organizado
- `database/mock_database.dart`
- `database/local_storage.dart`

#### 7. **Main Entry Point**
- `main.dart` ✅ (completamente reorganizado)
  - Adicionado `ProviderScope` do Riverpod (comentado até instalação)
  - Criada tela de seleção de perfil para testes
  - Navegação entre Student, Admin e Donor

### 📦 Dependências Adicionadas

```yaml
dependencies:
  flutter_riverpod: ^2.4.0  # ✅ Adicionado ao pubspec.yaml
```

## 📋 Próximos Passos Recomendados

1. **Instalar dependências:**
   ```bash
   flutter pub get
   ```

2. **Descomentar ProviderScope no main.dart** após instalação do flutter_riverpod

3. **Implementar Controllers com Riverpod:**
   - Converter `student_nav_controller.dart` para usar `StateNotifier`
   - Criar `admin_nav_controller.dart`
   - Criar `donor_nav_controller.dart`

4. **Implementar Services:**
   - Implementar comunicação com API em `api_service.dart`
   - Implementar autenticação em `auth_service.dart`

5. **Criar Temas Globais:**
   - Adicionar arquivo `lib/theme/app_theme.dart`

## ✨ Benefícios da Nova Estrutura

- ✅ **Separação clara de responsabilidades** (MVC)
- ✅ **Escalabilidade** - Fácil adicionar novos tipos de usuários
- ✅ **Reutilização** - Widgets organizados e componíveis
- ✅ **Manutenibilidade** - Código mais organizado e legível
- ✅ **Testabilidade** - Controllers, Services e Models separados

## 📝 Notas

- A tela inicial (`HomeSelector`) permite escolher qual tipo de usuário testar
- Todos os widgets têm implementações básicas (placeholder)
- Os imports foram atualizados em todos os arquivos conforme a nova estrutura
