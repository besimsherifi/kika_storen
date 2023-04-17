import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  Timer? _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  dynamic currentTime;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final hour = _prefs.getInt('hour') ?? 0;
    final minute = _prefs.getInt('minute') ?? 0;
    final seconds = _prefs.getInt('seconds') ?? 0;
    final startTime =
        _prefs.getString('startTime') ?? DateFormat.jm().format(DateTime.now());
    _hour = hour;
    _minute = minute;
    _seconds = seconds;
    currentTime = startTime;
  }

  Future<void> startTimer() async {
    await initPrefs();
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    final startTime =
        _prefs.getString('startTime') ?? DateFormat.jm().format(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      _prefs.setInt('hour', _hour);
      _prefs.setInt('minute', _minute);
      _prefs.setInt('seconds', _seconds);
      _prefs.setString('startTime', startTime);

      notifyListeners();
    });
  }

  void pauseTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
    }
    notifyListeners();
  }

  Future<void> stopTimer() async {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer?.cancel();
      await _prefs.clear();
      _hour = 0;
      _minute = 0;
      _seconds = 0;
      currentTime = DateFormat.jm().format(DateTime.now());
    }
    notifyListeners();
  }

  Future<void> continueTimer() async {
    await initPrefs();
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    final startTime =
        _prefs.getString('startTime') ?? DateFormat.jm().format(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      _prefs.setInt('hour', _hour);
    });
  }
}
