import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/common/data/model/note.dart';
import 'package:flutter_notes/features/note_editing/presentation/screen.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.note,
    required this.onChecked,
  }) : super(key: key);

  final Note note;
  final void Function(int index, bool value) onChecked;

  List<Widget> _getItems() {
    if (note.content.isEmpty) return [];
    final first = note.content.first;

    if (first is String) {
      return [
        if (first.isNotEmpty)
          Text(
            first,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              height: 4 / 3,
            ),
          ),
      ];
    }

    if (first is File) {
      return [
        Image.file(first),
      ];
    }

    if (first is CheckItem) {
      return note.content
          .take(5)
          .takeWhile((item) => item is CheckItem)
          .cast<CheckItem>()
          .map(
            (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Transform.scale(
                    scale: 0.75,
                    child: Checkbox(
                      value: item.checked,
                      onChanged: (value) {
                        if (value != null) {
                          onChecked(note.content.indexOf(item), value);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 0, 0),
                    child: Text(
                      item.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 4 / 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList();
    }

    throw Exception('Invalid note content item: $first');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = note.color != null ? Color(note.color!.value) : null;
    return OpenContainer(
      closedColor: color ?? theme.colorScheme.surface,
      openColor: color ?? theme.scaffoldBackgroundColor,
      middleColor: color ?? theme.scaffoldBackgroundColor,
      closedElevation: 1,
      openElevation: 0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      openShape: const RoundedRectangleBorder(),
      tappable: false,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, open) => InkWell(
        onTap: open,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (note.title.isNotEmpty)
                Text(
                  note.title,
                  style: theme.textTheme.titleSmall,
                ),
              ..._getItems(),
            ],
          ),
        ),
      ),
      openBuilder: (context, close) => NoteEditingScreen(
        note: note,
      ),
    );
  }
}
