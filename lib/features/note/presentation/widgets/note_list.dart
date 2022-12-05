import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/presentation/raw_scroll_behavior.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../bloc/note_list_cubit.dart';
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

class _NoteListState extends State<NoteList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late bool _grid;

  @override
  void initState() {
    super.initState();
    _grid = widget.grid;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void didUpdateWidget(covariant NoteList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.grid != widget.grid) {
      _controller.reverse().whenComplete(() {
        if (!mounted) return;
        setState(() => _grid = !_grid);
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteListCubit, NoteListState>(
      listenWhen: (previous, current) => previous.loading,
      listener: (context, state) {
        _controller.forward();
      },
      buildWhen: (previous, current) {
        return previous.displayingNotes != current.displayingNotes;
      },
      builder: (context, state) => FadeTransition(
        opacity: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
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
    );
  }
}
