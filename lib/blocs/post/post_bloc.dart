import 'package:bloc/bloc.dart';
import 'package:flutter_timer/blocs/post/bloc.dart';
import 'package:flutter_timer/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  final PostsRepository postsRepository;
  final int perPage = 20;

  PostBloc({@required this.postsRepository});

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> transformEvents(
    Stream<PostEvent> events, 
    Stream<PostState> Function(PostEvent event) next) {
    return super.transformEvents(
      (events as Observable<PostEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next
    );
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await postsRepository.getPosts(0, perPage);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }

        if (currentState is PostLoaded) {
          final posts =
            await postsRepository.getPosts((currentState as PostLoaded).posts.length, perPage);

            yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                posts: (currentState as PostLoaded).posts + posts,
                hasReachedMax: false
              );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState postState) =>
    postState is PostLoaded && postState.hasReachedMax;
}
