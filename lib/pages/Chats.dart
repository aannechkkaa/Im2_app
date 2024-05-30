import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:js_util';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2/pages/Message.dart';
import 'package:im2/pages/home.dart';
import 'package:im2/pages/Events.dart' as Ev;
import 'package:im2/pages/Users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:im2/pages/Comment.dart';


import 'dart:html' as html;

class Chat_p extends StatefulWidget {
  final dynamic event;

  const Chat_p({Key? key, this.event}) : super(key: key);
  static const routeName = "chat_page";

  @override
  State<Chat_p> createState() => _Chat_page();
}
String message_txt = "";

TextEditingController _controller = TextEditingController();


class _Chat_page extends State<Chat_p> {

  @override
  bool? isCheked = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color.fromARGB(255, 50, 50, 50),
            iconSize: 30,
            onPressed: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRight, child: Home())
              )
            },
          ),
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          title: Text(
            'Чат события',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Oswald',
              color: Color.fromARGB(255, 50, 50, 50),
            ),
          ),
          //centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(255, 255, 247, 225),
      body:




        ListView.builder(
            itemCount: widget.event["messages"].length,
            itemBuilder: (BuildContext context, int index) {
              // return Flexible(
              //   child:
              //   Container(
              //color: Colors.lightGreenAccent,
              //child:
              if (widget.event["messages"].length < 1) {
                widget.event["messages"] = [];
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
                                      widget.event["messages"][index]
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
                                      widget.event["messages"][index]
                                      ["autor"]["username"],
                                      softWrap: true,
                                      maxLines: 6,
                                      style: TextStyle(
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
                                      "${DateTime.parse(widget.event["messages"][index]["messageDate"]).day}/${DateTime.parse(widget.event["comments"][index]["commentDate"]).month}",
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
                                          widget.event["messages"]
                                          [index]["messageTime"],
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
                                          widget.event["messages"][index]
                                          ["messageText"],
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
            }
        ),
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
                                onChanged: (String message) {
                                  message_txt = message;
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
                                  if ((message_txt == "") ||
                                      (message_txt.trim().isEmpty)) {
                                    _controller.clear();
                                  } else {
                                    setState(() async {
                                      _controller.clear();
                                      widget.event["messages"].add({
                                        "messageText": message_txt.trim(),
                                        "messageId":
                                        widget.event["messages"].length,
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
                                        "messageDate":
                                        DateTime.now().toIso8601String(),
                                        "messageTime":
                                        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
                                      });
                                      print(widget.event["messages"]);
                                      setState(() {});
                                      await Ev.Event().addMessages(
                                          widget.event["id"],
                                          widget.event["messages"]);
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
                                      message_txt = "";
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
        )



    );
  }
}

