
import 'dart:convert';
import 'dart:html';
import 'dart:js_util';
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
@override
Widget build(BuildContext context ){
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
}

class _Edit_pageState extends State<Edit_page> {


  String? edit_avatar;
  String user_name_edit = "";
  String user_email_edit = "";
  String user_password_edit = "";
  //String user_description = "";
  int user_age = current_user.age;
  DateTime birth_date = DateTime(DateTime.now().year - current_user.age, DateTime.now().month, DateTime.now().day);
  String check_password = "";


  User? findUserByLoginAndPassword(List<User> userList, String login, String password) {
    try {
      return userList.firstWhere((user) => user.email == login && user.password == password);
    } catch (e) {
      return null;
    }
  }

  Future pickImage() async {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    await input.onChange.first;
    final file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsDataUrl(file);

    await reader.onLoad.first;
    final encodedImage = reader.result as String;

    final bytes = base64.decode(encodedImage.split(',').last);
    final blob = html.Blob([bytes], 'image/jpeg');
    final url = html.Url.createObjectUrl(blob);

    setState(() => this.edit_avatar = url);
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
        backgroundColor:  Color.fromARGB(255, 244, 244, 244),
        title: Text('Редактировать профиль', style:
        TextStyle(
          fontSize: 30,
          fontFamily: 'Oswald',
          color: Color.fromARGB(255, 50, 50, 50),
        ),
        ),
        centerTitle: true,
      ),
      backgroundColor:  Color.fromARGB(255, 255, 247, 225),

      body:

      Stack(
        children: [
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
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child:

                  Center(
                    child:
                    Stack(
                        children: <Widget>[



                          Center(

                              child:
                              Container(
                                child: buildAvatar(edit_avatar),
                                //padding: EdgeInsets.all(8),
                              )


                          ),
                          Center(
                            child:
                            Padding(padding: EdgeInsets.fromLTRB(165, 20, 0, 0),
                              child:

                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color.fromARGB(255, 163, 161, 225),
                                child: IconButton(onPressed: (){

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
                  )


              ),




              SizedBox(height: 30,),
              Card(
                color: Color.fromARGB(200, 255, 255, 255),
                child: TextField(
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
                    labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey, fontFamily: 'Oswald'),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              SizedBox(height: 10,),
              Card(
                color: Color.fromARGB(200, 255, 255, 255),
                child:
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:DateTime(1900, 1, 1),
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

              SizedBox(height: 10,),

              Card(
                color: Color.fromARGB(200, 255, 255, 255),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  // obscureText: true,
                  decoration:
                  //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                  InputDecoration(
                    labelText: 'Почта',
                    labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey, fontFamily: 'Oswald'),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  ),
                  onChanged: (String email) {
                    user_email_edit = email.trim();
                  },
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Color.fromARGB(200, 255, 255, 255),
                child: TextField(
                  obscureText: _isObscured,
                  onChanged: (String password) {
                    user_password_edit = password.trim();
                  },
                  decoration: InputDecoration(
                    suffix: IconButton(
                      icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                    labelText: 'Пароль',
                    labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey, fontFamily: 'Oswald'),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Color.fromARGB(200, 255, 255, 255),
                child: TextField(
                  obscureText: _isObscured2,
                  onChanged: (String check){
                    check_password = check;
                  },
                  decoration:
                  //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                  InputDecoration(

                    suffix: IconButton(
                      icon: Icon(_isObscured2 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscured2 = !_isObscured2;
                        });
                      },
                    ),

                    labelText: 'Подтверждение пароля',
                    labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey, fontFamily: 'Oswald'),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  ),
                ),
              ),

              SizedBox(height: 50,),






              TextButton(
                onPressed: () {
                  if((user_name_edit != "")&&(user_name_edit.trim().isNotEmpty)){
                    Users[(findUserByLoginAndPassword(Users, current_user.email, current_user.password)!.id) - 1].updateUsername(user_name_edit);
                    current_user.updateUsername(user_name_edit);
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));
                  }
                  if(edit_avatar != null){

                    Users[(findUserByLoginAndPassword(Users, current_user.email, current_user.password)!.id) - 1].updateAvatarUrl(edit_avatar);
                    current_user.updateAvatarUrl(edit_avatar);
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));
                  }
                  if((user_password_edit != "")&&(user_password_edit.trim().isNotEmpty)) {
                    if (user_password_edit != check_password) {
                      showDialog(
                          context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Пароли не совпадают!",
                            style:
                            TextStyle(
                              fontSize: 18,
                              fontFamily: 'Oswald',
                              color: Colors.black,
                            ),),

                        );
                      });
                    }

                    else  if (!isValidPassword(user_password_edit)) {
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Ваш пароль не соответствует правилам",
                            style:
                            TextStyle(
                              fontSize: 18,
                              fontFamily: 'Oswald',
                              color: Colors.black,
                            ),),
                          content: Text(
                              "Ваш пароль должен состоять только из символов латинского алфавита, цифп и символов @, # и !. Также длина пароля не должна быть меньше 7 символов."
                          ),

                        );
                      });
                    }

                    else{
                      Users[(findUserByLoginAndPassword(Users, current_user.email, current_user.password)!.id) - 1].updatePassword(user_password_edit.trim());
                      current_user.updatePassword(user_password_edit.trim());

                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));

                    }
                  }

                  if((user_email_edit != "")||(user_email_edit.trim().isNotEmpty)){
                    Users[(findUserByLoginAndPassword(Users, current_user.email, current_user.password)!.id) - 1].updateEmail(user_email_edit.trim());

                    current_user.updateEmail(user_email_edit.trim());
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));
                  }
                  if((DateTime.now().difference(birth_date).inDays / 365).floor() != current_user.age){

                    if(((DateTime.now().difference(birth_date).inDays / 365).floor() < 16)){
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("К сожалению, ваш новый возраст меньше 16-ти лет",
                            style:
                            TextStyle(
                              fontSize: 18,
                              fontFamily: 'Oswald',
                              color: Colors.black,
                            ),),

                        );
                      });
                    }

                    else{
                      Users[(findUserByLoginAndPassword(Users, current_user.email, current_user.password)!.id) - 1].updateAge((DateTime.now().difference(birth_date).inDays / 365).toInt());
                      current_user.updateAge((DateTime.now().difference(birth_date).inDays / 365).toInt());

                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));
                    }

                  }


                  // else{
                  //   User user = User();
                  //   Users.add(User(
                  //
                  //   )
                  //   );
                  //   Users.last.register(user_name_reg, user_password, avatarUrl, (DateTime.now().difference(birth_date).inDays / 365).floor() , Users.length, user_description, user_email);
                  //   Navigator.of(context).pushNamed(Home.routeName);
                  // }

                },

                child: Text('Изменить данные', style:
                TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 50, 50, 50),
                  fontFamily: 'Oswald',
                ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 163, 161, 225)),
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-20,40))
                ),
              ),
              SizedBox(height: 25,),









              TextButton(onPressed: (){
                current_user = newObject();
                Navigator.push(context, PageTransition(
                    type: PageTransitionType.fade,
                    // duration: Duration.millisecondsPerSecond(),
                    alignment: Alignment.center,
                    child: First_p())
                );
              },
                  child: Text("Выход",
                    style:
                    TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 50, 50, 50),
                      fontFamily: 'Oswald',
                    ),),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 158, 158, 158),),
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-20,40))
                ),


              ),

              SizedBox(
                height: 50,
              )
            ],
          ),
          // )
        ],
      ),
      ]
      ),

    );
  }
}



