part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

//First event on app startup : Requests the bloc for list of posts
class PostsFetched extends PostsEvent {}

// Event that triggers an alertdialog . Asking user to confirm deletion of post
class PostDeleteInitialized extends PostsEvent {
  final List<Post> posts;
  final Post postToDelete;
  const PostDeleteInitialized(
      {required this.posts, required this.postToDelete});
}

// Event that triggers the deletion by asking the bloc to delete the post
class PostDeleteConfirmed extends PostsEvent {
  final List<Post> posts;
  final Post postToDelete;
  const PostDeleteConfirmed({required this.posts, required this.postToDelete});
}
