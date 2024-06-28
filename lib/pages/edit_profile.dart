import 'dart:convert';
import 'dart:html';
import 'dart:js_util';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2/pages/MyWidgets/Avatar_builder.dart';
import 'package:im2/pages/home.dart';
import 'package:im2/pages/Users.dart';
import 'package:im2/pages/first_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';

//import 'package:email_validator/email_validator.dart';
import 'package:im2/pages/account.dart';
import 'dart:html' as html;

bool _isObscured = true;
bool _isObscured2 = true;
String name = "";

TextEditingController date = TextEditingController();

// class ToggleSwitch extends StatefulWidget {
//   @override
//   _ToggleSwitchState createState() => _ToggleSwitchState();
// }
//
// class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isSwitched = current_user.is_admin;
//
  Future<void> _toggleSwitch(bool value) async {

      isSwitched = value;

    await User().updateTheme(current_user, value);

      current_user.is_admin = value; // или isSwitched вместо value, если так задумано
  }



//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: current_user.is_admin,
//       onChanged: _toggleSwitch,
//       activeTrackColor: Colors.white,
//       activeColor: Colors.deepPurpleAccent,
//     );
//   }
// }

@override
Widget build(BuildContext context) {
  bool? isCheked = false;
  return MaterialApp(
    theme: ThemeData(primaryColor: Colors.green),
    //home: Home_route(),
    //routes: {Home.routeName: (_)=> Home()},
  );
}
//const Account({Key? key}) : super(key: key);

class Edit_page extends StatefulWidget {
  const Edit_page({super.key});

  @override

  State<Edit_page> createState() => _Edit_pageState();
  //_ToggleSwitchState createState() => _ToggleSwitchState();
}

class _Edit_pageState extends State<Edit_page> {
  String? edit_avatar = current_user.avatarUrl;
  String user_name_edit = "";
  TextEditingController user_name = TextEditingController();
  String user_email_edit = current_user.email;
  TextEditingController user_email = TextEditingController();
  String user_password_edit = current_user.password;
  TextEditingController user_password = TextEditingController();
  String user_description = current_user.profile_description;
  TextEditingController user_desc = TextEditingController();
  int user_age = current_user.age;
  DateTime birth_date = DateTime(DateTime.now().year - current_user.age,
      DateTime.now().month, DateTime.now().day);
  String check_password = current_user.password;

  User? findUserByLoginAndPassword(
      List<User> userList, String login, String password) {
    try {
      return userList.firstWhere(
          (user) => user.email == login && user.password == password);
    } catch (e) {
      return null;
    }
  }

  pickImage() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    Reference reference = _storage.ref().child('profileImage/${image!.name}');

    //Upload the file to firebase
    TaskSnapshot uploadTask =
        await reference.putData(await image.readAsBytes());
    var url = await uploadTask.ref.getDownloadURL();
    print(url);
    setState(() {
      edit_avatar = url;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    user_name.text = current_user.username;
    user_email.text = current_user.email;
    user_password.text = current_user.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color.fromARGB(255, 50, 50, 50),
          iconSize: 30,
          onPressed: () => {
            Navigator.of(context).pop(),
          },
        ),
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        title: Text(
          'Редактировать профиль',
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
                          child: buildAvatar(context, edit_avatar),
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
                                color: Colors.white,
                                icon: Icon(Icons.camera_alt_outlined),
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

                Center(
                  child:
                  Switch(
                    value: current_user.is_admin,
                    onChanged: _toggleSwitch,
                    activeTrackColor: Colors.white,
                    activeColor: Colors.deepPurpleAccent,
                  ),
                ),

                Card(
                  color: Color.fromARGB(200, 255, 255, 255),
                  child: TextField(
                    controller: user_name,
                    onChanged: (String user_name) {
                      setState(() {
                        user_name_edit = user_name.trim();
                      });
                    },
                    //obscureText: true,
                    decoration:
                        //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                        InputDecoration(
                      labelText: 'Имя пользователя',
                      labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontFamily: 'Oswald'),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    ),
                  ),
                ),

                // SizedBox(height: 10,),
                //
                // Card(
                //   child: TextField(
                //     //keyboardType: TextInputType.emailAddress,
                //     // obscureText: true,
                //     decoration:
                //     //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                //     InputDecoration(
                //       labelText: 'Опишите себя: вашу профессию, образование, хобби...',
                //       labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey, fontFamily: 'Oswald'),
                //       contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                //     ),
                //     onChanged: (String description) {
                //       user_description = description.trim();
                //     },
                //   ),
                // ),

                SizedBox(
                  height: 10,
                ),

                Card(
                  color: Color.fromARGB(200, 255, 255, 255),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    // obscureText: true,
                    controller: user_email,
                    decoration:
                        //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                        InputDecoration(
                      labelText: 'Почта',
                      labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontFamily: 'Oswald'),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    ),
                    onChanged: (String email) {
                      user_email_edit = email.trim();
                    },
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Card(
                  color: Color.fromARGB(200, 255, 255, 255),
                  child: TextField(
                    //keyboardType: TextInputType.emailAddress,
                    // obscureText: true,
                    controller: user_desc,
                    decoration:
                    //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                    InputDecoration(
                      labelText: 'Описание профиля',
                      labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontFamily: 'Oswald'),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
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
                    controller: user_password,
                    obscureText: _isObscured,
                    onChanged: (String password) {
                      user_password_edit = password.trim();
                    },
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(_isObscured
                            ? Icons.visibility_off
                            : Icons.visibility),
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
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
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
                        icon: Icon(_isObscured2
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscured2 = !_isObscured2;
                          });
                        },
                      ),
                      labelText: 'Подтверждение пароля',
                      labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontFamily: 'Oswald'),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),

                TextButton(
                  onPressed: () async {
                    // if ((user_name_edit != "") &&
                    //     (user_name_edit
                    //         .trim()
                    //         .isNotEmpty)) {
                    //   Users[(findUserByLoginAndPassword(
                    //       Users,
                    //       current_user.email,
                    //       current_user.password)!
                    //       .id) -
                    //       1]
                    //       .updateUsername(user_name_edit);
                    //   current_user.updateUsername(user_name_edit);
                    //   Navigator.push(
                    //       context,
                    //       PageTransition(
                    //           type: PageTransitionType.fade, child: Reg_p()));
                    // }
                    // if (edit_avatar != null) {
                    //   Users[(findUserByLoginAndPassword(
                    //       Users,
                    //       current_user.email,
                    //       current_user.password)!
                    //       .id) -
                    //       1]
                    //       .updateAvatarUrl(edit_avatar);
                    //   current_user.updateAvatarUrl(edit_avatar);
                    //   Navigator.push(
                    //       context,
                    //       PageTransition(
                    //           type: PageTransitionType.fade, child: Reg_p()));
                    // }
                    if ((user_password_edit != "") &&
                        (user_password_edit.trim().isNotEmpty)) {
                      if (user_password_edit != check_password) {
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
                      } else if (!isValidPassword(user_password_edit)) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Ваш пароль не соответствует правилам",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oswald',
                                    color: Colors.black,
                                  ),
                                ),
                                content: Text(
                                    "Ваш пароль должен состоять только из символов латинского алфавита, цифп и символов @, # и !. Также длина пароля не должна быть меньше 7 символов."),
                              );
                            });
                      } else {
                        // Users[(findUserByLoginAndPassword(
                        //     Users,
                        //     current_user.email,
                        //     current_user.password)!
                        //     .id) -
                        //     1]
                        //     .updatePassword(user_password_edit.trim());
                        // current_user.updatePassword(user_password_edit.trim());
                        //
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.fade, child: Reg_p()));
                      }
                    }

                    // if ((user_email_edit != "") ||
                    //     (user_email_edit
                    //         .trim()
                    //         .isNotEmpty)) {
                    //   Users[(findUserByLoginAndPassword(
                    //       Users,
                    //       current_user.email,
                    //       current_user.password)!
                    //       .id) -
                    //       1]
                    //       .updateEmail(user_email_edit.trim());
                    //
                    //   current_user.updateEmail(user_email_edit.trim());
                    //   Navigator.push(
                    //       context,
                    //       PageTransition(
                    //           type: PageTransitionType.fade, child: Reg_p()));
                    // }
                    // if ((DateTime
                    //     .now()
                    //     .difference(birth_date)
                    //     .inDays / 365)
                    //     .floor() !=
                    //     current_user.age) {
                    //   if (((DateTime
                    //       .now()
                    //       .difference(birth_date)
                    //       .inDays / 365)
                    //       .floor() <
                    //       16)) {
                    //     showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //           return AlertDialog(
                    //             title: Text(
                    //               "К сожалению, ваш новый возраст меньше 16-ти лет",
                    //               style: TextStyle(
                    //                 fontSize: 18,
                    //                 fontFamily: 'Oswald',
                    //                 color: Colors.black,
                    //               ),
                    //             ),
                    //           );
                    //         });
                    //   } else {
                    //     Users[(findUserByLoginAndPassword(
                    //         Users,
                    //         current_user.email,
                    //         current_user.password)!
                    //         .id) -
                    //         1]
                    //         .updateAge(
                    //         (DateTime
                    //             .now()
                    //             .difference(birth_date)
                    //             .inDays /
                    //             365)
                    //             .toInt());
                    //     current_user.updateAge(
                    //         (DateTime
                    //             .now()
                    //             .difference(birth_date)
                    //             .inDays / 365)
                    //             .toInt());
                    //
                    //     Navigator.push(
                    //         context,
                    //         PageTransition(
                    //             type: PageTransitionType.fade, child: Reg_p()));
                    //   }
                    // }

                    // else{
                    //   User user = User();
                    //   Users.add(User(
                    //
                    //   )
                    //   );
                    //   Users.last.register(user_name_reg, user_password, avatarUrl, (DateTime.now().difference(birth_date).inDays / 365).floor() , Users.length, user_description, user_email);
                    //   Navigator.of(context).pushNamed(Home.routeName);
                    // }
                    await User().updateData(
                      current_user.id,
                      user_name.text,
                      user_email.text,
                      user_description,
                      user_password.text,
                      edit_avatar,
                    );
                    current_user.username = user_name.text;
                    current_user.profile_description = user_description;
                    current_user.avatarUrl = edit_avatar;
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Изменить данные',
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
                          Color.fromARGB(255, 163, 161, 225)),
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width - 20, 40))),
                ),
                SizedBox(
                  height: 25,
                ),

                TextButton(
                  onPressed: () {
                    current_user = newObject();
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            // duration: Duration.millisecondsPerSecond(),
                            alignment: Alignment.center,
                            child: First_p()));
                  },
                  child: Text(
                    "Выход",
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
                ),

                SizedBox(
                  height: 50,
                )
              ],
            ),
            // )
          ],
        ),
      ]),
    );
  }
}
