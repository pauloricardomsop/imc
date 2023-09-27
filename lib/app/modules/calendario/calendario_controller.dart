import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/services/remote_config_service.dart';

class CalendarioController {
  static final CalendarioController _instance = CalendarioController._();

  CalendarioController._();

  factory CalendarioController() => _instance;

  AppStream<List<List<String>>> calendarioStream =
      AppStream<List<List<String>>>.seed(RemoteConfigService.calendario);

  DateTime getPaymentDate(nis) {
    final days = getDaysInYear(int.parse(nis.toString()));
    return getCurrentDay(days);
  }

  DateTime getPaymentDateByMonth(nis, int month) {
    final days = getDaysInYear(int.parse(nis.toString()));
    return days[month];
  }

  List<DateTime> getNextPayments(nis) {
    List<DateTime> payments = [];
    final now = DateTime.now();
    for (var i = 0; i < 12; i++) {
      final payment = getPaymentDateByMonth(nis, i);
      if (payment.isAfter(now)) {
        payments.add(payment);
      }
    }
    return payments;
  }

  List<DateTime> getLastPayments(nis) {
    List<DateTime> payments = [];
    final now = DateTime.now();
    for (var i = 0; i < 12; i++) {
      final payment = getPaymentDateByMonth(nis, i);
      if (payment.isBefore(now)) {
        payments.add(payment);
      }
    }
    return payments;
  }

  DateTime getCurrentDay(List<DateTime> days) {
    final now = DateTime.now();
    for (var day in days) {
      if (now.month == day.month) {
        if (now.day <= day.day) {
          return day;
        } else {
          int index = days.indexOf(day);
          if (index + 1 == days.length) {
            return day;
          } else {
            return days[index + 1];
          }
        }
      }
    }
    return now;
  }

  List<DateTime> getDaysInYear(int nis) {
    final calendarByNis = calendarioStream.value[nis];
    List<DateTime> days = [];
    for (var i = 0; i < calendarByNis.length; i++) {
      int day = int.parse(calendarByNis[i]);
      int month = i + 1;
      int year = 2023;
      days.add(DateTime(year, month, day));
    }
    return days;
  }
}
