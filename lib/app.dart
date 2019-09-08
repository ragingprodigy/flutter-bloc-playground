import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/bloc/blocs.dart';
import 'package:flutter_timer/repositories/repositories.dart';
import 'package:flutter_timer/widgets/widgets.dart';

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final PostsRepository postsRepository;

  App({Key key, @required this.weatherRepository, @required this.postsRepository})
    : assert(null != weatherRepository),
      assert(null != postsRepository),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return  MaterialApp(
          title: 'Drawer App',
          theme: themeState.theme,
          home: DrawerWidget(
            weatherRepository: weatherRepository,
            postsRepository: postsRepository
          ),
        );
      }
    );
  }
}