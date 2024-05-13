import 'dart:html';

import 'package:flutter/material.dart';
import 'package:im2/pages/Comment.dart';
import 'package:im2/pages/add_event.dart';
import 'package:im2/pages/mycalendar.dart';
import 'package:im2/pages/MyWidgets/Zoomable_widget.dart';

import 'package:im2/pages/MyWidgets/Event_pics_builder.dart';
import 'package:im2/pages/home.dart';
import 'package:page_transition/page_transition.dart';

import 'Users.dart';

// class Comment{
//   String autor_name = "";
//   String autor_age = "";
//   String comment = "";
//   //String autor_photo = "";
// }
class Event_members{
  String name = "Антон";
  int age = 45;
}

String isUserExist(List<User> userList, int userId) {
  if(userList.any((user) => user.id == userId)){
    return "Вы участник!";
  }
  else{
    return "Присоединиться!";
  }
}


String u_r_member = isUserExist(events_add_page[Event_index].participants, current_user.id);
String comment_txt = "";
List<Comment> Comment_list = [];
List<Event_members> Members_list = [];
TextEditingController _controller = TextEditingController();

final String imagePath = 'assets/wom.jpeg';
bool _isZoomed = false;

class Event_page extends StatefulWidget {
  const Event_page({Key? key}) : super(key: key);



  @override
  State<Event_page> createState() => _Event_pageState();
}

class _Event_pageState extends State<Event_page> {


  // void Current_event(String name,String short_description,String autor_name, String long_description,String place,String date,String time,){
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color.fromARGB(255, 50, 50, 50),
            iconSize: 30,
            onPressed: () => {
              Navigator.push(context, PageTransition(
              type: PageTransitionType.fade,
              child: Home()))

            },
          ),
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          title: Text('Страница события', style:
          TextStyle(
            fontSize: 30,
            fontFamily: 'Oswald',
            color: Color.fromARGB(255, 50, 50, 50),
          ),
          ),
          centerTitle: false,
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

            Column(
                children: [
                  Container(
                    //decoration: new BoxDecoration(
                    //   borderRadius: new BorderRadius.circular(16.0),
                    //  color: Colors.red,
                    //),
                    //SizedBox(height: 25),
                    child:
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width: 5),
                        Padding(padding: EdgeInsets.all(25.0),
                          child:
                          Row(

                            mainAxisSize: MainAxisSize.max,

                            textDirection: TextDirection.ltr,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //SizedBox(width: 25,),
                              Column(
                                children: [
                                  //SizedBox(width: 20,),

                                  ClipOval(
                                    child: Image.network(
                                      events_add_page[Event_index].event_autor.avatarUrl!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text( events_add_page[Event_index].event_autor.username + ", " +  events_add_page[Event_index].event_autor.age.toString(),
                                    style:
                                    TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Oswald',
                                      color: Color.fromARGB(255, 50, 50, 50),
                                    ),),
                                ],
                              ),

                              SizedBox(width: MediaQuery.of(context).size.width * 0.17,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  //crossAxisAlignment: CrossAxisAlignment.end,

                                  children: [
                                    //SizedBox(width: 70),
                                    Container(
                                      //width: 270,
                                      // decoration: new BoxDecoration(
                                      //  borderRadius: new BorderRadius.circular(16.0),
                                      //  color: Colors.green,
                                      // ),
                                        padding: const EdgeInsets.only(bottom: 45),

                                        //margin: const EdgeInsets.only(top: -20),
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children:[


                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                      //Icons.border_color_outlined
                                                        Icons.place_outlined,
                                                        color: Color.fromARGB(255, 74, 68, 134),),
                                                    Text(events_add_page[Event_index].place,
                                                      softWrap: true,
                                                      maxLines: 2,

                                                      style:
                                                      const TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: 'Oswald',
                                                        color: Color.fromARGB(255, 74, 68, 134),
                                                      ),),

                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [

                                                Container(
                                                  padding: const EdgeInsets.only(left: 25),
                                                  //alignment: Alignment.bottomRight,
                                                  //color: Colors.blue,
                                                  child:
                                                  Column(
                                                    children: [
                                                      Text(events_add_page[Event_index].Time.toString()[10] + events_add_page[Event_index].Time.toString()[11] + events_add_page[Event_index].Time.toString()[12] + events_add_page[Event_index].Time.toString()[13] + events_add_page[Event_index].Time.toString()[14],
                                                        softWrap: true,
                                                        maxLines: 2,

                                                        style:
                                                        TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'Oswald',
                                                          color: Color.fromARGB(255, 50, 50, 50),
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  //color: Colors.red,
                                                    child:
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,

                                                      children: [
                                                        Text(events_add_page[Event_index].Date.day.toString() + "/" + events_add_page[Event_index].Date.month.toString() + "/" + (events_add_page[Event_index].Date.year.toInt() % 100).toString(),
                                                          softWrap: true,
                                                          maxLines: 2,

                                                          style:
                                                          TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: 'Oswald',
                                                            color: Color.fromARGB(255, 50, 50, 50),
                                                          ),),
                                                      ],

                                                    )
                                                )

                                              ],
                                            )


                                          ],
                                        )



                                    )



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
                      SizedBox(width: 25,),
                      Flexible(
                        child:Text(events_add_page[Event_index].shortDescription,
                          softWrap: true,
                          maxLines: 5,
                          style:
                          TextStyle(
                            fontSize: 20,
                            fontFamily: 'Oswald',
                            color: Color.fromARGB(255, 50, 50, 50),
                          ),),
                      ),
                      SizedBox(width: 25,),

                    ],
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 25,),
                        Flexible(
                          child:Text(events_add_page[Event_index].longDescription
                            ,
                            softWrap: true,
                            maxLines: 5,
                            style:
                            TextStyle(
                              fontSize: 17,
                              fontFamily: 'Oswald',
                              color: Colors.blueGrey,
                            ),),
                        ),
                        SizedBox(width: 25,),


                      ]
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SizedBox(width: 25,),



                      //ZoomableImage(imageUrl: 'assets/test_photo_1.jpg'),

                      event_pics_builder(
                        context,
                        events_add_page[Event_index].picURL1,
                      ),
                      SizedBox(width: 30,),
                      event_pics_builder(
                        context,
                        events_add_page[Event_index].picURL2,
                      ),


                      //event_pics_builder(events_add_page[Event_index].picURL1)



                      //ZoomableImage(imageUrl: 'assets/test_photo_2.jpg'),

                    ],
                  ),
                  SizedBox(height: 20,),














                  Container(
                    //  decoration: new BoxDecoration(
                    //   border: Border.all(
                    //    width: 1,
                    //    ),
                    //    color: Colors.green,
                    //  ),
                    child:  Row(
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
                                        Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                          child:
                                          IconButton(
                                            onPressed: (){
                                              showDialog(context: context, builder: (BuildContext context)
                                              {
                                                return AlertDialog(
                                                    title: Text('Уже идут',
                                                      style:
                                                      TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Oswald',
                                                        color: Color.fromARGB(255, 50, 50, 50),
                                                      ),
                                                    ),
                                                    content:  SizedBox(
                                                  width: 100,
                                                  height: events_add_page[Event_index].participants.length*40,
                                                  child: ListView.builder(

                                                      itemCount: events_add_page[Event_index].participants.length,
                                                      itemBuilder: (BuildContext context, int index){
                                                        return Container(
                                                            child:
                                                            Padding(
                                                              padding: EdgeInsets.fromLTRB(0, 0,0 , 15.0),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage: AssetImage(events_add_page[Event_index].participants[index].avatarUrl!),
                                                                    minRadius: 17.0,
                                                                    maxRadius: 17.0,
                                                                  ),
                                                                  SizedBox(width: 15,),
                                                                  Text(events_add_page[Event_index].participants[index].username + "  ")
                                                                ],
                                                              ),
                                                            )



                                                        );
                                                      }
                                                  ),
                                                ));
                                              });
                                            },
                                             icon: Icon(Icons.people_alt_outlined,
                                             color: Colors.blueGrey,),
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
                                          ),),


                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),

                            SizedBox(width: 5,),
                            Column(
                              children: [
                                Text(
                                  events_add_page[Event_index].participants.length.toString()  + " уже идут"
                                  ,
                                  style:
                                  TextStyle(
                                    fontSize: 17,
                                    //fontFamily: 'Oswald',
                                    color: Colors.blueGrey,
                                  ),)
                              ],
                            ),


                          ],
                        ),


                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              // decoration: new BoxDecoration(
                              // border: Border.all(
                              //   width: 1,
                              // ),
                              // color: Colors.green,
                              //),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                textDirection: TextDirection.rtl,
                                children: [
                                  //SizedBox(width: 90,),
                                  TextButton(onPressed: (){
                                    if(!(events_add_page[Event_index].participants.any((user) => user.id == current_user.id))) {
                                      showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                  'Вы уверены, что хотите присоединиться к мероприятию?',
                                                  style:
                                                  TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Oswald',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                content: Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            events_add_page[Event_index].participants.add(current_user);
                                                            my_events.add(events_add_page[Event_index]);
                                                            u_r_member =  "Вы участник!";
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Да")
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context),
                                                      child: Text("Нужно подумать!"),
                                                    ),
                                                  ],
                                                )
                                            );
                                          });
                                    }

                                    else{

                                      showDialog(context: context, builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Вы уже присоединились к событию!',
                                              style:
                                              TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Oswald',
                                                color: Colors.black,
                                              )),
                                        );}
                                      );
                                      //sleep(Duration(seconds:3));
                                      //Navigator.pop(context);



                                    }

                                    ;
                                  },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.only(left: 20, right: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        backgroundColor: Color.fromARGB(255, 74, 68, 134),
                                        //foregroundColor: Colors.pink,
                                      ),
                                      child: Text(u_r_member,
                                        style:
                                        TextStyle(
                                          fontSize: 17,
                                          //fontFamily: 'Oswald',
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            )


                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: const EdgeInsets.all(15.0),
                        // padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color.fromARGB(255, 50, 50, 50))
                            )
                        ),
                        child: SizedBox(
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
                    child:
                    ListView.builder(
                        itemCount: events_add_page[Event_index].comments.length,
                        itemBuilder: (BuildContext context, int index){
                          // return Flexible(
                          //   child:
                          //   Container(
                          //color: Colors.lightGreenAccent,
                          //child:
                          if (events_add_page[Event_index].comments.length < 1){
                            return Text(
                                "Оставьте свой комментарий!"
                            );
                          }
                          else {
                            return Container(
                              child:
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: ClipOval(
                                              child: Image.network(
                                                events_add_page[Event_index].comments[index].autor.avatarUrl!,
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
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: [
                                                Text(
                                                  events_add_page[Event_index].comments[index].autor.username,
                                                  softWrap: true,
                                                  maxLines: 6,
                                                  style:
                                                  TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Oswald',
                                                    color: Color.fromARGB(255, 50, 50, 50),
                                                  ),),
                                                SizedBox(width: 7,),
                                                Text(

                                                  //key: Key(Comment_list[index].comment),
                                                  events_add_page[Event_index].comments[index].commentDate.day.toString() + "/" + events_add_page[Event_index].comments[index].commentDate.month.toString() ,
                                                  softWrap: true,
                                                  maxLines: 6,
                                                  style:
                                                  TextStyle(
                                                      fontSize: 15,
                                                      //ontFamily: 'Oswald',
                                                      color: Colors.blueGrey
                                                  ),),
                                                Text(

                                                  //key: Key(Comment_list[index].comment),
                                                  //events_add_page[Event_index].comments[index].commentTime.toString(),
                                                  " " + events_add_page[Event_index].comments[index].commentTime.toString()[10] + events_add_page[Event_index].comments[index].commentTime.toString()[11] + events_add_page[Event_index].comments[index].commentTime.toString()[12] + events_add_page[Event_index].comments[index].commentTime.toString()[13] + events_add_page[Event_index].comments[index].commentTime.toString()[14],
                                                  softWrap: true,
                                                  maxLines: 6,
                                                  style:
                                                  TextStyle(
                                                    fontSize: 15,
                                                    // fontFamily: 'Oswald',
                                                    color: Colors.blueGrey,
                                                  ),),

                                              ]

                                          ),
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
                                      SizedBox(
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
                                            child:
                                            Row(
                                              children: [

                                                Flexible(child:

                                                Text(

                                                  //key: Key(Comment_list[index].comment),
                                                  events_add_page[Event_index].comments[index].commentText,
                                                  softWrap: true,
                                                  maxLines: 6,
                                                  style:
                                                  TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Oswald',
                                                    color: Color.fromARGB(
                                                        255, 59, 59, 59),
                                                  ),))

                                              ],
                                            ),
                                          )

                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
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
                  ),

                ]

            ),
          ],
        ),
        ]
        ),
        bottomNavigationBar:BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          child: IconTheme(
              data: IconThemeData(color: Colors.deepOrange),
              child: Padding(padding: EdgeInsets.all(5.0),
                  child:
                  SizedBox(
                    height: 72,

                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //SizedBox(
                        //   width: 25,
                        // ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: ClipOval(
                                child: Image.network(
                                  current_user.avatarUrl!,
                                  width: 34,
                                  height: 34,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child:
                              TextField(
                                // obscureText: true,
                                controller: _controller,
                                maxLength: 160,
                                maxLines: 1,
                                decoration:
                                //Padding(padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),),
                                InputDecoration(

                                  labelText: 'Введите сообщение',
                                  labelStyle: TextStyle(fontSize: 13, color: Colors.blueGrey, fontFamily: 'Oswald'),
                                  contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
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
                            IconButton(onPressed: (){
                              if((comment_txt == "")||(comment_txt.trim().isEmpty)){
                                _controller.clear();
                              }
                              else{
                                setState(() {
                                  _controller.clear();
                                  events_add_page[Event_index].comments.insert(0,Comment_class(
                                    commentText: comment_txt.trim(),
                                    commentId: events_add_page[Event_index].comments.length,
                                    autor: current_user,
                                    commentDate: DateTime.now(),
                                    commentTime: TimeOfDay.now(),
                                  ));
                                  comment_txt = "";
                                  //print(Comment_list.length);
                                });
                              }
                            },
                                icon: Icon(
                                  color: Color.fromARGB(255, 74, 68, 134),
                                  Icons.arrow_circle_right_rounded,
                                  size: 35,)
                            )
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


                  )
              )
          ),



        ));
  }
}