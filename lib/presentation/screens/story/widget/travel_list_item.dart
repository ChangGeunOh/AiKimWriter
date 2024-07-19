import 'package:flutter/material.dart';

class TravelListItem extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String description;
  final bool isChecked;
  final Widget? icon;
  final VoidCallback onTap;
  final bool hasSelected;

  const TravelListItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.isChecked,
    this.icon,
    required this.onTap,
    required this.hasSelected,
  });

  @override
  Widget build(BuildContext context) {
    final trainIcon = icon ??
        Image.asset(
          isChecked
              ? 'assets/icons/ic_checked.png'
              : 'assets/icons/ic_unchecked.png',
        );

    final alpha = isChecked ? 1.0 : hasSelected ? 0.3 : 1.0;

    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: alpha,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 24.0,
            top: 12.0,
            bottom: 12.0,
          ),
          child: Row(
            children: [
              Image.asset(
                thumbnail,
                width: 56,
                height: 56,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: Center(
                  child: trainIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}