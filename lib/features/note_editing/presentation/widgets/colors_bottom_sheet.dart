import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/common/presentation/raw_scroll_behavior.dart';

import '../bloc.dart';

class ColorsBottomSheet extends StatelessWidget {
  const ColorsBottomSheet({Key? key}) : super(key: key);

  Future<NoteColor? Function()?> show(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (_) => BlocProvider.value(
          value: context.read<NoteEditingBloc>(),
          child: this,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocSelector<NoteEditingBloc, NoteEditingState, NoteColor?>(
      selector: (state) => state.note.color,
      builder: (context, selectedColor) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              localizations.noteEditingColorSelectorTitle,
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(
            height: 64,
            child: ScrollConfiguration(
              behavior: RawScrollBehavior(),
              child: ListView.separated(
                itemCount: NoteColor.colors.length + 1,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final color = index == 0 ? null : NoteColor.colors[index - 1];
                  final selected = color == selectedColor;

                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(() => color),
                    child: SizedBox.square(
                      dimension: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color != null
                              ? Color(color.value)
                              : theme.colorScheme.surface,
                          border: Border.all(
                            color: selected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline,
                            width: selected ? 2 : 1,
                          ),
                        ),
                        child: selected
                            ? Icon(
                                Icons.done,
                                color: theme.colorScheme.primary,
                              )
                            : color == null
                                ? const Icon(Icons.format_color_reset_outlined)
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
