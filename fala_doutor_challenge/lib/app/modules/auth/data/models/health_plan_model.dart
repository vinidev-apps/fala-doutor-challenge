import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';

class HealthPlanModel extends HealthPlanEntity {
  const HealthPlanModel({
    required super.id,
    required super.name,
    required super.logoUrl,
  });

  factory HealthPlanModel.fromMap(Map<String, dynamic> map) {
    return HealthPlanModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      logoUrl: map['logo_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'logo_url': logoUrl};
  }

  // ENTITY CONVERSIONS
  factory HealthPlanModel.fromEntity(HealthPlanEntity entity) {
    return HealthPlanModel(
      id: entity.id,
      name: entity.name,
      logoUrl: entity.logoUrl,
    );
  }

  HealthPlanEntity toEntity() {
    return HealthPlanEntity(id: id, name: name, logoUrl: logoUrl);
  }
}
