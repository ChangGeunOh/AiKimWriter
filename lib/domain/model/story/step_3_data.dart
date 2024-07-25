import 'package:aikimwriter/domain/model/gallery/image_data.dart';
import 'package:flutter/material.dart';

class Step3Data {
  final String travelPlace;
  final DateTimeRange? dateTimeRange;
  final ImageData? imageData;
  final String memo;

  Step3Data({
    this.travelPlace = '',
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
      travelPlace: location ?? this.travelPlace,
      dateTimeRange: dateTimeRange ?? this.dateTimeRange,
      memo: memo ?? this.memo,
      imageData: imageData ?? this.imageData,
    );
  }

  bool get isFilled => travelPlace.isNotEmpty && dateTimeRange != null && imageData != null;
  String get filledData => 'location: $travelPlace, dateTimeRange: $dateTimeRange, memo: $memo, imageData: $imageData';
}