import 'dart:convert';

import 'dart:io';
import 'dart:js_util';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2/pages/MyWidgets/Avatar_builder.dart';
import 'package:im2/pages/first_page.dart';
import 'package:im2/pages/home.dart';
import 'package:im2/pages/Users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:html' as html;

import 'package:im2/services/api/api_service.dart';

class PickedImage {
  final XFile file;
  final String url;

  PickedImage({required this.file, required this.url});
}

bool _isObscured = true;
bool _isObscured2 = true;
String name = "";

class Reg_p extends StatefulWidget {
  const Reg_p({Key? key}) : super(key: key);
  static const routeName = "reg_page";

  @override
  Reg_page createState() => Reg_page();
}

class Reg_page extends State<Reg_p> {
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool? isCheked = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromARGB(255, 244, 244, 244)),
      home: Home_route(),
      routes: {Home.routeName: (_) => Home()},
    );
  }
//const Account({Key? key}) : super(key: key);
}

class Home_route extends StatefulWidget {
  @override
  Home_route_state createState() => Home_route_state();
}

class Home_route_state extends State<Home_route> {
  String? avatarUrl;
  File? avatarFile;
  String user_name_reg = "";
  String user_email = "";
  String user_password = "";
  String user_description = "";
  int user_age = 0;
  DateTime birth_date = DateTime.now();
  String check_password = "";

  pickImage() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    // final input = html.FileUploadInputElement();
    // input.accept = 'image/*';
    // input.click();
    //
    // await input.onChange.first;
    // final file = input.files!.first;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //
    // final reader = html.FileReader();
    // reader.readAsDataUrl(file);
    //
    // await reader.onLoad.first;
    // final encodedImage = reader.result as String;
//basename() function will give you the filename
//     final pickedImage = PickedImage(file: image!, url: encodedImage);
    //Create a reference to the location you want to upload to in firebase
    Reference reference =
        FirebaseStorage.instance.ref().child('profileImage/${image!.name}');

    //Upload the file to firebase
    TaskSnapshot uploadTask =
        await reference.putData(await image!.readAsBytes());
    var url = await uploadTask.ref.getDownloadURL();
    print(url);
    setState(() {
      this.avatarUrl = url;
    });

    // return pickedImage;
  }

  bool isValidPassword(String password) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9@#!]{7,}$');
    if (!regExp.hasMatch(password)) {
      // Если строка пароля не соответствует заданному шаблону, вы можете вывести сообщение об ошибке или выполнить другие действия.
      return false;
    }
    return true;
  }

  @override
  bool? isCheked = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/arrow_left_b4qjl27buokr.svg',
              width: 30,
              height: 30,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          title: Text(
            'Регистрация',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Oswald',
              color: Color.fromARGB(255, 50, 50, 50),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(255, 255, 247, 225),
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/bg_img.png',
                // Укажите размер изображения
                width: MediaQuery.of(context).size.width * 1,
                //height: MediaQuery.of(context).size.height * 1,
                fit: BoxFit.fill,
              ),
            ],
          ),
          ListView(
            children: [
              //SafeArea(child:
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Center(
                        child: Stack(children: <Widget>[
                          Center(
                              child: Container(
                            child: buildAvatar(context, avatarUrl),
                            //padding: EdgeInsets.all(8),
                          )),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(165, 20, 0, 0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 163, 161, 225),
                                child: IconButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  color: Color.fromARGB(255, 50, 50, 50),
                                  icon: SvgPicture.asset(
                                    'assets/Camera_icon-icons.com_55948.svg',
                                    width: 22,
                                    height: 22,
                                    color: Color.fromARGB(255, 50, 50, 50),
                                  ),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: TextField(
                      onChanged: (String user_name) {
                        setState(() {
                          user_name_reg = user_name.trim();
                        });
                      },
                      maxLength: 28,
                      //obscureText: true,
                      decoration:
                          //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                          InputDecoration(
                        labelText: 'Имя пользователя',
                        labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            fontFamily: 'Oswald'),
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime.now(),
                        ).then((value) {
                          print("Selected date: $value");
                          setState(() {
                            birth_date = value!;
                          });
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'Дата     ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontFamily: 'Oswald',
                            ),
                          ),
                          Text(
                            birth_date != null
                                ? "${birth_date.day}/${birth_date.month}/${birth_date.year}"
                                : "",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontFamily: 'Oswald',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: TextField(
                      maxLength: 270,
                      //keyboardType: TextInputType.emailAddress,
                      // obscureText: true,
                      decoration:
                          //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                          InputDecoration(
                        labelText:
                            'Опишите себя: вашу профессию, образование, хобби...',
                        labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            fontFamily: 'Oswald'),
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      ),
                      onChanged: (String description) {
                        user_description = description.trim();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      // obscureText: true,
                      decoration:
                          //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                          InputDecoration(
                        labelText: 'Почта',
                        labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            fontFamily: 'Oswald'),
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      ),
                      onChanged: (String email) {
                        user_email = email.trim();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: TextField(
                      obscureText: _isObscured,
                      onChanged: (String password) {
                        user_password = password.trim();
                      },
                      decoration: InputDecoration(
                        suffix: IconButton(
                          icon: _isObscured
                              ? SvgPicture.asset(
                            'assets/visibility_off.svg',
                            width: 24,
                            height: 24,
                          )
                              : SvgPicture.asset(
                            'assets/visibility.svg',
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                        labelText: 'Пароль',
                        labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            fontFamily: 'Oswald'),
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: TextField(
                      obscureText: _isObscured2,
                      onChanged: (String check) {
                        check_password = check;
                      },
                      decoration:
                          //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                          InputDecoration(
                            suffix: IconButton(
                              icon: _isObscured
                                  ? SvgPicture.asset(
                                'assets/visibility_off.svg',
                                width: 24,
                                height: 24,
                              )
                                  : SvgPicture.asset(
                                'assets/visibility.svg',
                                width: 24,
                                height: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                        labelText: 'Подтверждение пароля',
                        labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            fontFamily: 'Oswald'),
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () async {
                      if ((user_name_reg == "") ||
                          (user_password == "") ||
                          (avatarUrl == "") ||
                          (user_description == "") ||
                          (user_email == "") ||
                          (check_password == "")) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Вы заполнили не все поля!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oswald',
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            });
                      } else if (user_password != check_password) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Пароли не совпадают!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oswald',
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            });
                      } else if (((DateTime.now()
                                      .difference(birth_date)
                                      .inDays /
                                  365)
                              .floor() <
                          16)) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text(
                                  "К сожалению, вы не достигли возраста 16-ти лет и не можете использовать приложение.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oswald',
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            });
                      } else if (!isValidPassword(user_password)) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text(
                                  "Ваш пароль не соответствует правилам",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oswald',
                                    color: Colors.black,
                                  ),
                                ),
                                content: Text(
                                    "Ваш пароль должен состоять только из символов латинского алфавита, цифр и символов @, # и !. Также длина пароля не должна быть меньше 7 символов"),
                              );
                            });
                      } else {
                        await User().register(
                            user_name_reg,
                            user_password,
                            avatarUrl,
                            (DateTime.now().difference(birth_date).inDays / 365)
                                .floor(),
                            Users.length,
                            user_description,
                            user_email,
                            false);
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Home()));
                      }
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 163, 161, 225),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width - 20, 40))),
                    child: const Text(
                      'Зарегестрироваться',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 50, 50, 50),
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
              // )
            ],
          ),
        ]));
  }
}
