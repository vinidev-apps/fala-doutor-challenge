import 'package:fala_doutor_challenge/app/modules/auth/data/models/health_plan_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/patient_data_entity.dart';

class PatientDataModel extends PatientDataEntity {
  const PatientDataModel({
    required super.healthPlan,
    required super.healthPlanCode,
  });

  factory PatientDataModel.fromMap(Map<String, dynamic> map) {
    return PatientDataModel(
      healthPlan: HealthPlanModel.fromMap(map['health_plan']),
      healthPlanCode: map['health_plan_code'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'health_plan': (healthPlan as HealthPlanModel).toMap(),
      'health_plan_code': healthPlanCode,
    };
  }

  // ENTITY CONVERSIONS
  factory PatientDataModel.fromEntity(PatientDataEntity entity) {
    // assume entity.healthPlan is HealthPlanEntity
    return PatientDataModel(
      healthPlan: HealthPlanModel.fromEntity(entity.healthPlan),
      healthPlanCode: entity.healthPlanCode,
    );
  }

  PatientDataEntity toEntity() {
    final HealthPlanEntity hp = (healthPlan as HealthPlanModel).toEntity();
    return PatientDataEntity(healthPlan: hp, healthPlanCode: healthPlanCode);
  }
}
