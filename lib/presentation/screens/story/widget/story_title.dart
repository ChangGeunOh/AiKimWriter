import 'package:flutter/material.dart';

class StoryTitle extends StatelessWidget {
  final String iconPath;
  final String description;

  const StoryTitle({
    super.key,
    required this.iconPath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(iconPath),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xff565e6d),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}