import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_bloc_notes/repositories/auth/auth_repository.dart';
import 'package:flutter_firebase_bloc_notes/repositories/notes/notes_repository.dart';

import '../../models/models.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AuthRepository _authRepository;
  final NotesRepository _notesRepository;
  StreamSubscription? _notesSubscription;
  NotesBloc({
    required AuthRepository authRepository,
    required NotesRepository notesRepository,
  })  : _authRepository = authRepository,
        _notesRepository = notesRepository,
        super(NotesInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<UpdateNotes>(_onUpdateNotes);
  }
  _onFetchNotes(FetchNotes event, emit) async* {
    yield NotesLoading();

    try {
      final currentUser = await _authRepository.getCurrentUser();
      _notesSubscription?.cancel(); // If streamsubscription is null dont cancel
      _notesSubscription = _notesRepository
          .streamNotes(userId: currentUser!.id)
          .listen((notes) => add(UpdateNotes(notes: notes)));
    } catch (err) {
      log(err.toString());
    }
  }

  _onUpdateNotes(UpdateNotes event, emit) async* {
    yield NotesLoaded(notes: event.notes);
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
