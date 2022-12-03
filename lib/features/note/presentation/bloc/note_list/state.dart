part of '../note_list_cubit.dart';

class NoteListState extends Equatable {
  const NoteListState({
    required this.loading,
    required this.notes,
  });

  final bool loading;
  final List<Note> notes;

  @override
  List<Object?> get props => [loading, notes];

  NoteListState copyWith({
    bool? loading,
    List<Note>? notes,
  }) =>
      NoteListState(
        loading: loading ?? this.loading,
        notes: notes ?? this.notes,
      );
}
