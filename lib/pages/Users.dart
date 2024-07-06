import 'dart:js_util';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart' as crypto;
import 'package:pointycastle/digests/blake2b.dart';
import 'package:pointycastle/src/impl/base_digest.dart';

import 'home.dart'; // Для импорта Blake2b


List<User> Users = [];
User current_user = newObject();
int user_id = 0;

String hashPassword(String password) {
  final List<int> utf8Pass = utf8.encode(password);

  // Создание Blake2b хэшера
  final hasher = Blake2bDigest(digestSize: 64);

  // Начало процесса хэширования
  hasher.reset();
  hasher.update(Uint8List.fromList(utf8Pass), 0, utf8Pass.length);

  // Получение хэша в виде байтов
  final hashBytes = Uint8List(hasher.digestSize);
  hasher.doFinal(hashBytes, 0);

  // Преобразование байтов в base64 строку
  return base64Url.encode(hashBytes);
}


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

    if (mail.isEmpty) {
      print('Error: Email is required');
      return;
    }

    // Хэширование пароля
    final hashedPassword = hashPassword(password);

    final userData = {
      'username': username,
      'password': hashedPassword, // Сохраняем хэшированный пароль
      'avatarUrl': avatarUrl ?? '',
      'age': age,
      'email': mail,
      'profileDescription': description,
      'isAdmin': is_admin,
    };

    try {
      // Добавление нового пользователя в коллекцию
      final newUserRef = await FirebaseFirestore.instance.collection('users').add(userData);

      // Обновление документа с установкой поля 'id'
      await newUserRef.update({'id': newUserRef.id});

      // Присвоение значений текущему пользователю
      current_user.username = userData['username'] as String? ?? '';
      current_user.avatarUrl = userData['avatarUrl'] as String;
      current_user.password = hashedPassword; // Сохраняем хэшированный пароль
      current_user.age = userData['age'] as int? ?? 0;
      current_user.email = userData['email'] as String? ?? '';
      current_user.id = newUserRef.id;
      current_user.profile_description = userData['profileDescription'] as String? ?? '';
      current_user.is_admin = userData['isAdmin'] as bool? ?? false;
    } catch (e) {
      print('Error adding user: $e');
      // Можно добавить дополнительную логику обработки ошибок, если необходимо
    }
  }
  Future<void> login(BuildContext context, String email, String password) async {
    try {
      // Хэшируем входной пароль
      final hashedPassword = hashPassword(password);

      var userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: hashedPassword) // Поиск по хэшированному паролю
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        var userDoc = userQuery.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          current_user.username = userData['username'] as String? ?? '';
          current_user.avatarUrl = userData['avatarUrl'] as String;
          current_user.password = hashedPassword; // Сохраняем хэшированный пароль
          current_user.age = userData['age'] as int? ?? 0;
          current_user.email = userData['email'] as String? ?? '';
          current_user.id = userData['id'] as String? ?? 0;
          current_user.profile_description =
              userData['profileDescription'] as String? ?? '';
          current_user.is_admin = userData['isAdmin'] as bool? ?? false;
          notifyListeners();
          print(current_user.avatarUrl);

          print('User logged in successfully');
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: Home()));
        } else {
          print('User data is null');
          // Handle null user data appropriately
        }
      } else {
        print('User not found or incorrect credentials');
        // Показываем диалоговое окно с предупреждением
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ошибка входа',
                style: TextStyle(
                fontSize: 20,
                fontFamily: 'Oswald',
                color: Colors.black,
              ),),
              content: Text('Пользователь не найден или неверные учетные данные.',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Oswald',
                  color: Colors.blueGrey,
                ),),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Закрываем диалоговое окно
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error logging in: $e');
      // Handle error appropriately, maybe throw an exception or show a snackbar
    }
  }

  Future<void> updateData(ids, username, email, description, password, avatarUrl) async {
    //password = hashPassword(password);
    final hashedPassword2 = hashPassword(password);
    await usersCollection.doc(ids).update({
      'username': username,
      'password': hashedPassword2 ,
      'avatarUrl': avatarUrl ?? '',
      'email': email,
      'profileDescription': description,
    });
  }
  Future<void> updateDatanopass(ids, username, email, description, password, avatarUrl) async {
    //password = hashPassword(password);
    //final hashedPassword2 = hashPassword(password);
    await usersCollection.doc(ids).update({
      'username': username,
      //'password': passwors ,
      'avatarUrl': avatarUrl ?? '',
      'email': email,
      'profileDescription': description,
    });
  }

  Future<void> updateTheme(ids, bool theme) async {
    await usersCollection.doc(ids).update({
      'isAdmin': theme,
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
