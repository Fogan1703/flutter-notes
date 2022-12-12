part of '../bloc.dart';

class NoteEditingBloc extends Bloc<NoteEditingEvent, Note> {
  NoteEditingBloc({required Note note})
      : _initialNote = note,
        super(note) {
    on<NoteEditingTitleChangedEvent>((event, emit) {
      emit(note.copyWith(title: event.value));
    });

    on<NoteEditingItemChangedEvent>((event, emit) {
      final content = List<Object>.from(state.content);
      if (event.value == null) {
        content.removeAt(event.index);
      } else {
        content[event.index] = event.value!;
      }
      emit(note.copyWith(content: content));
    });

    on<NoteEditingAddItemEvent>((event, emit) {
      final content = List<Object>.from(state.content);
      final last = content.last;
      content.insert(
        event.index ??
            (last is String && last.isEmpty
                ? content.length - 1
                : content.length),
        event.item,
      );
      emit(note.copyWith(content: content));
    });
  }

  final Note _initialNote;
}
