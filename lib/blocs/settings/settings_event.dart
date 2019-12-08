import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  SettingsEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class TemperatureUnitsToggled extends SettingsEvent {}
