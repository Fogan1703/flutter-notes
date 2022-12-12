import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_notes/common/presentation/raw_scroll_behavior.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../bloc/cubit.dart';
import 'note_tile.dart';

class NoteList extends StatefulWidget {
  const NoteList({
    Key? key,
    required this.grid,
  }) : super(key: key);

  final bool grid;

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> with TickerProviderStateMixin {
  late final AnimationController _listController;
  late final AnimationController _emptyController;
  late final Animation<double> _emptyAnimation;

  late bool _grid;

  @override
  void initState() {
    super.initState();
    _grid = widget.grid;
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _emptyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _emptyAnimation = CurvedAnimation(
      parent: _emptyController,
      curve: Curves.easeIn,
    );
  }

  @override
  void didUpdateWidget(covariant NoteList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.grid != widget.grid) {
      _listController.reverse().whenComplete(() {
        if (!mounted) return;
        setState(() => _grid = !_grid);
        _listController.forward();
      });
    }
  }

  @override
  void dispose() {
    _listController.dispose();
    _emptyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<NoteListCubit, NoteListState>(
          listenWhen: (previous, current) => previous.loading,
          listener: (context, state) {
            _listController.forward();
          },
        ),
        BlocListener<NoteListCubit, NoteListState>(
          listener: (context, state) {
            if (state.notes.isEmpty) {
              _emptyController.forward();
            } else {
              _emptyController.reverse();
            }
          },
        ),
      ],
      child: BlocBuilder<NoteListCubit, NoteListState>(
        buildWhen: (previous, current) {
          return previous.displayingNotes != current.displayingNotes;
        },
        builder: (context, state) => Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: _emptyAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb_outlined,
                    size: MediaQuery.of(context).size.width / 4,
                  ),
                  const SizedBox(height: 16),
                  Text(localizations.emptyNotesWidgetTitle),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 88,
              left: 88,
              child: FadeTransition(
                opacity: _emptyAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      localizations.createNoteTip,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _listController,
                curve: Curves.easeIn,
              ),
              child: ScrollConfiguration(
                behavior: RawScrollBehavior(),
                child: MasonryGridView.count(
                  itemCount: state.displayingNotes.length,
                  crossAxisCount: _grid ? 2 : 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) => NoteTile(
                    note: state.displayingNotes[index],
                    onChecked: (checked) {
                      // TODO: implement onChecked
                      throw UnimplementedError();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
