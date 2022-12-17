import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/common/presentation/widgets/animated_switchers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc.dart';

class NoteEditingAppBar extends StatelessWidget with PreferredSizeWidget {
  const NoteEditingAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: BlocBuilder<NoteEditingBloc, NoteEditingState>(
        buildWhen: (previous, current) => previous.editing != current.editing,
        builder: (context, state) => Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: FadeScaleAnimatedSwitcher(
                child: state.editing
                    ? Text(localizations.noteEditingModeTitle)
                    : const SizedBox(),
              ),
            ),
            FadeScaleAnimatedSwitcher(
              child: state.editing
                  ? IconButton(
                      key: ValueKey(state.editing),
                      onPressed: () => context
                          .read<NoteEditingBloc>()
                          .add(NoteEditingStopEditingEvent()),
                      icon: const Icon(Icons.close),
                    )
                  : IconButton(
                      key: ValueKey(state.editing),
                      onPressed: () => throw UnimplementedError(),
                      // TODO: starring
                      icon: const Icon(Icons.star_outline),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
