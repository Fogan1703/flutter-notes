import 'package:flutter/material.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/features/note_editing/presentation/screen.dart';

class NoteListFloatingActionButton extends StatelessWidget {
  const NoteListFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NoteEditingScreen(
            note: Note.empty(),
          ),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }
}
