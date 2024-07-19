import 'package:aikimwriter/common/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DurationTextField extends StatefulWidget {
  final DateTimeRange dateTimeRange;
  final Function(DateTimeRange) onChanged;
  final String? labelText;
  final String? hintText;

  const DurationTextField({
    super.key,
    required this.onChanged,
    required this.dateTimeRange,
    this.labelText,
    this.hintText,
  });

  @override
  State<DurationTextField> createState() => _DurationTextField();
}

class _DurationTextField extends State<DurationTextField> {
  late TextEditingController _controller;
  late DateTimeRange _dateTimeRange;

  @override
  void initState() {
    _controller =
        TextEditingController(text: widget.dateTimeRange.toDateString());
    _dateTimeRange = widget.dateTimeRange;
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
        suffixIcon: IconButton(
          onPressed: () {
            _showDatePicker(context);
          },
          icon: const Icon(
            Icons.calendar_today_outlined,
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: (text) {
        _controller.text = _dateTimeRange.toDateString();
        setState(() {});
      },
    );
  }

  void _showDatePicker(BuildContext context) async {
    final dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (dateTimeRange != null) {
      _dateTimeRange = dateTimeRange;
      _controller.text = dateTimeRange.toDateString();
      setState(() {});
      widget.onChanged(_dateTimeRange);
    }
  }
}
