import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../util/content_parser.dart';

part 'check_item.dart';

part 'note_color.dart';

class NoteFields {
  NoteFields._();

  static const id = 'id';
  static const edited = 'edited';
  static const starred = 'starred';
  static const color = 'color';
  static const title = 'title';
  static const content = 'content';
}

class Note extends Equatable {
  const Note({
    this.id,
    required this.edited,
    required this.starred,
    required this.color,
    required this.title,
    required this.content,
  });

  factory Note.empty() => Note(
        edited: DateTime.now(),
        starred: false,
        color: null,
        title: '',
        content: const [],
      );

  final int? id;
  final DateTime edited;
  final bool starred;
  final NoteColor? color;
  final String title;
  final List<Object> content;

  @override
  List<Object?> get props => [id, edited, starred, color, title, content];

  factory Note.fromJson(Map<String, Object?> data) => Note(
        id: data[NoteFields.id] as int,
        edited:
            DateTime.fromMillisecondsSinceEpoch(data[NoteFields.edited] as int),
        starred: data[NoteFields.starred] == 1,
        color: NoteColor.parse(data[NoteFields.color] as String),
        title: data[NoteFields.title] as String,
        content: ContentParser.parseContent(data[NoteFields.content] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.edited: edited.millisecondsSinceEpoch,
        NoteFields.starred: starred ? 1 : 0,
        NoteFields.color: color.toString(),
        NoteFields.title: title,
        NoteFields.content: ContentParser.contentToString(content),
      };
}
