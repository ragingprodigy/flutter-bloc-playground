import 'package:equatable/equatable.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosState extends Equatable {
  TodosState([List props = const <dynamic>[]]) : super(props);
}

class TodosLoading extends TodosState {
  @override
  String toString() => 'TodosLoading';
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded([this.todos = const []]) : super([todos]);
  
  @override
  String toString() => 'TodosLoaded { todos: $todos }';
}

class TodosNotLoaded extends TodosState {
  @override
  String toString() => 'TodosNotLoaded';
}
