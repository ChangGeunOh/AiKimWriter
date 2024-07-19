import 'package:aikimwriter/domain/model/story/story_label_data.dart';
import 'package:flutter/material.dart';

import '../../../../common/const/const.dart';
import '../widget/story_title.dart';
import '../widget/travel_custom_item.dart';
import '../widget/travel_list_item.dart';
import '../widget/travel_type_dialog.dart';

class StoryPage01 extends StatefulWidget {
  final StoryLabelData storyLabelData;
  final Function(String) onTravelType;

  const StoryPage01({
    super.key,
    required this.storyLabelData,
    required this.onTravelType,
  });

  @override
  State<StoryPage01> createState() => _StoryPage01State();
}

class _StoryPage01State extends State<StoryPage01> {
  int _selectedIndex = -1;
  String travelName = '';
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryTitle(
            iconPath: widget.storyLabelData.iconPath,
            description: widget.storyLabelData.description,
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: travelTypeDataList.length + 2,
              itemBuilder: (context, index) {
                if (index == travelTypeDataList.length + 1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16,
                    ),
                    child: ElevatedButton(
                      onPressed: _selectedIndex > -1 ? () {
                        widget.onTravelType(travelName);
                      } : null,
                      child: const Text('사진 선택하러 가요.'),
                    ),
                  );
                }
                if (index == travelTypeDataList.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TravelCustomItem(
                      travelName: _selectedIndex == 99 ? travelName : '',
                      hasSelected: _selectedIndex > -1,
                      onTap: () async {
                        _selectedIndex = 99;
                        setState(() {});
                        final text = await showDialog(
                            context: context,
                            builder: (context) {
                              return const TravelTypeDialog();
                            });
                        if (text != null) {
                          travelName = text;
                          _selectedIndex = 99;
                          _scrollToBottom();
                          setState(() {});
                        }
                      },
                    ),
                  );
                }
                return TravelListItem(
                  isChecked: index == _selectedIndex,
                  thumbnail: travelTypeDataList[index].thumbnail,
                  title: travelTypeDataList[index].title,
                  description: travelTypeDataList[index].description,
                  hasSelected: _selectedIndex > -1,
                  onTap: () {
                    _selectedIndex = index;
                    travelName = travelTypeDataList[index].title;
                    _scrollToBottom();
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
