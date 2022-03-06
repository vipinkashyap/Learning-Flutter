part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

//Will run when app first loads
class FetchNotes extends NotesEvent {}

// When user updates, deletes a note
class UpdateNotes extends NotesEvent {
  // List of notes to update to
  final List<Note> notes;

  const UpdateNotes({required this.notes});

  @override
  List<Object> get props => [notes];

  @override
  bool? get stringify => true;
}
