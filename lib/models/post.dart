import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  Post({ this.id, this.title, this.body }) : super();

  @override
  String toString() => 'Post { id: $id }';

  @override
  List<Object> get props => [id, title, body];
}
