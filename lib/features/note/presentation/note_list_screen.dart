import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_notes/common/presentation/widgets/animated_switchers.dart';

import '../data/repository/note_repository.dart';
import 'bloc/note_list_cubit.dart';
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
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => NoteListCubit(
        noteRepository: context.read<NoteRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.appName),
          actions: [
            FadeScaleAnimatedSwitcher(
              child: _grid
                  ? IconButton(
                      key: const ValueKey(true),
                      onPressed: () => setState(() => _grid = false),
                      icon: const Icon(Icons.view_agenda_outlined),
                    )
                  : IconButton(
                      key: const ValueKey(false),
                      onPressed: () => setState(() => _grid = true),
                      icon: const Icon(Icons.grid_view_outlined),
                    ),
            ),
          ],
        ),
        body: NoteList(grid: _grid),
      ),
    );
  }
}
