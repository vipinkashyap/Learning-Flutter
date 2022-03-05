import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String email;
  const UserEntity({this.id, required this.email});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, email];

//Write object to db
  Map<String, dynamic> toDocument() {
    return {
      'email': email,
    };
  }

  // Read object from db
  factory UserEntity.fromSnapshot(DocumentSnapshot doc) {
    return UserEntity(
      id: doc.id,
      email: doc.get('email') ?? '',
    );
  }
}
