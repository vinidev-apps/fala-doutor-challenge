import 'package:fala_doutor_challenge/app/modules/auth/data/models/health_plan_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_health_plan_data_entity.dart';

class UserHealthPlanDataModel extends UserHealthPlanDataEntity {
  const UserHealthPlanDataModel({
    required super.healthPlan,
    required super.healthPlanCode,
  });

  factory UserHealthPlanDataModel.fromMap(Map<String, dynamic> map) {
    return UserHealthPlanDataModel(
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
  factory UserHealthPlanDataModel.fromEntity(UserHealthPlanDataEntity entity) {
    // assume entity.healthPlan is HealthPlanEntity

    return UserHealthPlanDataModel(
      healthPlan: HealthPlanModel.fromEntity(entity.healthPlan),
      healthPlanCode: entity.healthPlanCode,
    );
  }

  UserHealthPlanDataEntity toEntity() {
    final hp = (healthPlan as HealthPlanModel).toEntity();
    
    return UserHealthPlanDataEntity(
      healthPlan: hp,
      healthPlanCode: healthPlanCode,
    );
  }
}
