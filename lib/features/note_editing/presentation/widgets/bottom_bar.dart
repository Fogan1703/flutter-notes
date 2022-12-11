import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/data/model/note.dart';

import '../bloc.dart';
import 'colors_bottom_sheet.dart';
import 'edited_text.dart';
import 'more_button.dart';

class NoteEditingBottomBar extends StatelessWidget {
  const NoteEditingBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => throw UnimplementedError(), // TODO: adding a todo
          icon: const Icon(Icons.add_box_outlined),
        ),
        IconButton(
          onPressed: () => throw UnimplementedError(), // TODO: styling
          icon: const Icon(Icons.text_fields),
        ),
        Expanded(
          child: BlocSelector<NoteEditingBloc, Note, DateTime>(
            selector: (state) => state.edited,
            builder: (context, edited) => EditedText(
              edited: edited,
            ),
          ),
        ),
        IconButton(
          onPressed: () => const ColorsBottomSheet().show(context),
          icon: const Icon(Icons.color_lens_outlined),
        ),
        const NoteEditingMoreButton(),
      ],
    );
  }
}
