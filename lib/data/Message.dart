import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Message {
  final int id;
  final String content;

  const Message({
    required this.id,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': content,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, name: $content}';
  }
}