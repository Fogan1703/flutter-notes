import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/common/presentation/widgets/animated_switchers.dart';

import '../bloc.dart';
import 'colors_bottom_sheet.dart';
import 'edited_text.dart';
import 'more_button.dart';

class NoteEditingBottomBar extends StatelessWidget {
  const NoteEditingBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<NoteEditingBloc, NoteEditingState>(
      builder: (context, state) => ColoredBox(
        color: theme.scaffoldBackgroundColor,
        child: Row(
          children: [
            FadeScaleAnimatedSwitcher(
              child: state.editing
                  ? null
                  : IconButton(
                      onPressed: () => context
                          .read<NoteEditingBloc>()
                          .add(NoteEditingAddItemEvent(CheckItem.empty)),
                      icon: const Icon(Icons.add_box_outlined),
                    ),
            ),
            FadeScaleAnimatedSwitcher(
              child: state.editing
                  ? null
                  : IconButton(
                      onPressed: () => throw UnimplementedError(),
                      // TODO: styling
                      icon: const Icon(Icons.text_fields),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: EditedText(
                  edited: state.note.edited,
                ),
              ),
            ),
            FadeScaleAnimatedSwitcher(
              child: state.editing
                  ? null
                  : IconButton(
                      onPressed: () => const ColorsBottomSheet()
                          .show(context)
                          .then(
                            (value) => value != null
                                ? context
                                    .read<NoteEditingBloc>()
                                    .add(NoteEditingChangeColorEvent(value()))
                                : null,
                          ),
                      icon: const Icon(Icons.color_lens_outlined),
                    ),
            ),
            FadeScaleAnimatedSwitcher(
              child: state.editing ? null : const NoteEditingMoreButton(),
            ),
          ],
        ),
      ),
    );
  }
}
