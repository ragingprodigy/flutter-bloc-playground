import 'package:flutter_timer/blocs/todos/tab/tab.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:bloc/bloc.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
