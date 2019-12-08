import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostEvent extends Equatable {
  PostEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class Fetch extends PostEvent {
  @override
  String toString() => 'Fetch';
}
