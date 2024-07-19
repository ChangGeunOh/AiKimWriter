import 'package:flutter/material.dart';

import '../../../../domain/model/story/list_item_data.dart';

class ListItemListView extends StatefulWidget {
  final String title;
  final List<ListItemData> listItemDataList;
  final Function(ListItemData) onTapListItem;
  final ListItemData? listItemData;

  const ListItemListView({
    super.key,
    required this.title,
    required this.listItemDataList,
    required this.onTapListItem,
    this.listItemData,
  });

  @override
  State<ListItemListView> createState() => _ListItemListViewState();
}

class _ListItemListViewState extends State<ListItemListView> {
  late ListItemData? _listItemData;

  @override
  void initState() {
    _listItemData = widget.listItemData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             widget.title,
             style: const TextStyle(
               fontSize: 12,
               color: Colors.black87,
             ),
           ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final listItemData = widget.listItemDataList[index];
                return InkWell(
                  onTap: () {
                    _listItemData = listItemData;
                    widget.onTapListItem(listItemData);
                    setState(() {});
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: _listItemData == listItemData ? 1 : 0.2,
                        child: Image.asset(
                          listItemData.thumbnail,
                          width: 46,
                          height: 46,
                        ),
                      ),
                      Text(
                        listItemData.title,
                        style: TextStyle(
                          fontSize: 12,
                          color: _listItemData == listItemData
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4);
              },
              itemCount: widget.listItemDataList.length,
            ),
          ),
        ],
      ),
    );
  }
}
