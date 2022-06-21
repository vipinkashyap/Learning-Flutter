import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_delete_demo/blocs/blocs.dart';
import 'package:flutter_bloc_delete_demo/posts_bloc_observer.dart';

import 'screens/screens.dart';

void main() {
  EquatableConfig.stringify = true;
  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: PostsBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(PostsFetched()),
      child: const MaterialApp(
        title: 'Flutter Delete Bloc',
        home: PostsScreen(),
      ),
    );
  }
}
