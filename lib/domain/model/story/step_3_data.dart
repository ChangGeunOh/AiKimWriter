import 'package:aikimwriter/domain/model/gallery/image_data.dart';
import 'package:flutter/material.dart';

class Step3Data {
  final String location;
  final DateTimeRange? dateTimeRange;
  final ImageData? imageData;
  final String memo;

  Step3Data({
    this.location = '',
    this.dateTimeRange,
    this.imageData,
    this.memo = '',
  });

  Step3Data copyWith({
    String? location,
    DateTimeRange? dateTimeRange,
    String? memo,
    ImageData? imageData,
  }) {
    return Step3Data(
      location: location ?? this.location,
      dateTimeRange: dateTimeRange ?? this.dateTimeRange,
      memo: memo ?? this.memo,
      imageData: imageData ?? this.imageData,
    );
  }

  bool get isFilled => location.isNotEmpty && dateTimeRange != null && imageData != null;
  String get filledData => 'location: $location, dateTimeRange: $dateTimeRange, memo: $memo, imageData: $imageData';
}