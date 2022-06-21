import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'firebase_options.dart';
import 'repositories/repositories.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EquatableConfig.stringify;
  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: SimpleBlocObserver());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth bloc kicks off on app started
        // Why can't we add fetch notes here it would kick off fetchnotes event
        // This would create a stream and we would listen to note updates
        // When the user logs out of the home screen . We are not creating
        BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
                  authRepository: AuthRepository(),
                )..add(AppStarted())),
        BlocProvider<NotesBloc>(
            create: (_) => NotesBloc(
                  authRepository: AuthRepository(),
                  notesRepository: NotesRepository(),
                ))
      ],
      child: MaterialApp(
        title: 'Flutter Firestore BLOC notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
