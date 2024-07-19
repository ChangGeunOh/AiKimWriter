import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Function(String) onChanged;
  final String? text;
  final String? labelText;
  final String? hintText;

  const CustomTextField({
    super.key,
    this.text,
    required this.onChanged,
    this.labelText,
    this.hintText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    return TextField(
      controller: _controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: _controller.value.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: (text) {
        widget.onChanged(text);
        setState(() {});
      },
    );
  }
}
