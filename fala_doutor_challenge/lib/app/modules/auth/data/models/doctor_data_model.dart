import 'package:fala_doutor_challenge/app/modules/auth/data/models/health_plan_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/doctor_data_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';

class DoctorDataModel extends DoctorDataEntity {
  const DoctorDataModel({
    required super.crm,
    required super.specialities,
    required super.healthPlans,
    required super.webAppointments,
  });

  factory DoctorDataModel.fromMap(Map<String, dynamic> map) {
    return DoctorDataModel(
      crm: map['crm'] ?? '',
      specialities: List<String>.from(map['specialities'] ?? []),
      healthPlans: (map['health_plans'] as List<dynamic>? ?? [])
          .map((p) => HealthPlanModel.fromMap(p))
          .toList(),
      webAppointments: map['web_appointments'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'crm': crm,
      'specialities': specialities,
      'health_plans': healthPlans
          .map((p) => (p as HealthPlanModel).toMap())
          .toList(),
      'web_appointments': webAppointments,
    };
  }

  // ENTITY CONVERSIONS
  factory DoctorDataModel.fromEntity(DoctorDataEntity entity) {
    return DoctorDataModel(
      crm: entity.crm,
      specialities: List<String>.from(entity.specialities),
      healthPlans: entity.healthPlans
          .map((hp) => HealthPlanModel.fromEntity(hp))
          .toList(),
      webAppointments: entity.webAppointments,
    );
  }

  DoctorDataEntity toEntity() {
    final List<HealthPlanEntity> hps = healthPlans
        .map((p) => (p as HealthPlanModel).toEntity())
        .toList();

    return DoctorDataEntity(
      crm: crm,
      specialities: List<String>.from(specialities),
      healthPlans: hps,
      webAppointments: webAppointments,
    );
  }
}
