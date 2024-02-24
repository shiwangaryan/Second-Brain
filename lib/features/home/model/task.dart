import 'package:flutter/material.dart';

class Task {
  final String title;
  final String note;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Color color;
  Task(
    this.title,
    this.note,
    this.startTime,
    this.endTime,
    this.color,
  );
}
