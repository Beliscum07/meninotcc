library meninotcc_dataconnect;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'register_donor_profile.dart';

part 'update_my_profile.dart';

part 'admin_create_student.dart';

part 'admin_update_student.dart';

part 'admin_link_student_account.dart';

part 'admin_set_student_status.dart';

part 'admin_create_activity.dart';

part 'admin_update_activity.dart';

part 'admin_assign_activity.dart';

part 'admin_create_scholarship.dart';

part 'admin_update_scholarship.dart';

part 'admin_assign_scholarship.dart';

part 'admin_create_agenda_entry.dart';

part 'admin_update_agenda_entry.dart';

part 'admin_create_notification.dart';

part 'mark_my_notification_read.dart';

part 'register_my_donation.dart';

part 'admin_set_donation_status.dart';

part 'get_my_profile.dart';

part 'get_my_student.dart';

part 'list_students.dart';

part 'list_activities.dart';

part 'list_scholarships.dart';

part 'list_my_activities.dart';

part 'list_my_scholarships.dart';

part 'list_agenda.dart';

part 'get_my_notifications.dart';

part 'list_my_donations.dart';

part 'list_donations.dart';







class ExampleConnector {
  
  
  RegisterDonorProfileVariablesBuilder registerDonorProfile ({required String nome, required String telefone, }) {
    return RegisterDonorProfileVariablesBuilder(dataConnect, nome: nome,telefone: telefone,);
  }
  
  
  UpdateMyProfileVariablesBuilder updateMyProfile ({required String nome, }) {
    return UpdateMyProfileVariablesBuilder(dataConnect, nome: nome,);
  }
  
  
  AdminCreateStudentVariablesBuilder adminCreateStudent ({required String nome, required int idade, required String responsavel, required String telefone, required int presenca, }) {
    return AdminCreateStudentVariablesBuilder(dataConnect, nome: nome,idade: idade,responsavel: responsavel,telefone: telefone,presenca: presenca,);
  }
  
  
  AdminUpdateStudentVariablesBuilder adminUpdateStudent ({required String id, required String nome, required int idade, required String responsavel, required String telefone, required int presenca, }) {
    return AdminUpdateStudentVariablesBuilder(dataConnect, id: id,nome: nome,idade: idade,responsavel: responsavel,telefone: telefone,presenca: presenca,);
  }
  
  
  AdminLinkStudentAccountVariablesBuilder adminLinkStudentAccount ({required String studentId, required String authUid, required String authEmail, }) {
    return AdminLinkStudentAccountVariablesBuilder(dataConnect, studentId: studentId,authUid: authUid,authEmail: authEmail,);
  }
  
  
  AdminSetStudentStatusVariablesBuilder adminSetStudentStatus ({required String id, required String status, }) {
    return AdminSetStudentStatusVariablesBuilder(dataConnect, id: id,status: status,);
  }
  
  
  AdminCreateActivityVariablesBuilder adminCreateActivity ({required String nome, required String professor, required int vagas, }) {
    return AdminCreateActivityVariablesBuilder(dataConnect, nome: nome,professor: professor,vagas: vagas,);
  }
  
  
  AdminUpdateActivityVariablesBuilder adminUpdateActivity ({required String id, required String nome, required String professor, required int vagas, required String status, }) {
    return AdminUpdateActivityVariablesBuilder(dataConnect, id: id,nome: nome,professor: professor,vagas: vagas,status: status,);
  }
  
  
  AdminAssignActivityVariablesBuilder adminAssignActivity ({required String alunoId, required String atividadeId, }) {
    return AdminAssignActivityVariablesBuilder(dataConnect, alunoId: alunoId,atividadeId: atividadeId,);
  }
  
  
  AdminCreateScholarshipVariablesBuilder adminCreateScholarship ({required String nome, required double valorMensal, }) {
    return AdminCreateScholarshipVariablesBuilder(dataConnect, nome: nome,valorMensal: valorMensal,);
  }
  
  
  AdminUpdateScholarshipVariablesBuilder adminUpdateScholarship ({required String id, required String nome, required double valorMensal, required bool ativa, }) {
    return AdminUpdateScholarshipVariablesBuilder(dataConnect, id: id,nome: nome,valorMensal: valorMensal,ativa: ativa,);
  }
  
  
  AdminAssignScholarshipVariablesBuilder adminAssignScholarship ({required String alunoId, required String bolsaId, required double valorConcedido, }) {
    return AdminAssignScholarshipVariablesBuilder(dataConnect, alunoId: alunoId,bolsaId: bolsaId,valorConcedido: valorConcedido,);
  }
  
  
  AdminCreateAgendaEntryVariablesBuilder adminCreateAgendaEntry ({required String titulo, required Timestamp inicio, }) {
    return AdminCreateAgendaEntryVariablesBuilder(dataConnect, titulo: titulo,inicio: inicio,);
  }
  
  
  AdminUpdateAgendaEntryVariablesBuilder adminUpdateAgendaEntry ({required String id, required String titulo, required Timestamp inicio, required String status, }) {
    return AdminUpdateAgendaEntryVariablesBuilder(dataConnect, id: id,titulo: titulo,inicio: inicio,status: status,);
  }
  
  
  AdminCreateNotificationVariablesBuilder adminCreateNotification ({required String destinatarioUid, required String titulo, required String mensagem, }) {
    return AdminCreateNotificationVariablesBuilder(dataConnect, destinatarioUid: destinatarioUid,titulo: titulo,mensagem: mensagem,);
  }
  
  
  MarkMyNotificationReadVariablesBuilder markMyNotificationRead ({required String id, }) {
    return MarkMyNotificationReadVariablesBuilder(dataConnect, id: id,);
  }
  
  
  RegisterMyDonationVariablesBuilder registerMyDonation ({required double valor, }) {
    return RegisterMyDonationVariablesBuilder(dataConnect, valor: valor,);
  }
  
  
  AdminSetDonationStatusVariablesBuilder adminSetDonationStatus ({required String id, required String status, }) {
    return AdminSetDonationStatusVariablesBuilder(dataConnect, id: id,status: status,);
  }
  
  
  GetMyProfileVariablesBuilder getMyProfile () {
    return GetMyProfileVariablesBuilder(dataConnect, );
  }
  
  
  GetMyStudentVariablesBuilder getMyStudent () {
    return GetMyStudentVariablesBuilder(dataConnect, );
  }
  
  
  ListStudentsVariablesBuilder listStudents () {
    return ListStudentsVariablesBuilder(dataConnect, );
  }
  
  
  ListActivitiesVariablesBuilder listActivities () {
    return ListActivitiesVariablesBuilder(dataConnect, );
  }
  
  
  ListScholarshipsVariablesBuilder listScholarships () {
    return ListScholarshipsVariablesBuilder(dataConnect, );
  }
  
  
  ListMyActivitiesVariablesBuilder listMyActivities () {
    return ListMyActivitiesVariablesBuilder(dataConnect, );
  }
  
  
  ListMyScholarshipsVariablesBuilder listMyScholarships () {
    return ListMyScholarshipsVariablesBuilder(dataConnect, );
  }
  
  
  ListAgendaVariablesBuilder listAgenda () {
    return ListAgendaVariablesBuilder(dataConnect, );
  }
  
  
  GetMyNotificationsVariablesBuilder getMyNotifications () {
    return GetMyNotificationsVariablesBuilder(dataConnect, );
  }
  
  
  ListMyDonationsVariablesBuilder listMyDonations () {
    return ListMyDonationsVariablesBuilder(dataConnect, );
  }
  
  
  ListDonationsVariablesBuilder listDonations () {
    return ListDonationsVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'southamerica-east1',
    'example',
    'mb-tcc-2-service',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
