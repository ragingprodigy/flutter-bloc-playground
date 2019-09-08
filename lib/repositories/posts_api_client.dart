import 'dart:convert';

import 'package:flutter_timer/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class PostsApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  PostsApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  Future<List<Post>> getPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&limit=$limit');

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) => Post(id: rawPost['id'], title: rawPost['title'], body: rawPost['body']))
        .toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
