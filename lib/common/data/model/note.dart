import 'package:equatable/equatable.dart';

import '../util/content_parser.dart';

part 'check_item.dart';

class NoteFields {
  NoteFields._();

  static const id = 'id';
  static const edited = 'edited';
  static const starred = 'starred';
  static const title = 'title';
  static const content = 'content';
}

class Note extends Equatable {
  const Note({
    this.id,
    required this.edited,
    required this.starred,
    required this.title,
    required this.content,
  });

  final int? id;
  final DateTime edited;
  final bool starred;
  final String title;
  final List<Object> content;

  @override
  List<Object?> get props => [id, edited, starred, title, content];

  factory Note.fromJson(Map<String, Object?> data) => Note(
        id: data[NoteFields.id] as int,
        edited: DateTime.fromMillisecondsSinceEpoch(data[NoteFields.edited] as int),
        starred: data[NoteFields.starred] == 1,
        title: data[NoteFields.title] as String,
        content: ContentParser.parseContent(data[NoteFields.content] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.edited: edited.millisecondsSinceEpoch,
        NoteFields.starred: starred ? 1 : 0,
        NoteFields.title: title,
        NoteFields.content: ContentParser.contentToString(content),
      };
}
