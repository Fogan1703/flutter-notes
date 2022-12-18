import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/common/presentation/raw_scroll_behavior.dart';
import 'package:flutter_notes/common/presentation/widgets/animated_switchers.dart';

import '../bloc.dart';

class NoteEditingContent extends StatelessWidget {
  const NoteEditingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<NoteEditingBloc, NoteEditingState>(
      builder: (context, state) => ScrollConfiguration(
        behavior: RawScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                initialValue: state.note.title,
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
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                onReorder: (oldIndex, newIndex) => context
                    .read<NoteEditingBloc>()
                    .add(NoteEditingOnReorderEvent(oldIndex, newIndex)),
                children: List.generate(
                  state.note.content.length,
                  (index) {
                    Widget child;
                    final item = state.note.content[index];

                    if (item is String) {
                      child = TextFormField(
                        initialValue: item,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
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
                    } else if (item is CheckItem) {
                      child = Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: SizedBox.square(
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
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: ValueKey(index),
                              initialValue: item.text,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
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
                    } else {
                      throw Exception(
                        'Unknown note content type: ${item.runtimeType}',
                      );
                    }

                    final color = state.note.color != null
                        ? Color(state.note.color!.value)
                        : theme.scaffoldBackgroundColor;
                    child = ColoredBox(
                      color: color,
                      key: ValueKey(item),
                      child: Stack(
                        children: [
                          child,
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            child: FadeAnimatedSwitcher(
                              child: state.editing
                                  ? DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            color.withOpacity(0),
                                            color,
                                          ],
                                          stops: const [0, 0.2],
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 24),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.close),
                                          ),
                                          ReorderableDragStartListener(
                                            index: index,
                                            child: const Icon(Icons.reorder),
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    );

                    return child;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
