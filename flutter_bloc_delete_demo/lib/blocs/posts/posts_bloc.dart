import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_delete_demo/repositories/repositories.dart';

import '../../models/models.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository = PostsRepository();
  PostsBloc() : super(PostsInitial()) {
    on<PostsFetched>(_onPostsFetched);
    on<PostDeleteInitialized>(_onPostDeleteInitialized);
    on<PostDeleteConfirmed>(_onPostDeleteConfirmed);
  }

  void _onPostsFetched(PostsFetched event, emit) async {
    emit(PostsLoading());
    var posts = await _postsRepository.getPosts();
    emit(PostsLoaded(posts: posts));
  }

  void _onPostDeleteInitialized(PostDeleteInitialized event, emit) {
    emit(PostDeletingTrigger(
        message: 'Delete post #${event.postToDelete.id}?',
        posts: event.posts,
        selectedPost: event.postToDelete));
  }

  void _onPostDeleteConfirmed(PostDeleteConfirmed event, emit) async {
    emit(PostDeleting());

    bool isDeleted =
        await _postsRepository.deletePost(event.postToDelete.id.toString());
    emit(PostsLoading());

    List<Post> updatedPosts =
        event.posts.where((post) => post.id != event.postToDelete.id).toList();

    isDeleted
        ? emit(PostsLoaded(posts: updatedPosts))
        : emit(PostsLoaded(posts: event.posts));
  }
}
