import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/doctor_data_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/patient_data_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_locale_entity.dart';

class UserEntity extends Equatable {
  final String id; // ID aleatório do Firebase
  final String type; // "patient" | "doctor"
  final String name; // Nome completo
  final String email; // Email
  final String? phone; // Telefone com DDD
  final DateTime birthDate; // Data de nascimento
  final String sex; // "masculino" | "feminino"
  final String? cpf; // CPF
  final String? avatarUrl; // URL da foto de perfil
  final UserLocaleEntity userLocale; // Classe
  final PatientDataEntity? patientData; // Se for doctor, vai vir nulo
  final DoctorDataEntity? doctorData; // Se for patient, vai vir nulo
  final bool emailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.sex,
    required this.cpf,
    required this.avatarUrl,
    required this.userLocale,
    required this.patientData,
    required this.doctorData,
    required this.emailVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    name,
    email,
    phone,
    birthDate,
    sex,
    cpf,
    avatarUrl,
    userLocale,
    patientData,
    doctorData,
    emailVerified,
    createdAt,
    updatedAt,
  ];
}
