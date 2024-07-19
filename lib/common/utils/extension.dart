import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Date on int {
  String toDate({String? format}) {
    final dateFormat = format ?? 'yyyy/MM/dd';
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat(dateFormat).format(dateTime);
  }

  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }
}

extension DateString on DateTime {
  String toDateString({String? format}) {
    final dateFormat = format ?? 'yyyy/MM/dd';
    return DateFormat(dateFormat).format(this);
  }

  String toTimeString({String? format}) {
    final timeFormat = format ?? 'HH:mm:ss';
    return DateFormat(timeFormat).format(this);
  }

  String toDateTimeString({String? format}) {
    final timeFormat = format ?? 'yyyy/MM/dd HH:mm';
    return DateFormat(timeFormat).format(this);
  }

  String toMonthDay({String? format}) {
    final dateTimeFormat = format ?? 'MM/dd';
    return DateFormat(dateTimeFormat).format(this);
  }
}

extension DateTimeRangeString on DateTimeRange {
  String toDateString({String? format = 'yyyy/MM/dd'}) {
    return '${start.toDateString(format: format)} - ${end.toDateString(format: format)}';
  }
}