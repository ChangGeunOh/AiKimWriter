import 'package:aikimwriter/common/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  final DateTime dateTime;
  final Function(DateTime) onChanged;
  final String? labelText;
  final String? hintText;

  const DateTextField({
    super.key,
    required this.onChanged,
    required this.dateTime,
    this.labelText,
    this.hintText,
  });

  @override
  State<DateTextField> createState() => _DateTextField();
}

class _DateTextField extends State<DateTextField> {
  late TextEditingController _controller;
  late DateTime? _dateTime;

  @override
  void initState() {
    _controller =
        TextEditingController(text: widget.dateTime.toDateTimeString());
    _dateTime = widget.dateTime;
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
        try {
          DateTime dateTime = DateFormat("yyyy/MM/dd HH:mm").parse(text);
          _dateTime = dateTime;
          widget.onChanged(dateTime);
        } catch (e) {
          print(e.toString());
        }
        setState(() {});
      },
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      // locale: const Locale('ko', 'KR'),
    );
    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _dateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _controller.value = TextEditingValue(
            text: _dateTime?.toDateTimeString() ?? '',
          );
        });
      }
    }
  }
}
