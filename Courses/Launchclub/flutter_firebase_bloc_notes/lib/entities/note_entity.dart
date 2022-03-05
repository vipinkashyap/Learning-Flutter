import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEntity extends Equatable {
  final String? id;
  final String userId;
  final String content;
  final String color;
  final Timestamp timestamp; //firestore specific representation

  const NoteEntity(
      {this.id,
      required this.userId,
      required this.content,
      required this.color,
      required this.timestamp});

  @override
  List<Object?> get props => [id, userId, content, color, timestamp];

  @override
  bool? get stringify => true;

  // We don't have id here because the doc in db doesn't have id as a field
  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'content': content,
      'color': color,
      'timestamp': timestamp,
    };
  }

  factory NoteEntity.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteEntity(
        id: doc.id,
        userId: data['userId'] ?? '',
        content: data['content'] ?? '',
        color: data['color'] ?? '#FFFFFF',
        timestamp: data['timestamp'] ?? '');
  }
}
