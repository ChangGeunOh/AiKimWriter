import 'dart:io';

import 'package:aikimwriter/domain/model/main/story_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoryGridAddItem extends StatelessWidget {
  final int index;
  final String imagePath;
  final Function(int) onTap;
  final Function(int) onLongTap;

  const StoryGridAddItem({
    super.key,
    required this.index,
    required this.imagePath,
    required this.onTap,
    required this.onLongTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        onLongPress: () {
          onLongTap(index);
        },
        child: imagePath.isEmpty ? getAddItem() : getImageItem(imagePath),
      ),
    );
  }

  Widget getAddItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/ic_story_step_06.png',
          width: 48,
          height: 48,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 12),
        Text(
          'Add Story'.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget getImageItem(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}