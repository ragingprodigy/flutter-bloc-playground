import 'package:equatable/equatable.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosEvent extends Equatable {
  TodosEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {
  @override
  String toString() => 'LoadTodos';
}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo) : super([todo]);

  @override
  String toString() => 'AddTodo { todo: $todo }';
  
  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  UpdateTodo(this.updatedTodo) : super([updatedTodo]);

  @override
  String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';
  
  @override
  List<Object> get props => [updatedTodo];
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  DeleteTodo(this.todo) : super([todo]);

  @override
  String toString() => 'DeleteTodo { todo: $todo }';
  
  @override
  List<Object> get props => [todo];
}

class ClearCompleted extends TodosEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends TodosEvent {
  @override
  String toString() => 'ToggleAll';
}
