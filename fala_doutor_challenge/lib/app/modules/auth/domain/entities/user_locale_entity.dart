import 'package:equatable/equatable.dart';

class UserLocaleEntity extends Equatable {
  final String country;
  final String state;
  final String city;

  const UserLocaleEntity({
    required this.country,
    required this.state,
    required this.city,
  });

  @override
  List<Object?> get props => [country, state, city];

 }

