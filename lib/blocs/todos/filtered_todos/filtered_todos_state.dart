import 'package:equatable/equatable.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FilteredTodosState extends Equatable {
  FilteredTodosState([List props = const <dynamic>[]]) : super(props);
}

class FilteredTodosLoading extends FilteredTodosState {
  @override
  String toString() => 'FilteredTodosLoading';
}

class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final TodosVisibilityFilter activeFilter;

  FilteredTodosLoaded(this.filteredTodos, this.activeFilter)
      : super([filteredTodos, activeFilter]);

  @override
  String toString() {
    return 'FilteredTodosLoaded { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}
