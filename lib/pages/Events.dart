import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:im2/pages/Comment.dart';
import 'package:im2/pages/Users.dart';
import 'package:im2/pages/add_event.dart';

import '../models/event_model.dart';

class Event with ChangeNotifier {
  String _category = "";
  String _name = "";
  String _shortDescription = "";
  String _longDescription = "";
  String _place = "";
  String _chatLink = "";
  User _event_autor = newObject();
  DateTime _Date = DateTime.now();
  TimeOfDay _Time = TimeOfDay.now();
  int _index = 0;
  List<Comment_class> _comments = [];
  List<User> _participants = [];

  User get event_autor => _event_autor;
  String? _picURL1 = "";
  String? _picURL2 = "";

  String? get picURL1 => _picURL1;

  String? get picURL2 => _picURL2;

  String get category => _category;

  String get name => _name;

  String get shortDescription => _shortDescription;

  String get longDescription => _longDescription;

  String get place => _place;

  String get chatLink => _chatLink;

  DateTime get Date => _Date;

  TimeOfDay get Time => _Time;

  int get index => _index;

  List<Comment_class> get comments => _comments;

  List<User> get participants => _participants;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('event');

  Future<dynamic> getEvent() async {
    final newUserRef = await usersCollection.get();
    List<dynamic> result = newUserRef.docs.map((doc) => doc.data()).toList();
    return result;
  }

  Future<void> addEvent(
    _name,
    _category,
    _shortDescription,
    _longDescription,
    _place,
    _Date,
    _Time,
    _chatLink,
    _picURL1,
    _picURL2,
    User event_autor,
  ) async {
    final userData = {
      'name': _name,
      'category': _category,
      'shortDescription': _shortDescription, // Use empty string if null
      'longDescription': _longDescription,
      'place': _place,
      'date': _Date.toString(),
      'time': _Time.toString(),
      'chatLink': _chatLink,
      'picURL1': _picURL1,
      'picURL2': _picURL2,
      'comments': [],
      'event_autor': {
        "username": event_autor.username,
        "avatarUrl": event_autor.avatarUrl,
        "email": event_autor.email,
        "id": event_autor.id,
        "age": event_autor.age,
        "is_admin": event_autor.is_admin,
        "profile_description": event_autor.profile_description,
      },
    };

    // Add a new document with a generated ID
    final newUserRef = await usersCollection.add(userData);
    await usersCollection.doc(newUserRef.id).update({"id": newUserRef.id});
    var id = int.parse(newUserRef.id); // Parse the document ID as an integer
  }

  addComments(ids, comments) async {
    await usersCollection.doc(ids).update({"comments": comments});
    print("shud");
  }

  void setEvent_autor(User autor) {
    _event_autor = autor;
    notifyListeners();
  }

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _Date = date;
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    _Time = time;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setPic1(String? url1) {
    _picURL1 = url1;
    notifyListeners();
  }

  void setPic2(String? url2) {
    _picURL2 = url2;
    notifyListeners();
  }

  void setShortDescription(String shortDescription) {
    _shortDescription = shortDescription;
    notifyListeners();
  }

  void setLongDescription(String longDescription) {
    _longDescription = longDescription;
    notifyListeners();
  }

  void setPlace(String place) {
    _place = place;
    notifyListeners();
  }

  void setChatLink(String chatLink) {
    _chatLink = chatLink;
    notifyListeners();
  }

  void addComment(Comment_class comment) {
    _comments.add(comment);
    notifyListeners();
  }

  void removeComment(Comment_class comment) {
    _comments.remove(comment);
    notifyListeners();
  }
}
