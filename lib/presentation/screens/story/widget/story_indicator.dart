import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';

enum IndicatorType {
  done,
  active,
  deActive,
}

const labels = [
  '여행종류',
  '사진선택',
  '세부조정',
  '유형선택',
  '내용확인',
  '템플릿',
  '완료',
];

class StoryIndicator extends StatelessWidget {
  final List<int> doneStepList;
  final int step;
  final Function(int) onTapStep;

  const StoryIndicator({
    super.key,
    required this.doneStepList,
    required this.onTapStep,
    this.step = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 14.0,
            left: 32,
            right: 32,
          ),
          child: Divider(
            height: 4,
            thickness: 4,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: labels.mapIndexed((index, e) {

            final isDone = doneStepList.contains(index + 1);
            final type = isDone ? IndicatorType.done : index == step - 1 ? IndicatorType.active : IndicatorType.deActive;

            return GestureDetector(
              onTap: () {
                onTapStep(index + 1);
              },
              child: Indicator(
                number: index,
                text: e,
                type: type,
                activeText: index == labels.length - 1 ? '생성중' : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final int number;
  final String text;
  final String activeText;
  final IndicatorType type;
  final bool isFinish;

  const Indicator({
    super.key,
    required this.number,
    required this.text,
    required this.type,
    String? activeText,
    this.isFinish = false,
  }) : activeText = activeText ?? text;

  @override
  Widget build(BuildContext context) {
    final numberTextColor = type == IndicatorType.active
        ? mintColor
        : type == IndicatorType.done
            ? Colors.white
            : const Color(0xffd9d9d9);

    final circleBackgroundColor =
        type == IndicatorType.done ? mintColor : Colors.white;

    final labelTextColor =
        type == IndicatorType.deActive ? const Color(0xffd9d9d9) : mintColor;

    final label = type == IndicatorType.active ? activeText : text;

    final width = MediaQuery.of(context).size.width /( labels.length + 1);

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: circleBackgroundColor,
              shape: BoxShape.circle,
              border: type == IndicatorType.done
                  ? null
                  : Border.all(
                      color: labelTextColor,
                      width: 3,
                    ),
            ),
            child: Center(
              child: Text(
                "${number + 1}",
                style: TextStyle(
                  color: numberTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: type == IndicatorType.active
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: labelTextColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
