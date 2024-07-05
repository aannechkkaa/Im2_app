import 'dart:html';
import 'package:flutter/material.dart';
import 'package:im2/pages/Events.dart' as Ev;
import 'package:im2/pages/Chats.dart';
import 'package:im2/pages/user_page.dart';
import 'package:im2/pages/MyWidgets/Event_pics_builder.dart';
import 'package:im2/pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'Users.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Event_members {
  String name = "Антон";
  int age = 45;
}

bool show_url_bttn = false;


String isUserExist(dynamic userList, dynamic userId) {
  if (userList.any((user) => user["id"] == userId)) {
    return "Вы участник!";
  } else {
    return "Присоединиться!";
  }
}

bool bttn(dynamic userList, dynamic userId) {
  if (userList.any((user) => user["id"] == userId)) {
    return true;
  } else {
    return false;
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    u_r_member = isUserExist(widget.event["participants"], current_user.id);
    show_url_bttn = bttn(widget.event["participants"], current_user.id);
  }

  void initState2() {
    super.initState();
    // Прокрутка к последнему элементу после построения виджета
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }
  @override
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
                SizedBox(height: 25,),
               Row(
                          // mainAxisSize: MainAxisSize.max,
                          //
                          // textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // const SizedBox(
                            //   width: 25,
                            // ),
                            Expanded(child:
                            Column(
                              children: [
                                //SizedBox(width: 20,),
                                if (widget.event["event_autor"]["avatarUrl"] !=
                                    null)

                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // смещение тени
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => User_p(
                                                user: widget.event["event_autor"],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          widget.event["event_autor"]["avatarUrl"],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
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


                            ),

                            Spacer(),

                            IntrinsicWidth(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child:
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38.withOpacity(0.2), // Цвет тени
                                              spreadRadius: 2, // Распространение тени
                                              blurRadius: 5, // Радиус размытия тени
                                              offset: Offset(0, 2), // Смещение тени относительно контейнера
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 24.0,
                                                      height: 24.0,
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                          'assets/place_24dp.png',
                                                          width: 24,
                                                          height: 24,
                                                          //fit: BoxFit.cover,
                                                        ),
                                                      ),
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
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 25),
                                                  //alignment: Alignment.bottomRight,
                                                  //color: Colors.blue,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        widget.event["time"].replaceAll(':', '').padLeft(4, '0').replaceRange(2, 2, ":"),
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'Oswald',
                                                          color: Color.fromARGB(255, 50, 50, 50),
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


                              )

                            ),

                            //SizedBox(width: 25,),
                    ],
                  ),
                SizedBox(height: 25,),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      //SizedBox(width: 15,),
                                      IntrinsicWidth(
                                        child:
                                        Container(
                                          width: widget.event["participants"].length >= 3
                                              ? 3 * 30.0 // Ширина для 3 или более участников
                                              : widget.event["participants"].length * 50.0, // Ширина для 1 или 2 участников
                                            //mainAxisSize: MainAxisSize.min,
                                            height: 60,
                                            child:
                                            IconButton(
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
                                                              height: widget.event["participants"].length *
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
                                                                          .fromLTRB(0, 0, 0, 15.0),
                                                                      child: Row(
                                                                        children: [
                                                                          ClipOval(


                                                                            child: GestureDetector(
                                                                              onTap: () {

                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => User_p(
                                                                                        user: widget.event["participants"][index],
                                                                                      ),
                                                                                    ));
                                                                              },
                                                                              child: Image.network(
                                                                                widget.event["participants"][index]["avatarUrl"],
                                                                                width: 25,
                                                                                height: 25,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),

                                                                          ),
                                                                          const SizedBox(
                                                                            width: 15,
                                                                          ),
                                                                          Text(
                                                                            "${widget.event["participants"][index]["username"]}" + " " + "${widget.event["participants"][index]["age"]}",
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Oswald',
                                                                              color: Color.fromARGB(
                                                                                  255, 50, 50, 50),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                            ));
                                                      });
                                                },
                                                icon:
                                                Stack(
                                                  children: [
                                                    if (widget.event["participants"].length >= 1)
                                                      Positioned(
                                                        left: 0,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            widget.event["participants"][0]["avatarUrl"],
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    if (widget.event["participants"].length >= 2)
                                                      Positioned(
                                                        left: 18,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            widget.event["participants"][1]["avatarUrl"],
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    if (widget.event["participants"].length >= 3)
                                                      Positioned(
                                                        left: 36,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            widget.event["participants"][2]["avatarUrl"],
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                )
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
                                          )
                                      ),
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${widget.event["participants"] != null ? widget.event["participants"].length : 0} уже идут",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Oswald',
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      SizedBox(height: 8),

                                    ],
                                  ),

                                ],
                              ),

                        ],
                      ),


                      Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                              //SizedBox(width: 90,),
                              TextButton(
                                  onPressed: () {
                                    if (!(widget.event["participants"].any((user) => user["id"] == current_user.id))) {
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
                                                        onPressed: () =>{
                                                            setState(() {
                                                            show_url_bttn = true;
                                                            }),
                                                            addUser(context)
                                                          },

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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 74, 68, 134),
                                    elevation: 8,
                                    //foregroundColor: Colors.pink,
                                  ),
                                  child: Text(
                                    u_r_member, //TODO
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Oswald',
                                      color: Colors.white,
                                    ),
                                  ))
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: show_url_bttn,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat_p(
                                        event: costyl[cotyl_index],
                                      )));
                            },
                            style: ButtonStyle(

                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 255, 255, 255)),

                              elevation: MaterialStateProperty.all(8.0),
                              //minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-5,10))
                            ),
                            child: const Text("Перейти в чат участников",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 50, 50, 50),
                                    fontFamily: 'Oswald')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(height: 20,)
                  ],
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
                  width: 350,
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
                                            child:
                                            ClipOval(
                                              child: GestureDetector(
                                                onTap: () {

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => User_p(
                                                          user: widget.event["comments"][index]["autor"],
                                                        ),
                                                      ));
                                                },
                                                child: Image.network(
                                                  widget.event["comments"][index]["autor"]["avatarUrl"] ,
                                                  width: 34,
                                                  height: 34,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            )
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
                            const SizedBox(
                              height: 10,
                            ),
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

                                      if (_scrollController.hasClients) {
                                        _scrollController.animateTo(
                                          _scrollController.position.maxScrollExtent,
                                          duration: const Duration(milliseconds: 100),
                                          curve: Curves.easeOut,
                                        );
                                      }

                                      comment_txt = "";

                                    });
                                  }
                                },
                              icon: Container(
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/arrow_circle_right_50dp_4A4486.png',
                                    width: 50,
                                    height: 50,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ),),
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
