import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_timer/bloc/weather/bloc.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:flutter_timer/repositories/repositories.dart';
import 'package:meta/meta.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
    : assert(null != weatherRepository);
  
  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        // yield* retrieveWeather(event.city);
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }

    if (event is RefreshWeather) {
      try {
        // yield* retrieveWeather(event.city);
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield currentState;
      }
    }
  }

  Stream<WeatherLoaded> retrieveWeather(String city) async* {
    final Weather weather = await weatherRepository.getWeather(city);
    yield WeatherLoaded(weather: weather);
  }
}
