import 'package:app_ong/views/admin/widgets/admin_alunos.dart';
import 'package:app_ong/views/admin/widgets/admin_atividades.dart';
import 'package:app_ong/views/admin/widgets/admin_bolsas.dart';
import 'package:app_ong/views/admin/widgets/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder _field(String label) => find.byWidgetPredicate(
  (widget) => widget is TextField && widget.decoration?.labelText == label,
);

void main() {
  testWidgets('aluno valida e-mail e aceita somente idade numérica', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AdminAlunosPage())),
    );
    await tester.tap(find.byTooltip('Adicionar aluno'));
    await tester.pumpAndSettle();

    expect(tester.widget<TextField>(_field('Nome do aluno')).maxLength, 80);
    expect(tester.widget<TextField>(_field('Responsável')).maxLength, 100);
    expect(tester.widget<TextField>(_field('Telefone')).maxLength, 15);
    expect(tester.widget<TextField>(_field('E-mail')).maxLength, 254);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Senha',
      ),
      findsNothing,
    );

    await tester.enterText(_field('Nome do aluno'), "Ana O'Connor");
    await tester.enterText(_field('Idade'), '12x');
    await tester.enterText(_field('E-mail'), 'email-invalido');
    await tester.pump();
    expect(tester.widget<TextField>(_field('Idade')).controller!.text, '12');

    await tester.tap(find.text('Adicionar').last);
    await tester.pump();
    expect(find.text('Informe um e-mail válido para o aluno.'), findsOneWidget);
  });

  testWidgets('aluno não permite salvar sem nome', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AdminAlunosPage())),
    );
    await tester.tap(find.byTooltip('Adicionar aluno'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adicionar').last);
    await tester.pump();
    expect(find.text('Informe o nome do aluno.'), findsOneWidget);
  });

  testWidgets('atividade limita busca e valida contagens numéricas', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AdminAtividadesPage(atividades: [])),
      ),
    );
    expect(
      tester.widgetList<TextField>(find.byType(TextField)).first.maxLength,
      100,
    );

    await tester.tap(find.byTooltip('Criar atividade'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(_field('Nome da atividade')).maxLength, 80);
    expect(tester.widget<TextField>(_field('Professor')).maxLength, 100);
    expect(tester.widget<TextField>(_field('Descrição')).maxLength, 500);
    expect(tester.widget<TextField>(_field('Horário')).maxLength, 20);
    expect(tester.widget<TextField>(_field('Dias')).maxLength, 50);
    expect(tester.widget<TextField>(_field('Inscritos')).readOnly, isTrue);
    expect(tester.widget<TextField>(_field('Inscritos')).controller!.text, '0');
    expect(tester.widget<TextField>(_field('Vagas')).maxLength, 4);

    await tester.enterText(_field('Nome da atividade'), 'Teatro');
    await tester.enterText(_field('Professor'), 'João da Silva');
    await tester.enterText(_field('Vagas'), '20');

    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();
    expect(find.text('Atividade criada!'), findsOneWidget);
  });

  testWidgets(
    'bolsa aceita centavos e não transforma valor negativo em positivo',
    (tester) async {
      final bolsas = <Bolsa>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AdminBolsas(bolsas: bolsas)),
        ),
      );
      expect(
        tester.widgetList<TextField>(find.byType(TextField)).first.maxLength,
        100,
      );

      await tester.tap(find.byTooltip('Adicionar bolsa'));
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(_field('Nome da bolsa')).maxLength, 50);
      expect(tester.widget<TextField>(_field('Descrição')).maxLength, 500);
      expect(
        tester.widget<TextField>(_field('Beneficiários')).readOnly,
        isTrue,
      );
      expect(
        tester.widget<TextField>(_field('Beneficiários')).controller!.text,
        '0',
      );
      expect(tester.widget<TextField>(_field('Valor mensal')).maxLength, 15);

      await tester.enterText(_field('Nome da bolsa'), 'Bolsa de apoio');
      await tester.enterText(_field('Valor mensal'), '-125,75');
      await tester.pump();
      expect(
        tester.widget<TextField>(_field('Valor mensal')).controller!.text,
        '0.0',
      );

      await tester.enterText(_field('Valor mensal'), '125,75');
      await tester.tap(find.text('Adicionar').last);
      await tester.pumpAndSettle();
      expect(find.text('Bolsa adicionada!'), findsOneWidget);
      expect(bolsas.single.beneficiarios, 0);
    },
  );

  testWidgets('dashboard mostra doações relacionais sem dados fictícios', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AdminDashboard(doacoes: [])),
      ),
    );
    expect(find.text('Doações recentes'), findsOneWidget);
    expect(find.text('Ainda não há doações cadastradas.'), findsOneWidget);
    expect(find.text('R\$ 0,00'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.byTooltip('Editar Dashboard'), findsNothing);
  });
}
