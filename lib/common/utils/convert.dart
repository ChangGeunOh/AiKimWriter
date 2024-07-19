import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';


class Convert {
  static Uint8List base64ToUint8List(String value) {
    return base64Decode(value);
  }
  
  static String uint8ListTobase64(Uint8List? value) {
    return base64Encode(value ?? Uint8List(0));
  }

  static bool stringToBool(dynamic value) {
    return value.runtimeType == bool
        ? value as bool
        : value.toLowerCase() == 'y';
  }

  static bool dynamicToBool(dynamic value) {
    switch (value.runtimeType) {
      case const (bool):
        return value as bool;
      case const (int):
        return value == 1;
      case const (String):
        return value.toLowerCase() == 'y';
      default:
        return false;
    }
  }

  static int dynamicToInt(dynamic value) {
    value = value ?? 0;
    return value.runtimeType == int ? value as int : int.parse(value);
  }

  static String numberToString(dynamic value) {
    return value.toString();
  }

  static integerWithComma(int number) {
    return NumberFormat('#,###').format(number);
  }

  static numberWithComma(dynamic number) {
    final integerValue = int.tryParse(number);
    final doubleValue = double.tryParse(number);
    if (doubleValue != null) {
      return NumberFormat('#,###').format(doubleValue.round());
    }
    if (integerValue != null) {
      return NumberFormat('#,###').format(integerValue);
    }
    return number.toString();
  }

  static String nullToEmptyString(dynamic value) {
    return value ?? '';
  }

  static DateTime intToDateTime(int value) {
    return DateTime.fromMillisecondsSinceEpoch(value * 1000);
  }

  static DateTime dynamicToDateTime(dynamic value) {
    switch (value.runtimeType) {
      case const (DateTime):
        return value as DateTime;
      case const (int):
        return intToDateTime(value);
      case const (String):
        return DateTime.parse(value);
      default:
        return DateTime.now();
    }
  }

  static int dateTimeToInt(DateTime value) {
    return value.millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime? dynamicToNullableDateTime(dynamic value) {
    switch (value.runtimeType) {
      case const (DateTime):
        return value as DateTime;
      case const (int):
        return intToDateTime(value);
      case const (String):
        return DateTime.parse(value);
      default:
        return null;
    }
  }




}
