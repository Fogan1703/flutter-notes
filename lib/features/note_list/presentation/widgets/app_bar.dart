import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_notes/common/presentation/widgets/animated_switchers.dart';

import '../bloc/cubit.dart';

class NoteListAppBar extends StatelessWidget with PreferredSizeWidget {
  const NoteListAppBar({
    Key? key,
    required this.grid,
    required this.gridChanged,
  }) : super(key: key);

  final bool grid;
  final ValueChanged<bool> gridChanged;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<NoteListCubit, NoteListState>(
      buildWhen: (previous, current) =>
          previous.searching != current.searching ||
          previous.notes.isEmpty != current.notes.isEmpty,
      builder: (context, state) => AppBar(
        title: FadeAnimatedSwitcher(
          alignment: Alignment.centerLeft,
          child: state.searching
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localizations.noteSearchFieldHint,
                  ),
                  onChanged: (value) {
                    context.read<NoteListCubit>().search(value);
                  },
                )
              : Text(localizations.appName),
        ),
        actions: [
          FadeScaleAnimatedSwitcher(
            child: state.searching || state.notes.isEmpty
                ? null
                : IconButton(
                    key: ValueKey(grid),
                    onPressed: () => gridChanged(!grid),
                    icon: grid
                        ? const Icon(Icons.view_agenda_outlined)
                        : const Icon(Icons.grid_view_outlined),
                  ),
          ),
          FadeScaleAnimatedSwitcher(
            child: state.notes.isEmpty
                ? null
                : IconButton(
                    key: ValueKey(state.searching),
                    onPressed: () => state.searching
                        ? context.read<NoteListCubit>().stopSearch()
                        : context.read<NoteListCubit>().startSearch(),
                    icon: state.searching
                        ? const Icon(Icons.close)
                        : const Icon(Icons.search),
                  ),
          ),
        ],
      ),
    );
  }
}
