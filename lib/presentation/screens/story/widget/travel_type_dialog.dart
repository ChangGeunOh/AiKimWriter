import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class TravelTypeDialog extends StatefulWidget {
  const TravelTypeDialog({super.key});

  @override
  State<TravelTypeDialog> createState() => _TravelTypeDialogState();
}

class _TravelTypeDialogState extends State<TravelTypeDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),
                    const Center(
                      child: Text(
                        '어떤 여행 입니까?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: '여행 이름을 입력해주세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 38),
                    ElevatedButton(
                        onPressed: () {
                          context.pop(_controller.value.text);
                        },
                        child: const Text('등록 하기')),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -40,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/img_launcher.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
