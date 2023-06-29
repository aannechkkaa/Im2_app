
import 'dart:convert';
import 'dart:convert';
import 'dart:io';
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






  List<Event> my_events = events_add_page.where((event) => event.event_autor.id == Users.last.id).toList();

  String userName = Users.last.username;
  int userAge = Users.last.age;
  int user_raiting = 5;
  String user_description = "Я Андрей люблю друзей, театры, кино вытсавки, учусь в ДВФУ по направлению прикладная информатика";
  String? User_avatar_url = Users.last.avatarUrl;
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                  // Navigator.push(context, PageTransition(
                  //     type: PageTransitionType.fade,
                  //     child: Edit_p()));


              }, icon: Icon(Icons.settings), iconSize: 35,)
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
          backgroundColor: Color.fromARGB(255, 16, 79, 58),
          title: Text('Профиль', style:
          TextStyle(
            fontSize: 30,
            fontFamily: 'Oswald',
            color: Colors.white,
          ),
          ),
          centerTitle: false,
        ),

        body:
            ListView(
              children: [
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
                                    child: buildAvatar(User_avatar_url),
                                    //padding: EdgeInsets.all(8),
                                  )


                                ),
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
                        )


                    ),

                    Text(
                      Users.last.username + ", " + userAge.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Oswald',
                        color: Color.fromARGB(255, 16, 79, 58),
                      ),
                    ),
                    //Row(
                    //children: [
                    Center(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ваш рейтинг: " + user_raiting.toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                            ),
                            // SizedBox(
                            //   width: 2,
                            // ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child:
                                IconButton(onPressed: (){
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("На чем основан рейтинг?",
                                          style:
                                          TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Oswald',
                                            color: Colors.black,
                                          ),),

                                        content:
                                        SizedBox(
                                          height: 330,
                                          child:
                                          Column(
                                            children: [
                                              Text(
                                                "Рейтинг создан для повышения безопасности реальных встреч.",

                                              ),
                                              Text(
                                                  "Он помогает модераторам приложения отследить фэйковые страницы и блокировать пользователей, зарегестировавшихся под чужими фото и именами."
                                              ),
                                              Text(
                                                  "Рейтинг выставляют участники посещенных вами событий."
                                              ),
                                              Text(
                                                  "Также рейтинг может снижаться, если вы регулярно не приходили на мероприятия без предупрждения участников."
                                              )
                                            ],
                                          ),
                                        )
                                    );
                                  });
                                },
                                  icon: Icon(
                                      Icons.info_outline
                                  ),
                                  color: Colors.grey,
                                  iconSize: 15,
                                )
                            )

                          ],
                        )
                    ),
                    Center(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child:
                          Text(
                            Users.last.profile_description,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Oswald',
                              color: Color.fromARGB(255, 16, 79, 58),
                            ),
                          ),
                        )

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
                                  bottom: BorderSide(color: Colors.black, width: 1.4)
                              )
                          ),
                          child: SizedBox(
                            width: 300,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                          Text(
                            "Созданные вами события",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Oswald',
                              color: Color.fromARGB(255, 247, 183, 59),
                            ),
                          ),
                      ],

                    ),
                      SizedBox(
                      height: my_events.length * 250,
    child:
    ListView.builder(
    itemCount: my_events.length,
    itemBuilder: (BuildContext context, int index){
    return
    Container(
    width: MediaQuery.of(context).size.width * 0.95,
    child:
    IntrinsicHeight(
    child: ElevatedButton(
    style:
    ElevatedButton.styleFrom(
    elevation: 0,
    //fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 170),
    padding: EdgeInsets.all(0),

    backgroundColor: Colors.transparent,
    //borderRadius: BorderRadius.all(Radius.circular(20)),
    side: BorderSide(color: Colors.transparent,
    width: 1),
    ),
    onPressed: (){
    //Navigator.pushNamed(context, '/event');
    //Event_page() event_page = new Event_page();
    Event_index = index;
    Navigator.push(context, new MaterialPageRoute(
    builder: (context) => new Event_page())
    );
    },
    key: Key(my_events[index].index.toString()),
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
    color: Color.fromARGB(255, 16, 79, 58),

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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(width : 20),
    Text(my_events[index].Date.day.toString() + "/" + my_events[index].Date.month.toString() + "/" + (my_events[index].Date.year.toInt() % 100).toString(),

    style:
    TextStyle(
    fontSize: 21,
    fontFamily: 'Oswald',
    color: Colors.white,
    ),),

    Text(my_events[index].Time.toString()[10] + my_events[index].Time.toString()[11] + my_events[index].Time.toString()[12] + my_events[index].Time.toString()[13] + my_events[index].Time.toString()[14] ,
    style:
    TextStyle(
    fontSize: 21,
    fontFamily: 'Oswald',
    color: Color.fromARGB(255, 247, 183, 59),
    ),),

    SizedBox(height : 10),
    Row(

    children: [


    SizedBox(
    width: 70,
    child: Column(
    children: [
    Row(
    children: [
    Column(
    children: [
    Icon(Icons.place_outlined),
    ],
    ),
    Column(
    children: [
    Container(
    width: 40,
    child:
    Flexible(child:
    Text(my_events[index].place,
    softWrap: true,
    maxLines: 2,

    style:
    TextStyle(
    fontSize: 15,
    fontFamily: 'Oswald',
    color: Color.fromARGB(255, 154, 220, 184),
    ),),),
    )


    ],
    )
    ],
    )

    //Icon(Icons.place_outlined),

    // Flexible
    //   (child: new Text(Events_list[index].place,
    //   style: TextStyle(
    //     fontSize: 15,
    //     fontFamily: 'Oswald',
    //     color: Color.fromARGB(255, 154, 220, 184),),
    //   overflow: TextOverflow.clip,),),





    ],
    ),
    )



    ],
    )
    ],
    ),
    ),


    SizedBox(width : MediaQuery.of(context).size.width * 0.03,),
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Row(
    children: [
    SizedBox(
    height: 5,
    )
    ],
    ),
    Row(
    children: [
    Image(image: AssetImage('assets/Vector_1.png')),
    // Divider(
    //   height: double.infinity,
    //   thickness: 2,
    //   color: Colors.grey,
    //   indent: 10,
    //   endIndent: 10,
    // )
    ],
    ),
    Row(
    children: [
    SizedBox(
    height: 5,
    )
    ],
    ),

    ],
    ),
    SizedBox(width : MediaQuery.of(context).size.width * 0.03,),

    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    ClipOval(
    child: Image.network(
    my_events[index].event_autor.avatarUrl!,
    width: 30,
    height: 30,
    fit: BoxFit.cover,
    ),
    ),
    SizedBox(width : MediaQuery.of(context).size.width * 0.04,),
    Text(my_events[index].event_autor.username + "," + " " + my_events[index].event_autor.age.toString(),
    style:
    TextStyle(
    fontSize: 18,
    fontFamily: 'Oswald',
    color: Color.fromARGB(255, 247, 183, 59),
    ),),
    ],
    ),
    Row(
    children: [
    Container(
    width: MediaQuery.of(context).size.width * 0.5,
    child: Text(my_events[index].name,
    softWrap: true,
    style:
    TextStyle(
    fontSize: 18,
    fontFamily: 'Oswald',
    color: Color.fromARGB(255, 247, 183, 59),
    ),),
    ),
    ],
    ),
    Row(
    children: [
    Container(
    width: MediaQuery.of(context).size.width * 0.5,
    child:
    Text(my_events[index].shortDescription,
    softWrap: true,
    style:
    TextStyle(
    fontSize: 15,
    fontFamily: 'Oswald',
    color: Colors.white,
    ),),
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
    Row(
    children: [
    home_pics_builder(context, my_events[index].picURL1),
    SizedBox(width: 2,),
    home_pics_builder(context, my_events[index].picURL2),
    ],
    )
    ],
    )
    ]
    ),
    ),
    ),
    ),

    );

    }
    ),
    ),

                    // ],
                    //),

                    // RatingBar(
                    //     initialRating: 0,
                    //     direction: Axis.horizontal,
                    //     allowHalfRating: true,
                    //     itemCount: 5,
                    //     ratingWidget: RatingWidget(
                    //         full: const Icon(Icons.star, color: Colors.orange),
                    //         half: const Icon(
                    //           Icons.star_half,
                    //           color: Colors.orange,
                    //         ),
                    //         empty: const Icon(
                    //           Icons.star_outline,
                    //           color: Colors.orange,
                    //         )),
                    //     onRatingUpdate: (value) {
                    //       setState(() {
                    //         //_ratingValue = value;
                    //       });
                    //     }),

                  ],



                ),
              ],
            ),






        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 16, 79, 58),
          onPressed: () {
            Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
               // duration: Duration.millisecondsPerSecond(),
                alignment: Alignment.center,
                child: add_event()));
          },
          child: SvgPicture.asset(
            'assets/add_icon_white.svg',
            // Укажите размер изображения
            width: 30,
            height: 30,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.white,
            child: IconTheme(
              data: IconThemeData(color: Colors.deepOrange),
              child: Padding(padding: EdgeInsets.all(5.0),
                  child:
                  SizedBox(
                    height: 65,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            IconButton(onPressed: (() {
                              Navigator.push(context, PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Home()));
                            }),
                                icon: Icon(Icons.map_outlined,
                                  color: Color.fromARGB(255, 16, 79, 58),
                                  size: 25,)
                            ),
                            Text(
                              '?????',
                              style:
                              TextStyle(
                                fontSize: 16,
                                fontFamily: 'Oswald',
                                color: Color.fromARGB(255, 16, 79, 58),
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
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50.0)),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 247, 183, 59),
                                    width: 1.7,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    Users.last.avatarUrl!,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),


                            Text(
                              '????',
                              style:
                              TextStyle(
                                fontSize: 16,
                                fontFamily: 'Oswald',
                                color: Color.fromARGB(255, 247, 183, 59),
                              ),
                            )
                          ],
                        )
                      ],),
                  )
              ),
            )
        ),
      ),
    );
  }
//const Account({Key? key}) : super(key: key);
}