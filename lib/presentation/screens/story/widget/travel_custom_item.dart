import 'package:flutter/material.dart';

import 'travel_list_item.dart';

class TravelCustomItem extends StatelessWidget {
  final bool hasSelected;
  final String travelName;
  final VoidCallback onTap;

  const TravelCustomItem(
      {super.key,
        required this.travelName,
        required this.hasSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {

    final alpha = hasSelected && travelName.isEmpty ? 0.3 : 1.0;

    if (travelName.isNotEmpty) {
      return TravelListItem(
        thumbnail: 'assets/images/img_travel_type_99.png',
        title: travelName,
        description: ('직접 입력 했어요'),
        isChecked: true,
        icon: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: onTap,
        hasSelected: hasSelected,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: alpha,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '직접 입력 할래요',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}