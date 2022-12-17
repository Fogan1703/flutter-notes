part of '../bloc.dart';

class NoteEditingState extends Equatable {
  const NoteEditingState({
    required this.note,
    required this.editing,
  });

  final Note note;
  final bool editing;

  @override
  List<Object?> get props => [note, editing];

  NoteEditingState copyWith({
    Note? note,
    bool? editing,
  }) {
    return NoteEditingState(
      note: note ?? this.note,
      editing: editing ?? this.editing,
    );
  }
}
