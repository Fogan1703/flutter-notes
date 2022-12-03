import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/note/data/repository/note_repository.dart';
import 'features/note/presentation/note_list_screen.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.noteRepository,
  }) : super(key: key);

  final NoteRepository noteRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: noteRepository),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const NoteListScreen(),
      ),
    );
  }
}
