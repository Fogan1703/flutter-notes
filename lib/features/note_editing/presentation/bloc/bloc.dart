part of '../bloc.dart';

class NoteEditingBloc extends Bloc<NoteEditingEvent, NoteEditingState> {
  NoteEditingBloc({
    required Note note,
    required NoteRepository noteRepository,
  })  : _initialNote = note,
        _noteRepository = noteRepository,
        super(NoteEditingState(
          note: note,
          editing: false,
        )) {
    on<NoteEditingSaveEvent>((event, emit) {
      _save();
    });

    on<NoteEditingEditEvent>((event, emit) {
      emit(state.copyWith(editing: true));
    });

    on<NoteEditingStopEditingEvent>((event, emit) {
      emit(state.copyWith(editing: false));
    });

    on<NoteEditingTitleChangedEvent>((event, emit) {
      emit(state.copyWith(note: state.note.copyWith(title: event.value)));
    });

    on<NoteEditingOnReorderEvent>((event, emit) {
      // TODO: normal reordering
      final content = List<Object>.from(state.note.content);
      var newIndex = event.newIndex;
      if (event.oldIndex < newIndex) {
        newIndex--;
      }
      final item = content.removeAt(event.oldIndex);
      content.insert(newIndex, item);
      emit(state.copyWith(note: state.note.copyWith(content: content)));
    });

    on<NoteEditingItemChangedEvent>((event, emit) {
      final content = List<Object>.from(state.note.content);
      if (event.value == null) {
        content.removeAt(event.index);
      } else {
        content[event.index] = event.value!;
      }
      emit(state.copyWith(note: state.note.copyWith(content: content)));
    });

    on<NoteEditingAddItemEvent>((event, emit) {
      final content = List<Object>.from(state.note.content);
      final last = content.last;
      final insertBefore = last is String && last.isEmpty;
      content.insert(
        event.index ?? (insertBefore ? content.length - 1 : content.length),
        event.item,
      );
      if (!insertBefore) {
        content.add('');
      }
      emit(state.copyWith(note: state.note.copyWith(content: content)));
    });
  }

  final Note _initialNote;
  final NoteRepository _noteRepository;

  Future<void> _save() async {
    if (_initialNote != state) {
      if (state.note.id == null) {
        await _noteRepository.insert(state.note);
      } else {
        await _noteRepository.update(state.note);
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
