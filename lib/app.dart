import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/blocs/blocs.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:flutter_timer/screens/todos/todo_screens.dart';
import 'package:flutter_timer/utils/utils.dart';
import 'package:flutter_timer/widgets/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return  MaterialApp(
          title: 'Drawer App',
          theme: themeState.theme,
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
          // home: DrawerWidget(),
          routes: {
            ArchSampleRoutes.home: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<TabBloc>(
                    builder: (context) => TabBloc(),
                  ),
                  BlocProvider<FilteredTodosBloc>(
                    builder: (context) => FilteredTodosBloc(todosBloc: todosBloc),
                  ),
                  BlocProvider<StatsBloc>(
                    builder: (context) => StatsBloc(todosBloc: todosBloc),
                  ),
                ],
                child: DrawerWidget(),
              );
            },
            ArchSampleRoutes.addTodo: (context) {
              return AddEditScreen(
                key: ArchSampleKeys.addTodoScreen,
                onSave: (task, note) {
                  todosBloc.dispatch(
                    AddTodo(Todo(task, note: note)),
                  );
                },
                isEditing: false,
              );
            },
          },
        );
      }
    );
  }
}
