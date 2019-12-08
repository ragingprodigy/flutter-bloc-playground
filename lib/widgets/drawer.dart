import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/blocs/blocs.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:flutter_timer/screens/todos/todo_screens.dart';
import 'package:flutter_timer/widgets/widgets.dart' as widgets;

class DrawerItem {
  String title;
  IconData icon;
  NavModule module;

  DrawerItem(this.title, this.icon, this.module);
}

class DrawerWidget extends StatelessWidget{
  final drawerItems = [
    DrawerItem('Timer', Icons.timer, NavModule.timer),
    DrawerItem('Infinite List', Icons.list, NavModule.infinite_list),
    DrawerItem('Weather', Icons.cloud, NavModule.weather),
    DrawerItem('Todos', Icons.track_changes, NavModule.todos),
  ];

  // DrawerState createState() => DrawerState();
// }

// class DrawerState extends State<DrawerWidget> {
  // TodosBloc todosBloc;

  // @override
  // void initState() {
  //   super.initState();
  //   todosBloc = BlocProvider.of<TodosBloc>(context);
  // }

  @override
  Widget build(BuildContext context) {
    TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    var drawerOptions = <Widget>[];
    int _selectedDrawerIndex = 0;
    final NavigationBloc navigationBloc = BlocProvider.of<NavigationBloc>(context);
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () {
            _selectedDrawerIndex = i;
            navigationBloc.dispatch(SelectModule(module: d.module));
            Navigator.of(context).pop();
          },
        )
      );
    }

    return BlocListener<NavigationBloc, NavModule>(
      listener: (context, navModule) {
        // Navigator.of(context).pop();
      },
      child: BlocBuilder<NavigationBloc, NavModule>(
        builder: (context, activeModule) {
          return BlocBuilder<TabBloc, AppTab>(
            builder: (context, activeTab) {
              List<Widget> appBarActions = [];

              if (activeModule == NavModule.weather) {
                appBarActions.addAll([
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widgets.Settings(),
                          )
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        final city = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widgets.CitySelection(),
                          ),
                        );

                        if (null != city) {
                          weatherBloc.dispatch(FetchWeather(city: city));
                        }
                      },
                    )
                ]);
              }

              if (activeModule == NavModule.todos && activeTab == AppTab.todos) {
                appBarActions.addAll([
                  widgets.FilterButton(visible: activeTab == AppTab.todos),
                  widgets.ExtraActions(),
                ]);
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(drawerItems[_selectedDrawerIndex].title),
                  actions: appBarActions,
                ),
                body: _getItemWidget(todosBloc, activeModule),
                drawer: Drawer(
                  child: ListView(children: drawerOptions),
                ),
              );
            }
          );
        },
      ),
    );
  }

  _getItemWidget(TodosBloc todosBloc, NavModule module) {
    switch (module) {
      case NavModule.timer:
        return widgets.Timer();
        break;
      case NavModule.infinite_list:
        return BlocBuilder<PostBloc, PostState>(
          builder: (context, state) => widgets.InfiniteList()
        );
        break;
      case NavModule.weather:
        return BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) => widgets.Weather()
        );
        break;
      case NavModule.todos:
        todosBloc.dispatch(LoadTodos());
        return HomeScreen();
        break;
    }
  }
}
