import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/bloc/blocs.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:flutter_timer/repositories/repositories.dart';
import 'package:flutter_timer/widgets/widgets.dart' as widgets;

class DrawerItem {
  String title;
  IconData icon;
  NavModule module;

  DrawerItem(this.title, this.icon, this.module);
}

class DrawerWidget extends StatefulWidget {
  final WeatherRepository weatherRepository;
  final PostsRepository postsRepository;

  final drawerItems = [
    DrawerItem('Timer', Icons.timer, NavModule.timer),
    DrawerItem('Infinite List', Icons.list, NavModule.infinite_list),
    DrawerItem('Weather', Icons.cloud, NavModule.weather),
  ];

  DrawerWidget({Key key, @required this.weatherRepository, @required this.postsRepository})
    : assert(null != weatherRepository),
      assert(null != postsRepository),
      super(key: key);

  DrawerState createState() => DrawerState();
}

class DrawerState extends State<DrawerWidget> {
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    final NavigationBloc navigationBloc = BlocProvider.of<NavigationBloc>(context);
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          // selected: i == _selectedDrawerIndex,
          onTap: () {
            _selectedDrawerIndex = i;
            navigationBloc.dispatch(SelectModule(module: d.module));
          },
        )
      );
    }


    return BlocListener<NavigationBloc, NavModule>(
      listener: (context, navModule) {
        Navigator.of(context).pop();
      },
      child: BlocBuilder<NavigationBloc, NavModule>(
        builder: (context, activeModule) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.drawerItems[_selectedDrawerIndex].title),
              actions: activeModule == NavModule.weather ? [
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
              ] : [],
            ),
            body: _getItemWidget(activeModule),
            drawer: Drawer(
              child: ListView(children: drawerOptions),
            ),
          );
        },
      ),
    );
  }

  _getItemWidget(NavModule module) {
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
    }
  }

}