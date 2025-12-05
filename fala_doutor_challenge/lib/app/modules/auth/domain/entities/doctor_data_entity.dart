import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';

class DoctorDataEntity extends Equatable {
  final String crm;
  final List<String> specialities;
  final List<HealthPlanEntity> healthPlans;
  final bool webAppointments;

  const DoctorDataEntity({
    required this.crm,
    required this.specialities,
    required this.healthPlans,
    required this.webAppointments,
  });

  @override
  List<Object?> get props => [crm, specialities, healthPlans, webAppointments];
}
