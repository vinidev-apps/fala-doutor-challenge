import 'package:equatable/equatable.dart';

class HealthPlanEntity extends Equatable {
  final String id;
  final String name;
  final String logoUrl;

  const HealthPlanEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  @override
  List<Object?> get props => [id, name, logoUrl];
}
