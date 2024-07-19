import 'package:flutter/material.dart';

class MemoTextField extends StatefulWidget {
  final Function(String) onChanged;
  final String? text;
  final String? labelText;
  final String? hintText;

  const MemoTextField({
    super.key,
    this.text,
    required this.onChanged,
    this.labelText,
    this.hintText,
  });

  @override
  State<MemoTextField> createState() => _MemoTextFieldState();
}

class _MemoTextFieldState extends State<MemoTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText!,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.grey[200],
          height: 160,
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.start,
            maxLines: 8,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
            ),
            onChanged: (text) {
              widget.onChanged(text);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
