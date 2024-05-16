import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

List<User> Users = [];
User current_user = newObject();
int user_id = 0;

// Создаем класс, который будет содержать данные пользователя и наследоваться от ChangeNotifier.
class User with ChangeNotifier {
  String username = "";
  String password = "";
  String profile_description = "";
  String? avatarUrl = "";
  int age = 0;
  dynamic id = 0;
  String email = "";
  bool is_admin = false;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> register(
    String username,
    String password,
    String? avatarUrl,
    int age,
    int id,
    String description,
    String mail,
    bool is_admin,
  ) async {
    notifyListeners();
    if (username.isEmpty) {
      print('Error: Username is required');
      return;
    }

    if (password.isEmpty) {
      print('Error: Password is required');
      return;
    }

    if (email.isEmpty) {
      print('Error: Email is required');
      return;
    }

    final userData = {
      'username': username,
      'password': password,
      'avatarUrl': avatarUrl ?? '', // Use empty string if null
      'age': age,
      'email': email,
      'profileDescription': profile_description,
      'isAdmin': is_admin,
    };

    // Add a new document with a generated ID
    final newUserRef = await usersCollection.add(userData);
    await usersCollection.doc(newUserRef.id).update({"id": newUserRef.id});
    id = int.parse(newUserRef.id); // Parse the document ID as an integer
    debugPrint('User registered on Firestore with ID: $id');
  }

  Future<void> login(String email, String password) async {
    try {
      var userQuery = await usersCollection
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        var userDoc = userQuery.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          current_user.username = userData['username'] as String? ?? '';
          current_user.username = userData['username'] as String? ?? '';
          current_user.avatarUrl = userData['avatarUrl'] as String;
          current_user.password = userData['password'] as String;
          current_user.age = userData['age'] as int? ?? 0;
          current_user.email = userData['email'] as String? ?? '';
          current_user.id = userData['id'] as String? ?? 0;
          current_user.profile_description =
              userData['profileDescription'] as String? ?? '';
          current_user.is_admin = userData['isAdmin'] as bool? ?? false;
          notifyListeners();
          print(current_user.avatarUrl);

          print('User logged in successfully');
        } else {
          print('User data is null');
          // Handle null user data appropriately
        }
      } else {
        print('User not found or incorrect credentials');
        // Handle invalid credentials, maybe throw an exception or show a snackbar
      }
    } catch (e) {
      print('Error logging in: $e');
      // Handle error appropriately, maybe throw an exception or show a snackbar
    }
  }

  Future<void> updateData(ids, username, email, password, avatarUrl) async {
    await usersCollection.doc(ids).update({
      'username': username,
      'password': password,
      'avatarUrl': avatarUrl ?? '',
      'email': email,
    });
  }

  void updateUsername(String newUsername) {
    username = newUsername;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void updateAvatarUrl(String? newAvatarUrl) {
    avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void updateAge(int newAge) {
    age = newAge;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updateProfileDescription(String newProfileDescription) {
    profile_description = newProfileDescription;
    notifyListeners();
  }
}
