import 'package:aikimwriter/common/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/gallery/image_data.dart';

class StoryImageItem extends StatelessWidget {
  final ImageData imageData;
  final VoidCallback onTap;

  const StoryImageItem({
    super.key,
    required this.onTap,
    required this.imageData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Builder(builder: (context) {
                  return Stack(
                    children: [
                      Image.memory(
                        imageData.thumbData!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      if (imageData.hasLocation)
                        const Positioned(
                          left: 2,
                          bottom: 4,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    imageData.address.isEmpty ? '장소 정보 없음' : imageData.address,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: imageData.address.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(imageData.dateTime.toDateTimeString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (imageData.weatherData != null)
                            Image.asset(
                              imageData.weatherData!.thumbnail,
                              width: 24,
                              height: 24,
                            ),
                          // if(imageData.weatherData != null)
                          Text(
                            imageData.weatherData?.title ?? ' ',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (imageData.vibeData != null)
                            Image.asset(
                              imageData.vibeData!.thumbnail,
                              width: 18,
                              height: 18,
                            ),
                          const SizedBox(width: 3),
                          if (imageData.vibeData != null)
                            Text(
                              imageData.vibeData!.title,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
