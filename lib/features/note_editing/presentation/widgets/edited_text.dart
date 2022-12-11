import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditedText extends StatelessWidget {
  const EditedText({Key? key, required this.edited}) : super(key: key);

  final DateTime edited;

  @override
  Widget build(BuildContext context) {
    final DateFormat format;
    final theme = Theme.of(context);
    final now = DateTime.now();
    final today = edited.day - now.day < 1;
    final week = edited.day - now.day < 7;
    final year = edited.year - now.year < 1;

    if (today) {
      format = DateFormat.Hm();
    } else if (week) {
      format = DateFormat.E().add_Hm();
    } else if (year) {
      format = DateFormat.MMMd();
    } else {
      format = DateFormat.yMMMd();
    }

    return Text(
      format.format(edited),
      textAlign: TextAlign.center,
      style: theme.textTheme.bodySmall,
    );
  }
}
