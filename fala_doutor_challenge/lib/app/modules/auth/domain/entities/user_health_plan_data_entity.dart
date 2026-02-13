import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';

class UserHealthPlanDataEntity extends Equatable {
  final HealthPlanEntity healthPlan;
  final String healthPlanCode;

  const UserHealthPlanDataEntity({
    required this.healthPlan,
    required this.healthPlanCode,
  });

  @override
  List<Object?> get props => [healthPlan, healthPlanCode];
}
