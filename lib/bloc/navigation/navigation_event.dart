import 'package:equatable/equatable.dart';
import 'package:flutter_timer/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  NavigationEvent([List props = const <dynamic>[]]) : super(props);
}

class SelectModule extends NavigationEvent {
  final NavModule module;

  SelectModule({@required this.module})
    : assert(null != module),
      super([module]);
}

