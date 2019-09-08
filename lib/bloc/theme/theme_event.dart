import 'package:equatable/equatable.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super(props);
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  WeatherChanged({@required this.condition})
    : assert(null != condition),
      super([condition]);
}
