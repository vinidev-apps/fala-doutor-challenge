import 'package:equatable/equatable.dart';

class HealthPlanEntity extends Equatable {
  final String id;
  final String displayName;
  final String name;
  final String type;
  final String group;
  final String logoUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const HealthPlanEntity({
    required this.id,
    required this.displayName,
    required this.name,
    required this.type,
    required this.group,
    required this.logoUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    displayName,
    name,
    type,
    group,
    logoUrl,
    isActive,
    createdAt,
    updatedAt,
  ];
}
