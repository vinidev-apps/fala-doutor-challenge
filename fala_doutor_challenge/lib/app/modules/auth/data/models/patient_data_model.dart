import 'package:fala_doutor_challenge/app/modules/auth/data/models/user_health_plan_data_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/patient_data_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_health_plan_data_entity.dart';

class PatientDataModel extends PatientDataEntity {
  const PatientDataModel({
    required super.hasHealthPlan,
    required super.userHealthPlans,
  });

  factory PatientDataModel.fromMap(Map<String, dynamic> map) {
    return PatientDataModel(
      hasHealthPlan: map['has_health_plan'] ?? false,
      userHealthPlans: (map['user_health_plans'] as List<dynamic>? ?? [])
          .map((p) => UserHealthPlanDataModel.fromMap(p))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'has_health_plan': hasHealthPlan,
      'user_health_plans': userHealthPlans
          .map((p) => (p as UserHealthPlanDataModel).toMap())
          .toList(),
    };
  }

  // ENTITY CONVERSIONS
  factory PatientDataModel.fromEntity(PatientDataEntity entity) {
    // assume entity.healthPlan is HealthPlanEntity
    return PatientDataModel(
      hasHealthPlan: entity.hasHealthPlan,
      userHealthPlans: entity.userHealthPlans
          .map((hp) => UserHealthPlanDataModel.fromEntity(hp))
          .toList(),
    );
  }

  PatientDataEntity toEntity() {
    final List<UserHealthPlanDataEntity> hps = userHealthPlans
        .map((p) => (p as UserHealthPlanDataModel).toEntity())
        .toList();

    return PatientDataEntity(
      hasHealthPlan: hasHealthPlan,
      userHealthPlans: hps,
    );
  }
}
