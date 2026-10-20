# Menino Barsanulfo

Aplicativo Flutter de apoio à ONG Menino Barsanulfo.

## Firebase configurado

O repositório já contém as opções FlutterFire para o projeto `mb-tcc`, além da
configuração Android em `android/app/google-services.json`. A inicialização do
Firebase usa `DefaultFirebaseOptions.currentPlatform` em
`lib/firebase_options.dart`. Não substitua esses arquivos por configurações de
outro projeto.

O aplicativo usa Firebase Authentication com e-mail e senha para a identidade
e Firebase SQL Connect para os perfis e dados relacionais. A configuração local
em `dataconnect/dataconnect.yaml` aponta para o serviço
`mb-tcc-2-service`, na região `southamerica-east1`, e para o conector
`example`. Ela declara o banco `mb-tcc-2-database` e a instância
`mb-tcc-2-instance`; esses nomes são referências configuradas no repositório,
não uma confirmação de que os recursos existem ou correspondem ao PostgreSQL
que contém os dados.

Antes de publicar, confirme no Firebase Console e no Cloud SQL que o serviço,
a região, o ID da instância e o nome do banco correspondem aos recursos
existentes. A mensagem de deploy informando que o período gratuito do Cloud SQL
já foi usado indica que uma etapa de provisionamento foi bloqueada por
faturamento; por si só, ela não comprova que é necessário criar outra instância
nem que os dados existentes estão ausentes. Não habilite faturamento, crie
instâncias ou aplique migrações sem confirmar esses recursos e revisar o
impacto sobre o banco atual.

A compilação local do SQL Connect valida o esquema GraphQL e as operações, mas
não confirma o catálogo físico do PostgreSQL remoto. Ainda é necessário
comparar as colunas, tipos, chaves primárias, chaves estrangeiras e restrições
de unicidade das tabelas existentes (especialmente `Usuario`, `Aluno`,
`Doador`, `Atividade`, `Inscricao` e `Doacao`) com
`dataconnect/schema/schema.gql`. Não há introspecção do banco remoto neste
repositório; portanto, não aplique migrações até obter essa estrutura e revisar
um plano de migração não destrutivo.

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

Os fluxos atuais de perfil usam SQL Connect. O `FirebaseService` legado ainda é
inicializado, mas seus métodos de leitura e gravação no Firestore não têm outros
chamadores no código Dart. Nenhum dado ou coleção do Firestore foi consultado
ou migrado; mantenha esses dados intactos até uma auditoria do projeto remoto.

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
