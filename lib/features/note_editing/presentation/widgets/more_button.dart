import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// TODO: implement other items

enum NoteEditingMoreAction { delete }

class NoteEditingMoreButton extends StatelessWidget {
  const NoteEditingMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return PopupMenuButton<NoteEditingMoreAction>(
      onSelected: (value) {
        switch (value) {
          case NoteEditingMoreAction.delete:
            // TODO: handle this case
            break;
        }
      },
      itemBuilder: (context) => [
        NoteEditingMoreItem(
          action: NoteEditingMoreAction.delete,
          icon: const Icon(Icons.delete),
          title: Text(localizations.noteEditingMoreActionDelete),
        ),
      ],
    );
  }
}

class NoteEditingMoreItem extends PopupMenuItem<NoteEditingMoreAction> {
  NoteEditingMoreItem({
    Key? key,
    required NoteEditingMoreAction action,
    required Widget icon,
    required Widget title,
  }) : super(
          key: key,
          value: action,
          child: Row(
            children: [
              icon,
              const SizedBox(width: 16),
              title,
            ],
          ),
        );
}
