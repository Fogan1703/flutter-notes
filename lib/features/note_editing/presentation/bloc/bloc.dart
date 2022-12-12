part of '../bloc.dart';

class NoteEditingBloc extends Bloc<NoteEditingEvent, Note> {
  NoteEditingBloc({
    required Note note,
    required NoteRepository noteRepository,
  })  : _initialNote = note,
        _noteRepository = noteRepository,
        super(note) {
    on<NoteEditingSaveEvent>((event, emit) {
      _save();
    });

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
  final NoteRepository _noteRepository;

  Future<void> _save() async {
    if (_initialNote != state) {
      if (state.id == null) {
        await _noteRepository.insert(state);
      } else {
        await _noteRepository.update(state);
      }
    }
    await _noteRepository.sendUpdatedData();
  }

  @override
  Future<void> close() async {
    await _save();
    return super.close();
  }
}
