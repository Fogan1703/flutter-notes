import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class NoteRepository {
  NoteRepository._(this.database);

  static const tableName = 'notes';

  Stream<List<Note>> get notesStream => _controller.stream;

  final Database database;

  final _controller = StreamController<List<Note>>.broadcast();

  static Future<NoteRepository> open() async {
    final database = await openDatabase(
      '${await getDatabasesPath()}/notes.db',
      version: 1,
      onCreate: (db, version) => db.execute(
        '''
        create table $tableName(
        ${NoteFields.id} integer primary key autoincrement,
        ${NoteFields.edited} integer,
        ${NoteFields.starred} boolean,
        ${NoteFields.color} integer,
        ${NoteFields.title} text,
        ${NoteFields.content} text
        )
        ''',
      ),
    );
    return NoteRepository._(database);
  }

  void dispose() {
    database.close();
  }

  Future<List<Note>> getAll() => database
      .query(
        tableName,
        orderBy: '${NoteFields.edited} DESC',
      )
      .then(
        (value) => value.map((data) => Note.fromJson(data)).toList(),
      );

  Future<int> insert(Note note) => database.insert(
        tableName,
        note.toJson(),
      );

  Future<int> update(Note note) => database.update(
        tableName,
        note.toJson(),
        where: '${NoteFields.id} = ?',
        whereArgs: [note.id],
      );

  Future<List<Note>> sendUpdatedData() async {
    final data = await getAll();
    _controller.add(data);
    return data;
  }
}
