import 'package:benefits_brazil/app/core/models/calendar_model.dart';
import "package:flutter/material.dart";

class BfCalendarController {
  static final BfCalendarController _instance = BfCalendarController._();

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  factory BfCalendarController() => _instance;

  BfCalendarController._();
  BuildContext get context => key.currentState!.context;

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

  List<List<String>> calendar = Calendar.calendar2023Update;

  List<DateTime> getDaysInYear(int nis) {
    final calendarByNis = calendar[nis];
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
