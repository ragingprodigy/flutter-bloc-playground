import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/blocs/blocs.dart';
import 'package:flutter_timer/blocs/navigation/bloc.dart';
import 'package:flutter_timer/app.dart';
import 'package:flutter_timer/repositories/repositories.dart';
import 'package:flutter_timer/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final http.Client httpClient = http.Client();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: httpClient,
    )
  );

  final PostsRepository postsRepository = PostsRepository(
    postsApiClient: PostsApiClient(
      httpClient: httpClient
    )
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          builder: (context) => SettingsBloc(),
        ),
        BlocProvider<TimerBloc>(
          builder: (context) => TimerBloc(ticker: Ticker()),
        ),
        BlocProvider<NavigationBloc>(
          builder: (context) => NavigationBloc(),
        ),
        BlocProvider<WeatherBloc>(
          builder: (context) => WeatherBloc(weatherRepository: weatherRepository),
        ),
        BlocProvider<PostBloc>(
          builder: (context) => PostBloc(postsRepository: postsRepository),
        ),
      ],
      child: App(postsRepository: postsRepository, weatherRepository: weatherRepository),
    )
  );
}
