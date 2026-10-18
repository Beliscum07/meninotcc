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

## Configuração do Firebase

Este repositório não inclui `lib/firebase_options.dart` nem os arquivos nativos
de configuração do Firebase. Antes de executar a aplicação, use o FlutterFire
CLI autenticado com acesso ao projeto Firebase existente:

```sh
flutterfire configure --project=<ID_REAL_DO_PROJETO> --platforms=<PLATAFORMAS_UTILIZADAS>
```

Selecione somente as plataformas efetivamente utilizadas e já registradas no
projeto. No Firebase Console, habilite o provedor de autenticação por e-mail e
senha. O cadastro disponível na aplicação cria somente uma conta no Firebase
Authentication; não cria documentos nem usuários de outros perfis.

Depois de gerar as opções, a inicialização em `FirebaseService` deve usar
`Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`.
Sem as opções reais, a inicialização web falha e as operações Firebase não
podem ser testadas.
