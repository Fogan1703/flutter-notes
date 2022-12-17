import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/common/data/repository/note_repository.dart';

import 'bloc.dart';
import 'widgets/app_bar.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/content.dart';

class NoteEditingScreen extends StatelessWidget {
  const NoteEditingScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteEditingBloc(
        note: note,
        noteRepository: context.read<NoteRepository>(),
      ),
      child: Builder(
        builder: (context) {
          return BlocSelector<NoteEditingBloc, NoteEditingState, Color?>(
            selector: (state) => state.note.color != null
                ? Color(state.note.color!.value)
                : null,
            builder: (context, color) => Scaffold(
              backgroundColor: color,
              appBar: const NoteEditingAppBar(),
              body: Column(
                children: const [
                  Expanded(
                    child: NoteEditingContent(),
                  ),
                  NoteEditingBottomBar(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
