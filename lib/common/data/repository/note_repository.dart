import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class NoteRepository {
  NoteRepository._(this.database);

  static const tableName = 'notes';

  final Database database;

  static Future<NoteRepository> open() async {
    final database = await openDatabase(
      '${await getDatabasesPath()}/notes.db',
      version: 1,
      onCreate: (db, version) => db.execute(
        '''
        create table $tableName(
        ${NoteFields.id} integer primary key autoincrement,
        ${NoteFields.date} integer,
        ${NoteFields.starred} boolean,
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
        orderBy: '${NoteFields.date} DESC',
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
      );
}
