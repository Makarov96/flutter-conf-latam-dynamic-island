import 'package:intl/intl.dart';

class TimeGenerator {
  late DateTime _currentTime;

  TimeGenerator(String startTime) {
    DateFormat format = DateFormat("h:mma");
    _currentTime = format.parse(startTime.toUpperCase());
  }

  String decreaseTime() {
    _currentTime = _currentTime.subtract(const Duration(minutes: 1));
    return DateFormat("h:mma").format(_currentTime).toLowerCase();
  }
}
