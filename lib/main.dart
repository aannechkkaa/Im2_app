import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:im2/pages/hello_page.dart';
import 'package:im2/pages/home.dart';
import 'package:im2/pages/first_page.dart';
import 'package:im2/pages/Chats.dart';
import 'package:im2/pages/Event.dart';
import 'package:im2/pages/account.dart';
import 'package:provider/provider.dart';
import 'package:im2/pages/Users.dart';
import 'firebase_options.dart';

List<User> users = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Переопределяем debugPrint для фильтрации конкретного сообщения об переполнении
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && message.contains('A RenderFlex overflowed by')) {
      return; // Подавляем это конкретное сообщение об переполнении
    }
    // Выводим остальные сообщения как обычно
    print(message);
  };

  runApp(
    ChangeNotifierProvider(
      create: (context) => User(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const hello_page(),
        '/home': (context) => const Home(),
        '/event': (context) => const Event_page(),
        '/chat_page': (context) => const Chat_p(),
      },
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 50, 50, 50),
        brightness: Brightness.light, // Светлая тема
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Темная тема
        primaryColor: Color.fromARGB(255, 50, 50, 50),
        // Дополнительные настройки для темной темы
      ),
      themeMode: ThemeMode.dark, // Автоматический выбор темы в зависимости от настроек системы
    );
  }
}



