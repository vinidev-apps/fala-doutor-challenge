import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_locale_entity.dart';

class UserLocaleModel extends UserLocaleEntity {
  const UserLocaleModel({
    required super.country,
    required super.state,
    required super.city,
  });

  factory UserLocaleModel.fromMap(Map<String, dynamic> map) {
    return UserLocaleModel(
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'country': country, 'state': state, 'city': city};
  }

  // ENTITY CONVERSIONS
  factory UserLocaleModel.fromEntity(UserLocaleEntity entity) {
    return UserLocaleModel(
      country: entity.country,
      state: entity.state,
      city: entity.city,
    );
  }

  UserLocaleEntity toEntity() {
    return UserLocaleEntity(country: country, state: state, city: city);
  }
}
