import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/blocs/blocs.dart';
import 'package:flutter_timer/widgets/utils/gradient_container.dart';
import 'widgets.dart';

class Weather extends StatefulWidget {
  _Weather createState() => _Weather();
}

class _Weather extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }
  
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Center(
      child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoaded) {
            BlocProvider.of<ThemeBloc>(context).dispatch(
              WeatherChanged(condition: state.weather.condition),
            );
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'),);
            }

            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator(),);
            }

            if (state is WeatherLoaded) {
              final weather = state.weather;

              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return GradientContainer(
                    color: themeState.color,
                    child: RefreshIndicator(
                      onRefresh: () {
                        weatherBloc.dispatch(
                          RefreshWeather(city: state.weather.location)
                        );

                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: Location(location: weather.location),
                            ),
                          ),
                          Center(
                            child: LastUpdated(dateTime: weather.lastUpdated),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child: CombinedWeatherTemperature(weather: weather),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (state is WeatherError) {
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.red),
              );
            }

            return Text(
              'Unexpected State',
              style: TextStyle(color: Colors.orange),
            );
          },
        ),
      ),
    );
  }
}
