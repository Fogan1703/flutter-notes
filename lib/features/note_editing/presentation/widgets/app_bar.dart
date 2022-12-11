import 'package:flutter/material.dart';

class NoteEditingAppBar extends StatelessWidget with PreferredSizeWidget {
  const NoteEditingAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => throw UnimplementedError(), // TODO: starring
            icon: const Icon(Icons.star_outline),
          ),
        ],
      ),
    );
  }
}
