import 'package:flutter_bloc_delete_demo/apis/apis.dart';

import '../models/models.dart';

class PostsRepository {
  final PostsApi _postsApi = PostsApi();

  Future<List<Post>> getPosts() async {
    return _postsApi.fetchPosts();
  }

  Future<bool> deletePost(String id) {
    return _postsApi.deletePost(postId: id);
  }
}
