import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';
import 'enumerations.dart';

enum TimeStampFormat { parse_12, parse_24 }

extension NavigationExtension on State {
  void pushRoute(Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

extension NavigatorExtention on BuildContext {
  Future<T?> pushRoute<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (context) => page));

  void pop([dynamic value]) => Navigator.of(this).pop(value);

  void showSnackBarWithText(String text) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

extension DateUtils on DateTime {
  String get weekdayToFullString {
    switch (weekday) {
      case DateTime.monday:
        return "월요일";
      case DateTime.tuesday:
        return "화요일";
      case DateTime.wednesday:
        return "수요일";
      case DateTime.thursday:
        return "목요일";
      case DateTime.friday:
        return "금요일";
      case DateTime.saturday:
        return "토요일";
      case DateTime.sunday:
        return "일요일";
      default:
        return "오류";
    }
  }

  String get weekdayToAbbreviatedString {
    switch (weekday) {
      case DateTime.monday:
        return "월";
      case DateTime.tuesday:
        return "화";
      case DateTime.wednesday:
        return "수";
      case DateTime.thursday:
        return "목";
      case DateTime.friday:
        return "금";
      case DateTime.saturday:
        return "토";
      case DateTime.sunday:
        return "일";
      default:
        return "오류";
    }
  }

  int get totalMinutes => hour * 60 + minute;

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );

  String dateToStringWithFormat({String format = 'y-M-d'}) {
    return DateFormat(format).format(this);
  }

  DateTime stringToDateWithFormat({
    required String format,
    required String dateString,
  }) =>
      DateFormat(format).parse(dateString);

  String getTimeInFormat(TimeStampFormat format) =>
      DateFormat('h:mm${format == TimeStampFormat.parse_12 ? " a" : ""}')
          .format(this)
          .toUpperCase();

  bool compareWithoutTime(DateTime date) =>
      day == date.day && month == date.month && year == date.year;

  bool compareTime(DateTime date) =>
      hour == date.hour && minute == date.minute && second == date.second;
}

extension ColorExtension on Color {
  Color get accentColor =>
      (blue / 2 >= 255 / 2 || red / 2 >= 255 / 2 || green / 2 >= 255 / 2)
          ? AppColors.black
          : AppColors.white;
}

extension StringExt on String {
  String get capitalized => toBeginningOfSentenceCase(this) ?? "";
}

extension ViewNameExt on CalendarView {
  String get name => toString().split(".").last;
}