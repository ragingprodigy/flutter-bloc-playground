import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/blocs/blocs.dart';
import 'package:flutter_timer/screens/todos/add_edit_screen.dart';
import 'package:flutter_timer/utils/utils.dart';
import 'package:todos_app_core/todos_app_core.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id})
    : super(key: key ?? ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final todo = (state as TodosLoaded)
          .todos
          .firstWhere((todo) => todo.id == id, orElse: () => null);
          final localizations = ArchSampleLocalizations.of(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(localizations.todoDetails),
              actions: <Widget>[
                IconButton(
                  tooltip: localizations.deleteTodo,
                  key: ArchSampleKeys.deleteTodoButton,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    todosBloc.dispatch(DeleteTodo(todo));
                    Navigator.pop(context, todo);
                  }
                )
              ],
            ),
            body: todo == null
              ? Container(key: FlutterTodosKeys.emptyDetailsContainer)
              : Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Checkbox(
                            key: FlutterTodosKeys.detailsScreenCheckBox,
                            value: todo.complete,
                            onChanged: (_) {
                              todosBloc.dispatch(
                                UpdateTodo(todo.copyWith(complete: !todo.complete))
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Hero(
                                tag: '${todo.id}__heroTag',
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 16.0
                                  ),
                                  child: Text(
                                    todo.task,
                                    key: ArchSampleKeys.detailsTodoItemTask,
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                ),
                              ),
                              Text(
                                todo.note,
                                key: ArchSampleKeys.detailsTodoItemNote,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                key: ArchSampleKeys.editTodoFab,
                tooltip: localizations.editTodo,
                child: Icon(Icons.edit),
                onPressed: todo == null
                  ? null
                  : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: ArchSampleKeys.editTodoScreen,
                            onSave: (task, note) {
                              todosBloc.dispatch(
                                UpdateTodo(
                                  todo.copyWith(task: task, note: note)
                                )
                              );
                            },
                            isEditing: true,
                            todo: todo
                          );
                        }
                      )
                    );
                  }
              ),
          );
      },
    );
  }
}