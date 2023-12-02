import "dart:async" as async;

typedef VoidCallback = void Function();

class Timer {
  final Duration period;
  final Duration duration;
  final int totalEmissions;
  var _emissions = 0;
  final List<VoidCallback> _listeners = [];
  final List<VoidCallback> _onFinishedListeners = [];
  async.Timer? timer;

  Timer({required this.period, required this.duration})
      : totalEmissions = duration.inSeconds ~/ period.inSeconds;

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void addFinishedListener(VoidCallback listener) {
    _onFinishedListeners.add(listener);
  }

  void removeFinishedListener(VoidCallback listener) {
    _onFinishedListeners.remove(listener);
  }

  void startTimer() {
    stopTimer();
    timer = async.Timer.periodic(Duration(seconds: 1), _notifyListeners);
  }

  void stopTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void _notifyListeners(async.Timer timer) {
    _emissions++;
    for (final listener in _listeners) {
      listener();
    }
    if (_emissions >= totalEmissions) {
      stopTimer();
      for (final listener in _onFinishedListeners) {
        listener();
      }
    }
  }

  void removeListeners() {
    _listeners.clear();
    _onFinishedListeners.clear();
  }
}
