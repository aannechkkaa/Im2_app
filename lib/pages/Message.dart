import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:im2/pages/Users.dart';

class Message_class {
  String _message_text = "";
  int _messageId = 0;
  String _messageAuthorName = "";
  DateTime _messageDate = DateTime.now();
  TimeOfDay _messageTime = TimeOfDay.now();
  User _autor = newObject();

  String get messageText => _message_text;
  int get messageId => _messageId;
  String get messageAuthorName => _messageAuthorName;
  DateTime get messageDate => _messageDate;
  TimeOfDay get messageTime => _messageTime;
  User get autor => _autor;

  void setMessageAutor(User autor) {
    _autor = autor;
  }

  void setMessageText(String messageText) {
    _message_text = messageText;
  }

  void setMessageId(int messageId) {
    _messageId = messageId;
  }

  void setMessageAuthorName(String messageAuthorName) {
    _messageAuthorName = messageAuthorName;
  }

  void setMessageDate(DateTime messageDate) {
    _messageDate = messageDate;
  }

  void setMessageTime(TimeOfDay messageTime) {
    _messageTime = messageTime;
  }

  Message_class({
    required String messageText,
    required int messageId,
    required String messageAuthorName,
    required DateTime messageDate,
    required TimeOfDay messageTime,
    required User autor,
  })  : _message_text = messageText,
        _messageId = messageId,
        _autor = autor,
        _messageDate = messageDate,
        _messageTime = messageTime;
}