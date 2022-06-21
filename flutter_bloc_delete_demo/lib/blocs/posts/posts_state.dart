part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

//State  On startup this is the first state
class PostsInitial extends PostsState {}

//State when network calls are happening
class PostsLoading extends PostsState {}

// State when network call is done and we have posts to show
class PostsLoaded extends PostsState {
  final List<Post> posts;
  const PostsLoaded({required this.posts});
}

// State when the user needs to confirm if they want to delete a post
class PostDeletingTrigger extends PostsState {
  final Post selectedPost;
  final List<Post> posts;
  final String message;

  const PostDeletingTrigger(
      {required this.selectedPost, required this.posts, required this.message});
}

// State when the user has confirmed to delete the post
class PostDeleting extends PostsState {}
