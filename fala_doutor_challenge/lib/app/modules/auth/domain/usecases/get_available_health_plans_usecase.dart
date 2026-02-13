import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class GetAvailableHealthPlansUsecase {
  final AuthRepository repository;

  GetAvailableHealthPlansUsecase(this.repository);

  Future<List<HealthPlanEntity>?> call() async {
    return await repository.getAvailableHealthPlans();
  }
}
