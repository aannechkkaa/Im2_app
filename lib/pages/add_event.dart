import 'dart:convert';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im2/pages/Event.dart';
import 'package:im2/pages/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2/pages/edit_profile.dart';
import 'package:im2/pages/home.dart';
import 'package:im2/pages/Events.dart';
import 'package:im2/pages/Users.dart';
import 'package:im2/pages/MyWidgets/add_e_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:email_validator/email_validator.dart';

import 'dart:html' as html;

void sortByNearestDate(List<Event> events) {
  for (int i = 0; i < events.length - 1; i++) {
    for (int j = i + 1; j < events.length; j++) {
      DateTime date1 = DateTime(
          events[i].Date.year, events[i].Date.month, events[i].Date.day);
      DateTime date2 = DateTime(
          events[j].Date.year, events[j].Date.month, events[j].Date.day);

      if (date2.isBefore(date1)) {
        Event temp = events[i];
        events[i] = events[j];
        events[j] = temp;
      }
    }
  }
}

List<Event> events_add_page = [];
List<Event> filtred_events = [];
List<Event> current_events = [];

int Event_index = 0;
DateTime now = DateTime.now();
DateTime e_Datetime = DateTime.now();
TimeOfDay e_dateTime = TimeOfDay.now();
String e_name = "";
String s_description = "";
String l_description = "";
String e_place = "";
String e_date = "";
String e_time = "";
int e_index = 0;
String _selectedCategory = "";
bool del_1 = false;
bool del_2v = false;
String create_bot_link = 'https://t.me/PalPartybot';
int image_count = 0;
String event_chat_url = "";
String event_type = "Категория мероприятия";
bool type_is_chosen = false;

// class PhotoItem {
//   final String imagePath;
//
//   const PhotoItem({
//     required this.imagePath,
//   });
// }
// final List<PhotoItem> event_pics = [
// ];
// _launchURL(String url) async {
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
class add_event extends StatefulWidget {
  const add_event({super.key});

  @override
  State<add_event> createState() => _add_eventState();
}


class _add_eventState extends State<add_event> {
  String? pic1Url;
  String? pic2Url;

  Future pickImage() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    Reference reference = _storage.ref().child('images/${image!.name}');

    //Upload the file to firebase
    TaskSnapshot uploadTask =
        await reference.putData(await image.readAsBytes());
    var url = await uploadTask.ref.getDownloadURL();
    if (pic1Url == null) {
      setState(() => this.pic1Url = url);
    } else {
      setState(() => this.pic2Url = url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          //dialogTheme: Colors.green,
        ),
        //color: Colors.white,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 247, 225),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 244, 244, 244),
            title: const Text(
              "Добавление события",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Oswald',
                color: Color.fromARGB(255, 50, 50, 50),
              ),
            ),
            centerTitle: false,
          ),
          body: Stack(children: [
            ListView(
              children: [
                const SizedBox(
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
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            //width: 200,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 163, 161, 225),
                              borderRadius: BorderRadius.circular(5),
                              //color: Colors.white,
                            ),
                            child: DropdownButton<String>(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 50, 50, 50),
                              ),
                              iconSize: 26,
                              iconEnabledColor: Colors.white,
                              underline: SizedBox(),
                              dropdownColor: Colors.white,
                              //value: 'Категория мероприятия',
                              hint: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  event_type,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 50, 50, 50),
                                    fontFamily: 'Oswald',
                                  ),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  child: Text(
                                    "Активный отдых",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                  value: "Активный отдых",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Кафе и рестораны",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                  value: "Кафе и рестораны",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Искусство и культура",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                  value: "Искусство и культура",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Отдых на природе",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                  value: "Отдых на природе",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Путешествия",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                  value: "Путешествия",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Ночная жизнь",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald',
                                    ),
                                  ),
                                  value: "Ночная жизнь",
                                )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  event_type = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Card(
                        color: Color.fromARGB(200, 255, 255, 255),
                        child: TextField(
                          // obscureText: true,
                          //controller: _controller,
                          maxLength: 35,
                          decoration:
                              //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                              InputDecoration(
                            labelText: 'Название мероприятия',
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.blueGrey,
                                fontFamily: 'Oswald'),
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          ),
                          onChanged: (String n_value) {
                            e_name = n_value.trim();
                          },
                        ),
                      ),

                      Card(
                        color: Color.fromARGB(200, 255, 255, 255),
                        child: TextField(
                          // obscureText: true,
                          //controller: _controller,
                          maxLength: 85,
                          maxLines: 3,
                          decoration:
                              //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                              InputDecoration(
                            labelText: 'Краткое описание',
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.blueGrey,
                                fontFamily: 'Oswald'),
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          ),
                          onChanged: (String s_des) {
                            s_description = s_des.trim();
                          },
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(200, 255, 255, 255),
                        child: TextField(
                          // obscureText: true,
                          //controller: _controller,
                          maxLength: 180,
                          maxLines: 3,
                          decoration:
                              //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                              InputDecoration(
                            labelText: 'Подробное описание',
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.blueGrey,
                                fontFamily: 'Oswald'),
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          ),
                          onChanged: (String l_des) {
                            l_description = l_des.trim();
                          },
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(200, 255, 255, 255),
                        child: TextField(
                          // obscureText: true,
                          //controller: _controller,
                          maxLength: 20,
                          maxLines: 1,
                          decoration:
                              //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                              const InputDecoration(
                            labelText: 'Адрес или название места',
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.blueGrey,
                                fontFamily: 'Oswald'),
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          ),
                          onChanged: (String place) {
                            e_place = place.trim();
                          },
                        ),
                      ),
                      Row(
                        children: [
                           Column(
                            children: [
                              SizedBox(
                                width: 7,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2025),
                                  ).then((value) {
                                    print("Selected date: $value");
                                    setState(() {
                                      e_Datetime = value!;
                                    });
                                  });
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(200, 255, 255, 255),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Дата     ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueGrey,
                                        fontFamily: 'Oswald',
                                      ),
                                    ),
                                    Text(
                                      e_Datetime != null
                                          ? "${e_Datetime.day}/${e_Datetime.month}/${e_Datetime.year}"
                                          : "",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(200, 50, 50, 50),
                                        fontFamily: 'Oswald',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            children: [
                               Column(
                                children: [
                                  SizedBox(
                                    width: 7,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        //print("Selected date: $value");
                                        setState(() {
                                          e_dateTime = value!;
                                        });
                                      });
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(
                                                  200, 255, 255, 255)),
                                      //minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-5,10))
                                    ),
                                    child: Row(
                                      children: [
                                        Text('Время начала' + "      ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.blueGrey,
                                                fontFamily: 'Oswald')),
                                        Text(
                                          e_dateTime != null
                                              ? "${e_dateTime.hour.toString().padLeft(2, '0')}:${e_dateTime.minute.toString().padLeft(2, '0')}"
                                              : "",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(200, 50, 50, 50),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Column(
                              //   children: [
                              //     SizedBox(width: 25,)
                              //   ],
                              // ),
                              // Column(
                              //   children: [
                              //     Text(
                              //       e_dateTime.hour.toString() + ":" + e_dateTime.minute.toString(),
                              //       style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'Oswald'),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                          //mainAxisAlignment: MainAxisAlignment,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                openUrlInBrowser(Uri.parse(create_bot_link));
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 163, 161, 225),
                                ),
                                //minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-5,10))
                              ),
                              child: const Text("Создать чат участников",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald')),
                            ),
                            // 15
                          ]),
                      SizedBox(
                        height: 25,
                      ),
                      Card(
                        color: Color.fromARGB(200, 255, 255, 255),
                        child: TextField(
                          //controller: _controller,
                          // obscureText: true,
                          maxLength: 100,
                          maxLines: 1,
                          decoration:
                              //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                              InputDecoration(
                            labelText: 'Вставьте ссылку на чат участников',
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.blueGrey,
                                fontFamily: 'Oswald'),
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          ),
                          onChanged: (String url) {
                            event_chat_url = url.trim();
                          },
                        ),
                      ),
                      // WebView(
                      //   initialUrl: 'https://flutter.dev',
                      //   navigationDelegate: (NavigationRequest request){
                      //     if(request.url.startsWith('https://flutter.dev')){
                      //       return NavigationDecision.navigate;
                      //     }
                      //     _launchURL(request.url);
                      //     return NavigationDecision.prevent;
                      //   },
                      // ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              "Добавьте фото места/референсы мероприятия",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                                //fontFamily: 'Oswald'
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                if (pic1Url == null) {
                                  setState(() {
                                    del_1 = true;
                                  });
                                  pickImage();
                                } else if (pic2Url == null) {
                                  setState(() {
                                    del_2v = true;
                                  });
                                  pickImage();
                                } else if ((pic1Url != null) &&
                                    (pic2Url != null)) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Center(
                                            child: Text(
                                              "Вы можете добавить только 2 фотографии",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Oswald',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 163, 161, 225),
                                ),
                                //minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-5,10))
                              ),
                              child: const Text("Добавить фото",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      fontFamily: 'Oswald')),
                            ),
                          ]),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(children: <Widget>[
                                  Center(
                                    child: Container(
                                      child: add_e_image(pic1Url),
                                      //padding: EdgeInsets.all(8),
                                    ),
                                  ),
                                  Visibility(
                                      visible: del_1,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 180),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.redAccent,
                                          radius: 20,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                pic1Url = null;
                                                del_1 = false;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(children: <Widget>[
                                  Center(
                                    child: Container(
                                      child: add_e_image(pic2Url),
                                      //padding: EdgeInsets.all(8),
                                    ),
                                  ),
                                  Visibility(
                                      visible: del_2v,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 180),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.redAccent,
                                          radius: 20,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                pic2Url = null;
                                                del_2v = false;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async {
              //Event_index = events_add_page.length ;
              if (((s_description != "") &&
                      (s_description.trim().isNotEmpty)) &&
                  ((l_description != "") &&
                      (l_description.trim().isNotEmpty)) &&
                  ((e_place != "") && (e_place.trim().isNotEmpty)) &&
                  ((e_name != "") && (e_name.trim().isNotEmpty)) &&
                  ((event_type != "") && (event_type.trim().isNotEmpty)) &&
                  ((pic1Url != null) || (pic2Url != null))) {
                events_add_page.add(Event());
                //sortByNearestDate(events_add_page);
                // events_add_page.last.setEvent_autor(Users.last);
                events_add_page.last.setName(e_name);
                events_add_page.last.setShortDescription(s_description);
                events_add_page.last.setLongDescription(l_description);
                events_add_page.last.setPlace(e_place);
                events_add_page.last.setCategory(event_type);
                events_add_page.last.setTime(e_dateTime);
                events_add_page.last.setDate(e_Datetime);
                events_add_page.last.setChatLink(event_chat_url);
                events_add_page.last.setIndex(e_index);
                events_add_page.last.setPic1(pic1Url);
                events_add_page.last.setPic2(pic2Url);
                print(events_add_page.length);
                e_index++;

                // e_name = "";
                // e_place = "";
                // s_description = "";
                // l_description = "";
                // //event_type = "";
                // del_1 = false;
                // del_2v = false;
                // print(current_user.username);
                // u_r_member = isUserExist(
                //     events_add_page[Event_index].participants, current_user.id);
                // Event_index = e_index - 1;
                setState(() {});
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Center(
                          child: Text(
                            "Вы должны заполнить все поля и добавить как минимум одну картинку!",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Oswald',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    });
              }

              await Event().addEvent(
                  e_name,
                  event_type,
                  s_description,
                  l_description,
                  e_place,
                  e_Datetime,
                  "${e_dateTime.hour}:${e_dateTime.minute}",
                  event_chat_url,
                  pic1Url,
                  pic2Url,
                  current_user);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const Home()));
            },
            child: SvgPicture.asset(
              'assets/add_icon_white.svg',
              // Укажите размер изображения
              width: 37,
              height: 37,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: Colors.white,
              child: IconTheme(
                data: IconThemeData(color: Colors.deepOrange),
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: (() {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: Home()));
                                  }),
                                  icon: const Icon(
                                    Icons.map_outlined,
                                    color: Color.fromARGB(255, 50, 50, 50),
                                    size: 25,
                                  )),
                              const Text(
                                'Обзор',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Oswald',
                                  color: Color.fromARGB(255, 50, 50, 50),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: (() {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: Reg_p()));
                                }),
                                icon: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 50, 50, 50),
                                      width: 1.7,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      current_user.avatarUrl!,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                'Профиль',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Oswald',
                                    color: Color.fromARGB(255, 50, 50, 50)),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              )),
        ));
  }

  void openUrlInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
