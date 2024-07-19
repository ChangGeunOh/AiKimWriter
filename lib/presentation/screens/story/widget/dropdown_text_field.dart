import 'package:flutter/material.dart';

class DropdownTextField extends StatefulWidget {
  final String text;
  final List<String> items;
  final Function(String) onChanged;

  const DropdownTextField({
    super.key,
    required this.text,
    required this.items,
    required this.onChanged,
  });

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  late TextEditingController _controller;
  late List<DropdownMenuItem<String>> _items;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.items.first);
    _items = widget.items
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              widget.onChanged(value);
            },
            controller: _controller,
            decoration: InputDecoration(
              labelText: '제목',
              border: const OutlineInputBorder(),
              suffixIcon: PopupMenuButton<String>(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                      top: 2.0,
                      bottom: 4.0
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'AI 추천',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                onSelected: (value) {
                  debugPrint('You selected $value');
                  _controller.value = TextEditingValue(text: value);
                  widget.onChanged(value);
                },
                itemBuilder: (BuildContext context) {
                  return widget.items.map((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
    return TextField(
      controller: _controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Select ${widget.text}',
        labelText: widget.text,
        suffixIcon: DropdownButton(
          onChanged: (String? value) {
            _controller.text = value!;
            widget.onChanged(value);
          },
          items: _items,
          value: _controller.text,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
 */
