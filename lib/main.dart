import 'package:flutter/material.dart';

import 'app.dart';
import 'common/data/repository/note_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final noteRepository = await NoteRepository.open();

  runApp(
    App(
      noteRepository: noteRepository,
    ),
  );
}
