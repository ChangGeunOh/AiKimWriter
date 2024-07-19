import 'package:json_annotation/json_annotation.dart';

part 'list_item_data.g.dart';

@JsonSerializable()
class ListItemData {
  final String thumbnail;
  final String title;
  final String description;

  ListItemData({
    required this.thumbnail,
    required this.title,
    required this.description,
  });

  factory ListItemData.fromJson(Map<String, dynamic> json) =>
      _$ListItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListItemDataToJson(this);
}