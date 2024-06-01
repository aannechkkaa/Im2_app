import 'dart:html';

import 'package:flutter/material.dart';
import 'package:im2/pages/Events.dart' as Ev;
import 'package:im2/pages/add_event.dart';
import 'package:im2/pages/mycalendar.dart';
import 'package:im2/pages/MyWidgets/Zoomable_widget.dart';

import 'package:im2/pages/MyWidgets/Event_pics_builder.dart';
import 'package:im2/pages/home.dart';
import 'package:page_transition/page_transition.dart';

import 'Users.dart';

class Event_members {
  String name = "Антон";
  int age = 45;
}

String isUserExist(dynamic userList, dynamic userId) {
  if (userList.any((user) => user["id"] == userId)) {
    return "Вы участник!";
  } else {
    return "Присоединиться!";
  }
}

String u_r_member = "Присоединиться";
String comment_txt = "";
//List<Comment> Comment_list = [];
List<Event_members> Members_list = [];
TextEditingController _controller = TextEditingController();

//final String imagePath = 'assets/wom.jpeg';
bool _isZoomed = false;

class Event_page extends StatefulWidget {
  final dynamic event;

  const Event_page({Key? key, this.event}) : super(key: key);

  @override
  State<Event_page> createState() => _Event_pageState();
}

class _Event_pageState extends State<Event_page> {
  // void Current_event(String name,String short_description,String autor_name, String long_description,String place,String date,String time,){

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    u_r_member = isUserExist(widget.event["participants"], current_user.id);
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
              Navigator.push(context,
                  PageTransition(type: PageTransitionType.fade, child: Home()))
            },
          ),
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          title: const Text(
            'Страница события',
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
              Column(children: [
                Container(
                  //decoration: new BoxDecoration(
                  //   borderRadius: new BorderRadius.circular(16.0),
                  //  color: Colors.red,
                  //),
                  //SizedBox(height: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                          textDirection: TextDirection.ltr,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: [
                                //SizedBox(width: 20,),
                                if (widget.event["event_autor"]["avatarUrl"] !=
                                    null)
                                  ClipOval(
                                    child: Image.network(
                                      widget.event["event_autor"]["avatarUrl"],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${widget.event["event_autor"]["username"] ?? ""}, ${widget.event["event_autor"]["age"] ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Oswald',
                                    color: Color.fromARGB(255, 50, 50, 50),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 45),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Icon(
                                                    //Icons.border_color_outlined
                                                    Icons.place_outlined,
                                                    color: Color.fromARGB(
                                                        255, 74, 68, 134),
                                                  ),
                                                  Text(
                                                    widget.event["place"],
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'Oswald',
                                                      color: Color.fromARGB(
                                                          255, 74, 68, 134),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 25),
                                                //alignment: Alignment.bottomRight,
                                                //color: Colors.blue,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      widget.event["time"],
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Oswald',
                                                        color: Color.fromARGB(
                                                            255, 50, 50, 50),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                  //color: Colors.red,
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${DateTime.parse(widget.event["date"]).day}/${DateTime.parse(widget.event["date"]).month}/${DateTime.parse(widget.event["date"]).year.toInt() % 100}",
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Oswald',
                                                      color: Color.fromARGB(
                                                          255, 50, 50, 50),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),

                            //SizedBox(width: 25,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Flexible(
                      child: Text(
                        widget.event["shortDescription"],
                        softWrap: true,
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Oswald',
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Flexible(
                    child: Text(
                      widget.event["longDescription"],
                      softWrap: true,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'Oswald',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ]),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox(width: 25,),

                    //ZoomableImage(imageUrl: 'assets/test_photo_1.jpg'),

                    event_pics_builder(
                      context,
                      widget.event["picURL1"],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    event_pics_builder(
                      context,
                      widget.event["picURL2"],
                    ),

                    //event_pics_builder(events_add_page[Event_index].picURL1)

                    //ZoomableImage(imageUrl: 'assets/test_photo_2.jpg'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  //  decoration: new BoxDecoration(
                  //   border: Border.all(
                  //    width: 1,
                  //    ),
                  //    color: Colors.green,
                  //  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      title: const Text(
                                                        'Уже идут',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: 'Oswald',
                                                          color: Color.fromARGB(
                                                              255, 50, 50, 50),
                                                        ),
                                                      ),
                                                      content: SizedBox(
                                                        width: 100,
                                                        height: widget
                                                                .event[
                                                                    "participants"]
                                                                .length *
                                                            40,
                                                        child: ListView.builder(
                                                            itemCount: widget
                                                                .event[
                                                                    "participants"]
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15.0),
                                                                child: Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      backgroundImage:
                                                                          AssetImage(widget.event["participants"][index]
                                                                              [
                                                                              "avatarUrl"]),
                                                                      minRadius:
                                                                          17.0,
                                                                      maxRadius:
                                                                          17.0,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(
                                                                        "${widget.event["participants"][index]["username"]}  ")
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                      ));
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.people_alt_outlined,
                                            color: Colors.blueGrey,
                                          ),
                                          //Container(
                                          //   width: 150.0,
                                          //   height: 150.0,
                                          //   decoration: BoxDecoration(
                                          //     color: const Color(0xff7c94b6),
                                          //     image: DecorationImage(
                                          //       image: AssetImage(current_user.avatarUrl!),
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                          //     border: Border.all(
                                          //       color: Colors.black38,
                                          //       width: 1,
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Text(
                                "${widget.event["participants"] != null ? widget.event["participants"].length : 0} уже идут",
                                style: const TextStyle(
                                  fontSize: 17,
                                  //fontFamily: 'Oswald',
                                  color: Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.rtl,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: [
                              //SizedBox(width: 90,),
                              TextButton(
                                  onPressed: () {
                                    if (!(widget.event["participants"].any(
                                        (user) =>
                                            user["id"] == current_user.id))) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                  'Вы уверены, что хотите присоединиться к мероприятию?',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Oswald',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                content: Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            addUser(context),
                                                        child:
                                                            const Text("Да")),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text(
                                                          "Нужно подумать!"),
                                                    ),
                                                  ],
                                                ));
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text(
                                                  'Вы уже присоединились к событию!',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Oswald',
                                                    color: Colors.black,
                                                  )),
                                            );
                                          });
                                      //sleep(Duration(seconds:3));
                                      //Navigator.pop(context);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 74, 68, 134),
                                    //foregroundColor: Colors.pink,
                                  ),
                                  child: Text(
                                    u_r_member, //TODO
                                    style: const TextStyle(
                                      fontSize: 17,
                                      //fontFamily: 'Oswald',
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
                                  color: Color.fromARGB(255, 50, 50, 50)))),
                      child: const SizedBox(
                        width: 300,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 320,
                  width: 280,
                  child: ListView.builder(
                      itemCount: widget.event["comments"].length,
                      itemBuilder: (BuildContext context, int index) {
                        // return Flexible(
                        //   child:
                        //   Container(
                        //color: Colors.lightGreenAccent,
                        //child:
                        if (widget.event["comments"].length < 1) {
                          widget.event["comments"] = [];
                          return const Text("Оставьте свой комментарий!");
                        } else {
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: ClipOval(
                                              child: Image.network(
                                                widget.event["comments"][index]
                                                            ["autor"]
                                                        ["avatarUrl"] ??
                                                    "",
                                                width: 34,
                                                height: 34,
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                widget.event["comments"][index]
                                                    ["autor"]["username"],
                                                softWrap: true,
                                                maxLines: 6,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'Oswald',
                                                  color: Color.fromARGB(
                                                      255, 50, 50, 50),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                //key: Key(Comment_list[index].comment),
                                                "${DateTime.parse(widget.event["comments"][index]["commentDate"]).day}/${DateTime.parse(widget.event["comments"][index]["commentDate"]).month}",
                                                softWrap: true,
                                                maxLines: 6,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    //ontFamily: 'Oswald',
                                                    color: Colors.blueGrey),
                                              ),
                                              Text(
                                                //key: Key(Comment_list[index].comment),
                                                //events_add_page[Event_index].comments[index].commentTime.toString(),
                                                " " +
                                                    widget.event["comments"]
                                                        [index]["commentTime"],
                                                softWrap: true,
                                                maxLines: 6,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  // fontFamily: 'Oswald',
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ]),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                     Column(
                                      children: [
                                        //padding: const EdgeInsets.only(bottom: ),
                                        SizedBox(
                                          width: 42,
                                          height: 42,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //
                                        //       key: Key(Comment_list[index].comment),
                                        //       "5 МИНУТ НАЗАД",
                                        //       softWrap: true,
                                        //       maxLines: 6,
                                        //       style:
                                        //       TextStyle(
                                        //         fontSize: 12,
                                        //         fontFamily: 'Oswald',
                                        //         color: Color.fromARGB(255, 247, 190, 59),
                                        //       ),)
                                        //   ],
                                        // ),

                                        Container(
                                          width: 220,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                //key: Key(Comment_list[index].comment),
                                                widget.event["comments"][index]
                                                    ["commentText"],
                                                softWrap: true,
                                                maxLines: 6,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Oswald',
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ))
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          );
                        }

                        //   )
                        // );
                      }),
                ),
              ]),
            ],
          ),
        ]),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          child: IconTheme(
              data: IconThemeData(color: Colors.deepOrange),
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //SizedBox(
                        //   width: 25,
                        // ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: ClipOval(
                                child: Image.network(
                                  current_user.avatarUrl ?? "",
                                  width: 34,
                                  height: 34,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextField(
                                // obscureText: true,
                                controller: _controller,
                                maxLength: 160,
                                maxLines: 1,
                                decoration:
                                    //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                                    const InputDecoration(
                                  labelText: 'Введите сообщение',
                                  labelStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blueGrey,
                                      fontFamily: 'Oswald'),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                ),
                                onChanged: (String comment) {
                                  comment_txt = comment;
                                },
                              ),
                            )
                          ],
                        ),

                        // SizedBox(width: 3,),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if ((comment_txt == "") ||
                                      (comment_txt.trim().isEmpty)) {
                                    _controller.clear();
                                  } else {
                                    setState(() async {
                                      _controller.clear();
                                      widget.event["comments"].add({
                                        "commentText": comment_txt.trim(),
                                        "commentId":
                                            widget.event["comments"].length,
                                        'autor': {
                                          "username": current_user.username,
                                          "avatarUrl": current_user.avatarUrl,
                                          "email": current_user.email,
                                          "id": current_user.id,
                                          "age": current_user.age,
                                          "is_admin": current_user.is_admin,
                                          "profile_description":
                                              current_user.profile_description,
                                        },
                                        "commentDate":
                                            DateTime.now().toIso8601String(),
                                        "commentTime":
                                            "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
                                      });
                                      print(widget.event["comments"]);
                                      setState(() {});
                                      await Ev.Event().addComments(
                                          widget.event["id"],
                                          widget.event["comments"]);
                                      // events_add_page[Event_index]
                                      //     .comments
                                      //     .insert(
                                      //         0,
                                      //         Comment_class(
                                      //           commentText: comment_txt.trim(),
                                      //           commentId:
                                      //               events_add_page[Event_index]
                                      //                   .comments
                                      //                   .length,
                                      //           autor: current_user,
                                      //           commentDate: DateTime.now(),
                                      //           commentTime: TimeOfDay.now(),
                                      //         ));
                                      comment_txt = "";
                                      //print(Comment_list.length);
                                    });
                                  }
                                },
                                icon: Icon(
                                  color: Color.fromARGB(255, 74, 68, 134),
                                  Icons.arrow_circle_right_rounded,
                                  size: 35,
                                ))
                            // SizedBox(
                            //    width: 25,
                            //    height: 25,
                            //   child: FloatingActionButton(
                            //     backgroundColor: Colors.orange,
                            //     elevation: 1,
                            //     onPressed: () => {},
                            //     child:
                            //     Icon( Icons.arrow_right_outlined, size: 30,),
                            //   ),
                            //
                            // )
                          ],
                        )
                      ],
                    ),
                  ))),
        ));
  }

  addUser(context) async {
    widget.event["participants"].add({
      "username": current_user.username,
      "avatarUrl": current_user.avatarUrl,
      "email": current_user.email,
      "id": current_user.id,
      "age": current_user.age,
      "is_admin": current_user.is_admin,
      "profile_description": current_user.profile_description,
    });
    setState(() {});
    await Ev.Event()
        .addParticipants(widget.event["id"], widget.event["participants"]);
    u_r_member = "Вы участник!";
    setState(() {});
    Navigator.pop(context);
  }
}
