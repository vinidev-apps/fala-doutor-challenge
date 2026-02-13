import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';

class HealthPlanModel extends HealthPlanEntity {
  const HealthPlanModel({
    required super.id,
    required super.displayName,
    required super.name,
    required super.type,
    required super.group,
    required super.logoUrl,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory HealthPlanModel.fromMap(Map<String, dynamic> map) {
    return HealthPlanModel(
      id: map['id'] ?? '',
      displayName: map['display_name'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      group: map['group'] ?? '',
      logoUrl: map['logo_url'] ?? '',
      isActive: map['is_active'] ?? true,
      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'logo_url': logoUrl};
  }

  // ENTITY CONVERSIONS
  factory HealthPlanModel.fromEntity(HealthPlanEntity entity) {
    return HealthPlanModel(
      id: entity.id,
      displayName: entity.displayName,
      name: entity.name,
      type: entity.type,
      group: entity.group,
      logoUrl: entity.logoUrl,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  HealthPlanEntity toEntity() {
    return HealthPlanEntity(
      id: id,
      displayName: displayName,
      name: name,
      type: type,
      group: group,
      logoUrl: logoUrl,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
