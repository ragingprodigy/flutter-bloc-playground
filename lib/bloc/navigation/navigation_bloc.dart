import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_timer/models/models.dart';
import './bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavModule> {
  @override
  NavModule get initialState => NavModule.timer;

  @override
  Stream<NavModule> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is SelectModule) {
      yield event.module;
    }
  }
}
