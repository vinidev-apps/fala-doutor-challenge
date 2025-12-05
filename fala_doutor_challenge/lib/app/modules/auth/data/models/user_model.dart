import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fala_doutor_challenge/app/modules/auth/data/models/doctor_data_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/data/models/patient_data_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/data/models/user_locale_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.type,
    required super.name,
    required super.email,
    required super.phone,
    required super.birthDate,
    required super.sex,
    required super.cpf,
    required super.avatarUrl,
    required super.userLocale,
    required super.patientData,
    required super.doctorData,
    required super.emailVerified,
    required super.createdAt,
    required super.updatedAt,
  });

  // FROM MAP
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      birthDate: (map['birth_date'] as Timestamp).toDate(),
      sex: map['sex'] ?? '',
      cpf: map['cpf'] ?? '',
      avatarUrl: map['avatar_url'],
      userLocale: UserLocaleModel.fromMap(map['user_locale']),

      patientData: map['patient_data'] != null
          ? PatientDataModel.fromMap(map['patient_data'])
          : null,

      doctorData: map['doctor_data'] != null
          ? DoctorDataModel.fromMap(map['doctor_data'])
          : null,

      emailVerified: map['email_verified'] ?? false,
      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
    );
  }

  // TO MAP
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'email': email,
      'phone': phone,
      'birth_date': Timestamp.fromDate(birthDate),
      'sex': sex,
      'cpf': cpf,
      'avatar_url': avatarUrl,
      'user_locale': (userLocale as UserLocaleModel).toMap(),
      'patient_data': patientData != null
          ? (patientData as PatientDataModel).toMap()
          : null,
      'doctor_data': doctorData != null
          ? (doctorData as DoctorDataModel).toMap()
          : null,
      'email_verified': emailVerified,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }

  // ENTITY CONVERSIONS
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      type: entity.type,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      birthDate: entity.birthDate,
      sex: entity.sex,
      cpf: entity.cpf ?? '',
      avatarUrl: entity.avatarUrl,
      userLocale: UserLocaleModel.fromEntity(entity.userLocale),
      patientData: entity.patientData != null
          ? PatientDataModel.fromEntity(entity.patientData!)
          : null,
      doctorData: entity.doctorData != null
          ? DoctorDataModel.fromEntity(entity.doctorData!)
          : null,
      emailVerified: entity.emailVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      type: type,
      name: name,
      email: email,
      phone: phone,
      birthDate: birthDate,
      sex: sex,
      cpf: cpf,
      avatarUrl: avatarUrl,
      userLocale: (userLocale as UserLocaleModel).toEntity(),
      patientData: patientData != null
          ? (patientData as PatientDataModel).toEntity()
          : null,
      doctorData: doctorData != null
          ? (doctorData as DoctorDataModel).toEntity()
          : null,
      emailVerified: emailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Optional helper to build UserModel straight from DocumentSnapshot
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(map, doc.id);
  }
}
