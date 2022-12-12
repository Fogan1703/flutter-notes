import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/common/presentation/raw_scroll_behavior.dart';

import '../bloc.dart';

class NoteEditingContent extends StatelessWidget {
  const NoteEditingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<NoteEditingBloc, Note>(
      builder: (context, note) {
        return ScrollConfiguration(
          behavior: RawScrollBehavior(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                key: const ValueKey(-1),
                initialValue: note.title,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                style: theme.textTheme.titleMedium,
                decoration: InputDecoration(
                  hintText: localizations.noteTitleHint,
                  border: InputBorder.none,
                ),
                onChanged: (value) => context
                    .read<NoteEditingBloc>()
                    .add(NoteEditingTitleChangedEvent(value)),
              ),
              ...List<Widget>.generate(
                note.content.length,
                (index) {
                  final item = note.content[index];
                  switch (item.runtimeType) {
                    case String:
                      item as String;
                      return TextFormField(
                        key: ValueKey(index),
                        initialValue: item,
                        keyboardType: TextInputType.multiline,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: localizations.noteTextItemHint,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => context
                            .read<NoteEditingBloc>()
                            .add(NoteEditingItemChangedEvent(
                              index,
                              value,
                            )),
                      );
                    case CheckItem:
                      item as CheckItem;
                      return Row(
                        key: ValueKey(index),
                        children: [
                          SizedBox.square(
                            dimension: 24,
                            child: Checkbox(
                              value: item.checked,
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<NoteEditingBloc>()
                                      .add(NoteEditingItemChangedEvent(
                                        index,
                                        item.copyWith(checked: value),
                                      ));
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: ValueKey(index),
                              initialValue: item.text,
                              keyboardType: TextInputType.multiline,
                              style: theme.textTheme.bodyMedium,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) => context
                                  .read<NoteEditingBloc>()
                                  .add(NoteEditingItemChangedEvent(
                                    index,
                                    item.copyWith(text: value),
                                  )),
                            ),
                          ),
                        ],
                      );
                    default:
                      throw Exception(
                        'Unknown note content type: ${item.runtimeType}',
                      );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
