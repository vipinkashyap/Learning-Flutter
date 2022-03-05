import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class User extends Equatable {
  final String id;
  final String email;

  const User({
    required this.id,
    required this.email,
  });

  @override
  List<Object> get props => [id, email];

  @override
  bool? get stringify => true;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
    );
  }

  factory User.fromEntity(UserEntity entity) {
    return User(id: entity.id!, email: entity.email);
  }
}
