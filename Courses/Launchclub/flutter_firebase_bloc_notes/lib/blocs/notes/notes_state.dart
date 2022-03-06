part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

//When loading notes
class NotesLoading extends NotesState {}

//When notes loaded
class NotesLoaded extends NotesState {
  final List<Note> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];

  @override
  bool? get stringify => true;
}

//When notes loaded
class NotesError extends NotesState {}
