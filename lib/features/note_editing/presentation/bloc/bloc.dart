part of '../bloc.dart';

class NoteEditingBloc extends Bloc<NoteEditingEvent, Note> {
  NoteEditingBloc({required Note note}) : super(note);
}
