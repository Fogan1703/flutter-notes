part of '../note_list_cubit.dart';

class NoteListCubit extends Cubit<NoteListState> {
  NoteListCubit({required this.noteRepository})
      : super(
          const NoteListState(
            loading: true,
            notes: [],
          ),
        ) {
    noteRepository.getAll().then(
          (notes) => emit(
            state.copyWith(
              loading: false,
              notes: notes,
            ),
          ),
        );
  }

  final NoteRepository noteRepository;
}
