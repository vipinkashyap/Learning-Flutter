import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/models.dart';
// Lowest layer that interacts with JSONPlaceholder data source

class PostsApi {
  final Uri baseUri = Uri.parse('https://jsonplaceholder.typicode.com/posts/');
  // Use one client to make all network requests
  final http.Client httpClient = http.Client();

  // Helper function to generate a Uri
  Uri postUri(String id) =>
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');

  // Function to get posts
  Future<List<Post>> fetchPosts() async {
    var response = await httpClient.get(baseUri);

    if (response.statusCode == 200) {
      log('Api returned ${response.statusCode}');
      var postsBody = jsonDecode(response.body) as List<dynamic>;

      return postsBody.map((post) => Post.fromJson(post)).toList();
    }
    throw Exception();
  }

  //Function to delete posts
  Future<bool> deletePost({required String postId}) async {
    try {
      await httpClient.delete(postUri(postId));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
