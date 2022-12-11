import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/repository/note_repository.dart';

import 'bloc/cubit.dart';
import 'widgets/app_bar.dart';
import 'widgets/floating_action_button.dart';
import 'widgets/note_list.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  var _grid = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteListCubit(
        noteRepository: context.read<NoteRepository>(),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: NoteListAppBar(
              grid: _grid,
              gridChanged: (value) => setState(() => _grid = value),
            ),
            floatingActionButton: const NoteListFloatingActionButton(),
            body: NoteList(grid: _grid),
          );
        },
      ),
    );
  }
}
