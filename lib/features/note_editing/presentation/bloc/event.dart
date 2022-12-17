part of '../bloc.dart';

abstract class NoteEditingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteEditingSaveEvent extends NoteEditingEvent {}

class NoteEditingEditEvent extends NoteEditingEvent {}

class NoteEditingStopEditingEvent extends NoteEditingEvent {}

class NoteEditingOnReorderEvent extends NoteEditingEvent {
  NoteEditingOnReorderEvent(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => [...super.props, oldIndex, newIndex];
}

class NoteEditingTitleChangedEvent extends NoteEditingEvent {
  NoteEditingTitleChangedEvent(this.value);

  final String? value;

  @override
  List<Object?> get props => [...super.props, value];
}

class NoteEditingItemChangedEvent extends NoteEditingEvent {
  NoteEditingItemChangedEvent(this.index, this.value);

  final int index;
  final Object? value;

  @override
  List<Object?> get props => [...super.props, index, value];
}

class NoteEditingAddItemEvent extends NoteEditingEvent {
  NoteEditingAddItemEvent(this.item, {this.index});

  final Object item;
  final int? index;

  @override
  List<Object?> get props => [...super.props, item, index];
}
