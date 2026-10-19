# Menino Barsanulfo

Aplicativo Flutter de apoio à ONG Menino Barsanulfo.

## Firebase configurado

O repositório já contém as opções FlutterFire para o projeto `mb-tcc`, além da
configuração Android em `android/app/google-services.json`. A inicialização do
Firebase usa `DefaultFirebaseOptions.currentPlatform` em
`lib/firebase_options.dart`. Não substitua esses arquivos por configurações de
outro projeto.

O aplicativo usa Firebase Authentication com e-mail e senha para a identidade
e Firebase SQL Connect para os perfis e dados relacionais. O serviço e o
conector SQL Connect configurados são `mb-tcc-3-service`, na região
`southamerica-east1`, com o conector `example`.

Antes de executar os fluxos autenticados, confirme no Firebase Console:

1. O provedor de autenticação por e-mail e senha está habilitado.
2. O serviço SQL Connect e a instância Cloud SQL PostgreSQL estão provisionados
   e disponíveis para o projeto.
3. As contas de administrador têm a custom claim `admin: true`, emitida por um
   ambiente confiável com Firebase Admin SDK. O aplicativo não concede essa
   permissão.
4. Cada aluno que fará login já tem uma conta Authentication. Na tela
   administrativa de alunos, vincule o UID dessa conta ao cadastro existente.
   O e-mail da conta deve corresponder ao e-mail cadastrado para o aluno.

O cadastro de doador cria a conta Authentication e registra o perfil relacional
de doador. Doações são gravadas inicialmente como `pendente`; o aplicativo não
confirma pagamento PIX automaticamente. O painel administrativo lista as
doações do SQL Connect e permite registrar manualmente o estado após a
verificação externa; somente doações `recebida` entram nos totais do mês.

## Desenvolvimento

Instale as dependências e execute os testes/análise:

```sh
flutter pub get
flutter analyze
flutter test
```

Para compilar as operações e gerar o SDK Dart em `lib/generated/`:

```sh
firebase dataconnect:compile
firebase dataconnect:sdk:generate
```

A configuração local em `firebase.json` inclui somente o emulador SQL Connect.
Para iniciar:

```sh
firebase emulators:start --only dataconnect
```

As operações protegidas continuam exigindo autenticação e a custom claim
administrativa adequadas. A disponibilidade do emulador não substitui o
provisionamento de Authentication, SQL Connect e Cloud SQL no projeto remoto.

## Publicação e migrações

Não faça deploy nem aplique migrações até revisar o diff do esquema contra o
banco remoto e confirmar a preservação dos dados existentes. Esta integração
não executa deploy, provisionamento de recursos ou migração automática. A
configuração FlutterFire atualmente cobre Android, iOS, macOS, web e Windows;
Linux não está configurado.
