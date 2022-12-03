import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../data/model/note.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.note,
    required this.onChecked,
  }) : super(key: key);

  final Note note;
  final void Function(bool checked) onChecked;

  List<Widget> _getItems() {
    if (note.content.isEmpty) return [];
    final first = note.content.first;

    if (first is String) {
      return [
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
          .whereType<CheckItem>()
          .take(5)
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
                        if (value != null) onChecked(value);
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

    return OpenContainer(
      closedColor: theme.colorScheme.surface,
      openColor: theme.scaffoldBackgroundColor,
      middleColor: theme.scaffoldBackgroundColor,
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
              Text(
                note.title,
                style: theme.textTheme.titleSmall,
              ),
              ..._getItems(),
            ],
          ),
        ),
      ),
      openBuilder: (context, close) => Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}
