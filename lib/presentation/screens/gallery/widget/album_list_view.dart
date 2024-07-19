import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/album_data.dart';


class AlbumListView extends StatelessWidget {
  final List<AlbumData> albumDataList;
  final Function(AlbumData) onTap;

  const AlbumListView({
    super.key,
    required this.albumDataList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final albumData = albumDataList[index];
        return InkWell(
          onTap: () {
            onTap(albumData);
          },
          child: AlbumListItem(albumData: albumData),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          indent: 16,
          endIndent: 16,
          height: 1,
          color: Colors.grey,
        );
      },
      itemCount: albumDataList.length,
    );
  }
}

class AlbumListItem extends StatelessWidget {
  final AlbumData albumData;

  const AlbumListItem({
    super.key,
    required this.albumData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Image.memory(
            albumData.coverImage!,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                albumData.krName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${albumData.count}',
                style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}