import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum TemperatureUnits { fahrenheit, celsius }

class SettingsState extends Equatable {
  final TemperatureUnits temperatureUnits;

  SettingsState({@required this.temperatureUnits})
    : assert(null != temperatureUnits),
      super();

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnits];
}
