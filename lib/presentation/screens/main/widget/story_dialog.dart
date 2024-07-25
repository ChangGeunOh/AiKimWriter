import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/model/main/story_data.dart';

class StoryDialog extends StatefulWidget {
  final StoryData storyData;
  final Function(StoryData) onRemove;

  const StoryDialog({
    super.key,
    required this.storyData,
    required this.onRemove,
  });

  @override
  State<StoryDialog> createState() => _StoryDialogState();
}

class _StoryDialogState extends State<StoryDialog> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF5F6F6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTop(() {
              context.pop();
            }),
            const Divider(
              height: 32,
              color: Color(0x10000000),
            ),
            SizedBox(
              height: 300,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(widget.storyData.coverImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 32,
              color: Color(0x10000000),
            ),
            _buildShareIcons((index) {
              _sendMail(widget.storyData);
              context.pop();
            }),
            const Divider(
              height: 32,
              color: Color(0x10000000),
            ),
            _buildBottom(() {
              context.pop();
              widget.onRemove(widget.storyData);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTop(VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(widget.storyData.coverImagePath),
                  fit: BoxFit.cover,
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.storyData.bookTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.storyData.travelPlace,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onTap,
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey[300],
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShareIcons(Function(int) onTap) {
    final assetIcons = List.generate(
      7,
      (index) => 'assets/icons/ic_share_0${index + 1}.png',
    );
    return SizedBox(
      height: 48,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onTap(index);
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 16 : 0),
              child: Image.asset(
                assetIcons[index],
                width: 48,
                height: 48,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemCount: assetIcons.length,
      ),
    );
  }

  Widget _buildBottom(VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF1D74f1),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_outlined,
              color: const Color(0xFF1D74f1),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              onRemove();
            },
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Color(0xFF1D74f1),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMail(StoryData storyData) async {
    final Email email = Email(
      body: '',
      subject: storyData.bookTitle,
      attachmentPaths: [storyData.pdfPath],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
