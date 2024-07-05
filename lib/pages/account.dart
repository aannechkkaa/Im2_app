import 'dart:convert';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:im2/pages/add_event.dart';
import 'package:im2/pages/Users.dart';
import 'package:im2/pages/Events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2/pages/MyWidgets/Avatar_builder.dart';
import 'package:im2/pages/home.dart';
import 'package:im2/pages/edit_profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';
import 'package:im2/pages/Event.dart';

import 'dart:html' as html;

import 'Chats.dart';
import 'MyWidgets/home_pics.dart';

class Reg_p extends StatefulWidget {
  const Reg_p({Key? key}) : super(key: key);
  static const routeName = "reg_page";

  @override
  Reg_page createState() => Reg_page();
}

class Reg_page extends State<Reg_p> {
  String? avatarUrl;

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

    setState(() => this.avatarUrl = url);
  }

  List<Event> my_events = events_add_page
      .where((event) => event.event_autor.id == current_user.id)
      .toList();

  String userName = current_user.username;
  int userAge = current_user.age;
  int user_raiting = 5;
  String user_description =
      "Я Андрей люблю друзей, театры, кино вытсавки, учусь в ДВФУ по направлению прикладная информатика";
  String? User_avatar_url = current_user.avatarUrl;
  TextEditingController date = TextEditingController();
  List<dynamic> listEvents = [];

  @override
  void initState() {
    super.initState();
    Event().getEvent().then((value) {
      listEvents = value
          .where((e) => e["event_autor"]["id"] == current_user.id)
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromARGB(255, 244, 244, 244)),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: Edit_page()));
              },
              icon:Container(
                width: 35.0,
                height: 35.0,
                child: ClipOval(
                  child: Image.asset(
                    'assets/settings_35dp_323232.png',
                    width: 35,
                    height: 35,
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
              iconSize: 35,
            )
          ],
          // leading: Padding(padding: EdgeInsets.only(
          //     left: 12.0, top: 7.0, bottom: 7.0),
          //   child:
          //   ClipOval(
          //     child: Image.network(
          //       Users.last.avatarUrl!,
          //       width: 20,
          //       height: 20,
          //       fit: BoxFit.cover,
          //     ),
          //   )
          // ),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          title: Text(
            'Профиль',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Oswald',
              color: Color.fromARGB(255, 50, 50, 50),
            ),
          ),
          centerTitle: false,
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
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Center(
                        child: Stack(children: <Widget>[
                          Center(
                              child: Container(
                            child: buildAvatar(context, User_avatar_url),
                            //padding: EdgeInsets.all(8),
                          )),
                          // Center(
                          //   child:
                          //   Padding(padding: EdgeInsets.fromLTRB(165, 20, 0, 0),
                          //     child:
                          //
                          //     CircleAvatar(
                          //       radius: 20,
                          //       backgroundColor: Color.fromARGB(255, 247, 183, 59),
                          //       child: IconButton(onPressed: (){
                          //
                          //         pickImage();
                          //       },
                          //
                          //         color: Colors.white,
                          //         icon: Icon(Icons.camera_alt_outlined),
                          //         iconSize: 20,
                          //       ),
                          //     ),
                          //
                          //
                          //   ),
                          // ),
                        ]),
                      )),

                  Text(
                    current_user.username + ", " + current_user.age.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Oswald',
                      color: Color.fromARGB(255, 50, 50, 50),
                    ),
                  ),
                  //Row(
                  //children: [
                  // Center(
                  //     child:
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Ваш рейтинг: " + user_raiting.toString(),
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //           ),
                  //         ),
                  //         Icon(
                  //           Icons.star_rate_rounded,
                  //         ),
                  //         // SizedBox(
                  //         //   width: 2,
                  //         // ),
                  //         Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //             child:
                  //             IconButton(onPressed: (){
                  //               showDialog(context: context, builder: (BuildContext context) {
                  //                 return AlertDialog(
                  //                     title: Text("На чем основан рейтинг?",
                  //                       style:
                  //                       TextStyle(
                  //                         fontSize: 20,
                  //                         fontFamily: 'Oswald',
                  //                         color: Colors.black,
                  //                       ),),
                  //
                  //                     content:
                  //                     SizedBox(
                  //                       height: 330,
                  //                       child:
                  //                       Column(
                  //                         children: [
                  //                           Text(
                  //                             "Рейтинг создан для повышения безопасности реальных встреч.",
                  //
                  //                           ),
                  //                           Text(
                  //                               "Он помогает модераторам приложения отследить фэйковые страницы и блокировать пользователей, зарегестировавшихся под чужими фото и именами."
                  //                           ),
                  //                           Text(
                  //                               "Рейтинг выставляют участники посещенных вами событий."
                  //                           ),
                  //                           Text(
                  //                               "Также рейтинг может снижаться, если вы регулярно не приходили на мероприятия без предупрждения участников."
                  //                           )
                  //                         ],
                  //                       ),
                  //                     )
                  //                 );
                  //               });
                  //             },
                  //               icon: Icon(
                  //                   Icons.info_outline
                  //               ),
                  //               color: Colors.grey,
                  //               iconSize: 15,
                  //             )
                  //         )
                  //
                  //       ],
                  //     )
                  // ),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      current_user.profile_description,
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'Oswald',
                        color: Colors.blueGrey,
                      ),
                    ),
                  )),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: const EdgeInsets.all(15.0),
                        // padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 1.4))),
                        child: const SizedBox(
                          width: 300,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Созданные вами события",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Oswald',
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  listEvent()
                  // ],
                  //),
                ],
              ),
            ],
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    // duration: Duration.millisecondsPerSecond(),
                    alignment: Alignment.center,
                    child: add_event()));
          },
          child: SvgPicture.asset(
            'assets/add_icon.svg',
            // Укажите размер изображения
            width: 35,
            height: 35,
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
                              icon: Container(
                                width: 150.0,
                                height: 150.0,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/map_grey.png',
                                    width: 20,
                                    height: 20,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ),
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
                                //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));
                              }),
                              icon: Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 74, 68, 134),
                                    width: 1.7,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    current_user.avatarUrl ?? "",
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Профиль',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Oswald',
                                color: Color.fromARGB(255, 74, 68, 134),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            )),
      ),
    );
  }

  listEvent() {
    return SizedBox(
      height: listEvents.length * 250,
      child: ListView.builder(
          itemCount: listEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          //fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 170),
                          padding: const EdgeInsets.all(0),

                          backgroundColor: Colors.transparent,
                          //borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: const BorderSide(
                              color: Colors.transparent, width: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Event_page(
                                        event: listEvents[index],
                                      )));
                        },
                        // key: Key(current_events[index].index.toString()),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          //height: 185,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
                          // constraints: BoxConstraints(
                          //   minHeight: 40, //minimum height
                          //   maxHeight: 185,
                          // ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(207, 92, 90, 124),
                          ),
                          child:

                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 20),
                                      Text(
                                        "${DateTime.parse(listEvents[index]["date"]).day}/${DateTime.parse(listEvents[index]["date"]).month}/${DateTime.parse(listEvents[index]["date"]).year.toInt() % 100}",
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Oswald',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        listEvents[index]["time"].split(':').map((e) => e.padLeft(2, '0')).join(':'),
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Oswald',
                                          color: Color.fromARGB(255, 248, 231, 174),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Row(
                                      //   children: [
                                      //     SizedBox(
                                      //       width: 70,
                                      //       child: Column(
                                      //         children: [
                                      //           Row(
                                      //             children: [
                                      //                Column(
                                      //                 children: [
                                      //                   Icon(Icons.place_outlined),
                                      //                 ],
                                      //               ),
                                      //               Column(
                                      //                 children: [
                                      //                   Container(
                                      //                     width: 40,
                                      //                     child: Flexible(
                                      //                       child: Text(
                                      //                         listEvent[index]
                                      //                             ["place"],
                                      //                         softWrap: true,
                                      //                         maxLines: 2,
                                      //                         style:
                                      //                             const TextStyle(fontSize: 15,
                                      //                               fontFamily:
                                      //                               'Oswald',
                                      //                           color: Color.fromARGB(255, 248, 231, 174),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   )
                                      //                 ],
                                      //               )
                                      //             ],
                                      //           )
                                      //
                                      //           //Icon(Icons.place_outlined),
                                      //
                                      //           // Flexible
                                      //           //   (child: new Text(Events_list[index].place,
                                      //           //   style: TextStyle(
                                      //           //     fontSize: 15,
                                      //           //     fontFamily: 'Oswald',
                                      //           //     color: Color.fromARGB(255, 154, 220, 184),),
                                      //           //   overflow: TextOverflow.clip,),),
                                      //         ],
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.03,
                                ),
                                //  Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         SizedBox(
                                //           height: 5,
                                //           width: 1,
                                //         )
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Image(
                                //             image: AssetImage('assets/Vector_1.png')),
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         SizedBox(
                                //           height: 5,
                                //           width: 1,
                                //         )
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  // width: 30
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            listEvents[index]["event_autor"]["avatarUrl"] ?? "",
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          //width: 30,
                                          width: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                        Text(
                                          listEvents[index]["event_autor"]["username"] + "," + " " + listEvents[index]["event_autor"]["age"].toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Oswald',
                                            color: Color.fromARGB(255, 248, 231, 174),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width *0.5,
                                          child: Text(
                                            listEvents[index]["name"],
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Oswald',
                                              color: Color.fromARGB(
                                                  255, 248, 231, 174),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width *0.5,
                                          child: Text(
                                            listEvents[index]["shortDescription"],
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Oswald',
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        )
                                      ],
                                    ),
                                    Container(
                                      child:  Row(
                                        children: [
                                          home_pics_builder(context,
                                              listEvents[index]["picURL1"]),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          home_pics_builder(context,
                                              listEvents[index]["picURL2"]),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ]),

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ));
          }),
    );
  }

//const Account({Key? key}) : super(key: key);
}
