import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocConsumer<PostsBloc, PostsState>(listener: (context, state) {
        if (state is PostDeletingTrigger) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.read<PostsBloc>().add(PostDeleteConfirmed(
                              posts: state.posts,
                              postToDelete: state.selectedPost));

                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        }
      }, builder: (context, state) {
        if (state is PostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostsLoaded) {
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: ((context, index) {
                var post = state.posts[index];
                return ListTile(
                  leading: Text(post.id.toString()),
                  title: Text(post.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => context.read<PostsBloc>().add(
                        PostDeleteInitialized(
                            postToDelete: post, posts: state.posts)),
                  ),
                );
              }));
        }

        return const Center(
          child: Text('Unknown State'),
        );
      }),
    );
  }
}
