import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      //Runs whenever auth state changes
      listener: (context, state) => context.read<NotesBloc>().add(FetchNotes()),
      builder: (context, authState) {
        return Scaffold(
          body: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, notesState) {
              return _buildBody(context, authState, notesState);
            },
          ),
        );
      },
    );
  }

  Stack _buildBody(
      BuildContext context, AuthState authState, NotesState notesState) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('Your Notes'),
              ),
              leading: IconButton(
                  onPressed: () {
                    authState is Authenticated
                        ? context.read<AuthBloc>().add(Logout())
                        : log('Go to login');
                  },
                  icon: authState is Authenticated
                      ? const Icon(Icons.exit_to_app, size: 28.0)
                      : const Icon(Icons.account_circle, size: 28.0)),
              actions: [
                IconButton(
                    onPressed: () => log('Change theme'),
                    icon: const Icon(Icons.brightness_4))
              ],
            ),
            notesState is NotesLoaded
                ? NotesGrid(
                    notes: notesState.notes,
                    onTap: (note) {},
                  )
                : const SliverPadding(padding: EdgeInsets.all(0)),
          ],
        ),
        notesState is NotesLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink(),
        notesState is NotesError
            ? const Center(
                child: Text(
                  'Please check your internet',
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
