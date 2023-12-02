import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';

abstract class BaseBloc<STATE> extends BlocBase {
  STATE _state;

  STATE get state => _state;

  BaseBloc(this._state);

  @protected
  void setState(STATE state, {bool notify = true}) {
    this._state = state;
    if (notify) {
      notifyListeners();
    }
  }

  set state(STATE state) => setState(state);
}
