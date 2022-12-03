import 'package:flutter/material.dart';

import 'app.dart';
import 'features/note/data/repository/note_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final noteRepository = await NoteRepository.open();
  // noteRepository.insert(
  //   Note(
  //     date: DateTime.now(),
  //     starred: false,
  //     title: 'This is a new note',
  //     content: const [
  //       CheckItem(
  //         'Some text for a check item',
  //         false,
  //       ),
  //       CheckItem(
  //         'And this is another check item, that is checked',
  //         true,
  //       ),
  //     ],
  //   ),
  // );

  runApp(
    App(
      noteRepository: noteRepository,
    ),
  );
}
