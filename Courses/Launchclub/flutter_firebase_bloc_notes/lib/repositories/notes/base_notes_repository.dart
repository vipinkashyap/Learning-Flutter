import 'package:flutter_firebase_bloc_notes/repositories/base_repository.dart';

import '../../models/models.dart';

abstract class BaseNotesRepository extends BaseRepository {
  Future<Note> addNote({required Note note});
  Future<Note> updateNote({required Note note});
  Future<Note> deleteNote({required Note note});
  //We use streams for realtime changes
  Stream<List<Note>> streamNotes({required String userId});
}
