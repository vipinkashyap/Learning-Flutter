import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../entities/entities.dart';

class Note extends Equatable {
  final String? id;
  final String userId;
  final String content;
  final Color
      color; // Noteentity to color conversion since we can't store a color type
  final DateTime timestamp; // We want to convert from firestore timestsamp

  const Note({
    this.id,
    required this.userId,
    required this.content,
    required this.color,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, userId, content, color, timestamp];

  @override
  bool? get stringify => true;

  NoteEntity toEntity() {
    return NoteEntity(
        userId: userId,
        content: content,
        color:
            '#${color.value.toRadixString(16)}', // Convert color to hexcode white -> #FFFFFF
        timestamp: Timestamp.fromDate(timestamp));
  }

  factory Note.fromEntity(NoteEntity entity) {
    return Note(
      id: entity.id!,
      userId: entity.userId,
      content: entity.content,
      color: HexColor(entity.color),
      timestamp: entity.timestamp.toDate(),
    );
  }

  //To edit value of the existing note its easier to use the copyWith method
  Note copyWith(
      {String? id,
      String? userId,
      String? content,
      Color? color,
      DateTime? timestamp}) {
    return Note(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        content: content ?? this.content,
        color: color ?? this.color,
        timestamp: timestamp ?? this.timestamp);
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String value) {
    value = value.toUpperCase().replaceAll('#', '');
    if (value.length == 6) {
      value = 'FF' + value;
    }
    return int.parse(value, radix: 16);
  }
}
