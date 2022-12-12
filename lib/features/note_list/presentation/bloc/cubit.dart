import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/common/data/repository/note_repository.dart';

part 'state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  NoteListCubit({required this.noteRepository})
      : super(
          const NoteListState(
            loading: true,
            notes: [],
            displayingNotes: [],
            searchQuery: null,
          ),
        ) {
    noteRepository.notesStream.listen(
      (notes) => emit(
        state.copyWith(
          loading: false,
          notes: notes,
          displayingNotes: notes,
        ),
      ),
    );
    noteRepository.sendUpdatedData();
  }

  final NoteRepository noteRepository;

  late final StreamSubscription _subscription;

  void startSearch() {
    search('');
  }

  void stopSearch() {
    emit(state.copyWith(
      searchQuery: () => null,
      displayingNotes: state.notes,
    ));
  }

  void search(String query) {
    query = query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        searchQuery: () => query,
        displayingNotes: state.notes,
      ));
      return;
    }

    emit(state.copyWith(
      searchQuery: () => query,
      displayingNotes: state.notes
          .where(
            (note) =>
                note.title.toLowerCase().contains(query) ||
                note.content
                    .whereType<String>()
                    .any((text) => text.toLowerCase().contains(query)) ||
                note.content
                    .whereType<CheckItem>()
                    .any((note) => note.text.toLowerCase().contains(query)),
          )
          .toList(),
    ));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
