import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_health_plan_data_entity.dart';

class PatientDataEntity extends Equatable {
  final bool hasHealthPlan;
  final List<UserHealthPlanDataEntity> userHealthPlans;

  const PatientDataEntity({
    required this.hasHealthPlan,
    required this.userHealthPlans,
  });

  @override
  List<Object?> get props => [hasHealthPlan, userHealthPlans];
}
