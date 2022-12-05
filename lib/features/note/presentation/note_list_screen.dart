import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/note_repository.dart';
import 'bloc/note_list_cubit.dart';
import 'widgets/app_bar.dart';
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
            body: NoteList(grid: _grid),
          );
        },
      ),
    );
  }
}
