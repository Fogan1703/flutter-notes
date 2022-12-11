part of 'cubit.dart';

class NoteListState extends Equatable {
  const NoteListState({
    required this.loading,
    required this.notes,
    required this.searchQuery,
    required this.displayingNotes,
  });

  final bool loading;
  final List<Note> notes;
  final String? searchQuery;
  final List<Note> displayingNotes;

  bool get searching => searchQuery != null;

  @override
  List<Object?> get props => [loading, notes, searchQuery, displayingNotes];

  NoteListState copyWith({
    bool? loading,
    List<Note>? notes,
    String? Function()? searchQuery,
    List<Note>? displayingNotes,
  }) =>
      NoteListState(
        loading: loading ?? this.loading,
        notes: notes ?? this.notes,
        searchQuery: searchQuery != null ? searchQuery() : this.searchQuery,
        displayingNotes: displayingNotes ?? this.notes,
      );
}
