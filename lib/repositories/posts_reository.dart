import 'dart:async';
import 'package:flutter_timer/repositories/posts_api_client.dart';
import 'package:meta/meta.dart';
import 'package:flutter_timer/models/models.dart';

class PostsRepository {
  final PostsApiClient postsApiClient;

  PostsRepository({@required this.postsApiClient})
    : assert(null != postsApiClient);

  Future<List<Post>> getPosts(int startIndex, int limit) async {
    return await postsApiClient.getPosts(startIndex, limit);
  }
}
