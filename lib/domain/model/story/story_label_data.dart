class StoryLabelData {
  final String iconPath;
  final String description;

  final String label;
  final String? activeLabel;

  StoryLabelData({
    required this.iconPath,
    required this.description,
    required this.label,
    this.activeLabel,
  });

}