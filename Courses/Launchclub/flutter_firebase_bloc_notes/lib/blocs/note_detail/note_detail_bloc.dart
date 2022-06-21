import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'note_detail_event.dart';
part 'note_detail_state.dart';

class NoteDetailBloc extends Bloc<NoteDetailEvent, NoteDetailState> {
  NoteDetailBloc() : super(NoteDetailInitial()) {
    on<NoteDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
