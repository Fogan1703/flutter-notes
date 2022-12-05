import 'package:equatable/equatable.dart';

import '../util/content_parser.dart';

part 'check_item.dart';

class NoteFields {
  NoteFields._();

  static const id = 'id';
  static const date = 'date';
  static const starred = 'starred';
  static const title = 'title';
  static const content = 'content';
}

class Note extends Equatable {
  const Note({
    this.id,
    required this.date,
    required this.starred,
    required this.title,
    required this.content,
  });

  final int? id;
  final DateTime date;
  final bool starred;
  final String title;
  final List<Object> content;

  @override
  List<Object?> get props => [id, date, starred, title, content];

  factory Note.fromJson(Map<String, Object?> data) => Note(
        id: data[NoteFields.id] as int,
        date: DateTime.fromMillisecondsSinceEpoch(data[NoteFields.date] as int),
        starred: data[NoteFields.starred] == 1,
        title: data[NoteFields.title] as String,
        content: ContentParser.parseContent(data[NoteFields.content] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.date: date.millisecondsSinceEpoch,
        NoteFields.starred: starred ? 1 : 0,
        NoteFields.title: title,
        NoteFields.content: ContentParser.contentToString(content),
      };
}
