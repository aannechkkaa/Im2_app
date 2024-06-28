import 'dart:html';
import 'package:flutter_svg/svg.dart';
import 'package:im2/pages/add_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2/pages/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:im2/pages/reg.dart';

import 'package:im2/pages/Users.dart';

class First_p extends StatefulWidget {
  const First_p({Key? key}) : super(key: key);

  @override
  First_page createState() => First_page();
}

class First_page extends State<First_p> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: Reg_route(),
      routes: {Reg_p.routeName: (_) => Reg_p()},
    );
  }
//const Account({Key? key}) : super(key: key);
}

class Reg_route extends StatefulWidget {
  @override
  Reg_route_state createState() => Reg_route_state();
}
class Reg_route_state extends State<Reg_route>{


  User? findUserByLoginAndPassword(List<User> userList, String login, String password) {
    try {
      return userList.firstWhere(
          (user) => user.email == login && user.password == password);
    } catch (e) {
      return null;
    }
  }

  String user_email = "";
  String user_password = "";
  bool _isObscured = true;

  @override
  bool? isCheked = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        title: Text(
          'Вход',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Oswald',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
     // backgroundColor: Color.fromARGB(255, 255, 247, 225),
      backgroundColor: Colors.red,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 30,),
          // Row(
          //SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/slogan.svg',
                // Укажите размер изображения
                width: MediaQuery.of(context).size.width * 0.86,
                //height: 130,
              )
            ],
          ),

          SizedBox(
            height: 40,
          ),

          Card(
            color: Color.fromARGB(200, 255, 255, 255),
            child: TextField(
              onChanged: (String user_name) {
                setState(() {
                  user_email = user_name.trim();
                });
              },
              decoration:
                  //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                  const InputDecoration(
                icon: Icon(Icons.account_circle_outlined,
                    size: 25, color: Color.fromARGB(255, 50, 50, 50)),
                labelText: 'Логин',
                labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontFamily: 'Oswald'),
                contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              ),
            ),
          ),

          SizedBox(
            height: 30,
          ),

          Card(
            color: Color.fromARGB(200, 255, 255, 255),
            child: TextField(
              obscureText: _isObscured,
              onChanged: (String password) {
                user_password = password.trim();
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  size: 25,
                  color: Color.fromARGB(255, 50, 50, 50),
                ),
                suffix: IconButton(
                  icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                labelText: 'Пароль',
                labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontFamily: 'Oswald'),
                contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              ),
            ),
          ),

          // SizedBox(height: 20,),
          // Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.fromLTRB(11.0, 0.0, 0.0, 0.0),
          //       ),
          //       Checkbox(
          //           value: isCheked,
          //           tristate: true,
          //           activeColor: Colors.green,
          //           onChanged: (now_checked){
          //             setState((){
          //               isCheked = true;
          //             });
          //           }),
          //       Text('Запомнить меня', style:
          //       TextStyle(
          //         fontSize: 15,
          //         fontFamily: 'Oswald',
          //       )
          //       ),
          //     ]
          // ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
              ),
              TextButton(
                onPressed: () async {
                  if (findUserByLoginAndPassword(
                          Users, user_email, user_password) ==
                      null) {
                    await User().login(user_email, user_password);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Home()));
                  } else {
                    current_user = findUserByLoginAndPassword(
                        Users, user_email, user_password)!;
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Home()));
                  }
                },
                child: Text(
                  'Войти',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontFamily: 'Oswald',
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 163, 161, 225),
                    ),
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width - 20, 40))),
              )
            ],
          ),

          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Home_route()));
                },
                child: Text(
                  'Зарегестрироваться',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontFamily: 'Oswald',
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 158, 158, 158),
                    ),
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width - 20, 40))),
              )
            ],
          )
        ],
      ),
    );
  }
}
