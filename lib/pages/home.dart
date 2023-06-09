
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im2/pages/account.dart';
import 'package:im2/pages/Users.dart';
import 'package:im2/pages/MyWidgets/home_pics.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Event.dart';
import 'package:im2/pages/add_event.dart';
import 'package:im2/pages/mycalendar.dart';
import 'package:im2/pages/Events.dart';


List<Event> sort_events(List<Event> events){
  events.sort((a, b) => a.Date.compareTo(b.Date));
  //events.sort((a, b) => a.Time.compareTo(b.Time));
  return events;
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = "home_page";
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{

  List<Event> current_events = sort_events(events_add_page);

  List<Event> filteredEvents = [];
  //Event e1 = new Event();
  int Count = 0;
  int Current_index = 0;
  bool not_first = false;
  bool _my_events = false;
  bool show_url_bttn = false;
  String list_of = "Cобытия в городе";

  @override
  // void initState(){
  //   super.initState();
  //   Event2 e1 = Event2();
  //   // Events_list.addAll(['????? ? ?????', '???????? ?? ??????????', '??????? ? ????']);
  // }

  List<Event> filterEventsByParticipant(List<Event> events, User participant) {
    return events.where((event) => event.participants.contains(participant)).toList();
  }


  Widget build(BuildContext context){
    return Scaffold(
      //backgroundColor: Colors.green,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        title: Text('События', style:
        TextStyle(
          fontSize: 30,
          fontFamily: 'Oswald',
          color: Color.fromARGB(255, 50, 50, 50),
        ),
        ),
        centerTitle: false,
        leading: Padding( padding: EdgeInsets.only(left: 12.0, top: 7.0, bottom: 7.0 ),
          child:
          ClipOval(
            child: Image.network(
              current_user.avatarUrl!,
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            ),
          )

    ),

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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),

                  Text("Категории",
                    style:
                    TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 50, 50, 50),
                      fontFamily: 'Oswald',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,

                child:
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {

                        current_events = sort_events(events_add_page.where((event) => event.category == "Активный отдых").toList());
                        });
                      },
                      child: Image.asset(
                        "assets/active.png",
                        height: 82,
                        width: 172,
                      ),
                    ),


                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {

                        current_events = sort_events(events_add_page.where((event) => event.category == "Кафе и рестораны").toList());
                          });
                        // Handle button press
                      },
                      child: Image.asset(
                        "assets/food.png",
                        height: 82,
                        width: 172,
                      ),
                    ),


                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {

                          current_events = sort_events(events_add_page.where((event) => event.category == "Искусство и культура").toList());
                        });
                      },
                      child: Image.asset(
                        "assets/art.png",
                        height: 82,
                        width: 172,
                      ),
                    ),

                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {

                          current_events = sort_events(events_add_page.where((event) => event.category == "Отдых на природе").toList());
                        });
                      },
                      child: Image.asset(
                        "assets/nature.png",
                        height: 82,
                        width: 172,
                      ),
                    ),

                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {

                          current_events = sort_events(events_add_page.where((event) => event.category == "Ночная жизнь").toList());
                        });
                      },
                      child: Image.asset(
                        "assets/night.png",
                        height: 82,
                        width: 172,
                      ),
                    ),

                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {

                          current_events = sort_events(events_add_page.where((event) => event.category == "Путешествия").toList());
                        });
                      },
                      child: Image.asset(
                        "assets/trevel.png",
                        height: 82,
                        width: 172,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),



                    //Image(image: AssetImage("assets/active.jpg")),
                    // Добавьте дополнительные кнопки или виджеты по вашему усмотрению
                  ],
                ),

              ),
              SizedBox(height: 6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  TextButton(onPressed: (){
                    setState(() {
                      current_events = sort_events(events_add_page);
                      show_url_bttn = false;
                      list_of = "События в городе";
                    });
                  },
                      child: Text(
                        "Показать всe",
                        style:
                        TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          //fontFamily: 'Oswald',
                        ),
                      )),

                ],
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  TextButton(onPressed: (){
                    setState(() {
                      current_events = current_events.where((event) => event.participants.contains(current_user)).toList();
                      show_url_bttn = true;
                      list_of = "Мой календарь";
                    });
                  },
                      child: Text(
                        "Показать только мои события",
                        style:
                        TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          //fontFamily: 'Oswald',
                        ),
                      )),

                ],
              ),


              SizedBox(
                height: 20,

              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),

                  Text(list_of,
                    style:
                    TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 50, 50, 50),
                      fontFamily: 'Oswald',
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: current_events.length * 250,
                child:
                ListView.builder(
                    itemCount: current_events.length,
                    itemBuilder: (BuildContext context, int index){
                      return
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Column(

                          children: [

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
                                  // String event_short_description = events_add_page[index].shortDescription;
                                  // Event this_event = events_add_page.firstWhere((event) => event.shortDescription == event_short_description);
                                  // print(this_event.name);
                                  Event_index = current_events[index].index;
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => new Event_page())
                                  );
                                  u_r_member = isUserExist(events_add_page[Event_index].participants, current_user.id);
                                },
                                key: Key(current_events[index].index.toString()),
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
                                        Visibility(
                                          visible: false,
                                          child:  Row(
                                            children: [
                                              TextButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      events_add_page.removeAt(index + 1);
                                                      current_events.removeAt(index + 1);
                                                    });
                                                  },
                                                  child: Text("Удалить")
                                              )
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width: 70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width : 20),
                                              Text(current_events[index].Date.day.toString() + "/" + current_events[index].Date.month.toString() + "/" + (current_events[index].Date.year.toInt() % 100).toString(),

                                                style:
                                                TextStyle(
                                                  fontSize: 21,
                                                  fontFamily: 'Oswald',
                                                  color: Colors.white,
                                                ),),

                                              Text(current_events[index].Time.toString()[10] + current_events[index].Time.toString()[11] + current_events[index].Time.toString()[12] + current_events[index].Time.toString()[13] + current_events[index].Time.toString()[14] ,
                                                style:
                                                TextStyle(
                                                  fontSize: 21,
                                                  fontFamily: 'Oswald',
                                                  color: Color.fromARGB(255, 248, 231, 174),
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
                                                                  Text(current_events[index].place,
                                                                    softWrap: true,
                                                                    maxLines: 2,

                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily: 'Oswald',
                                                                      color: Color.fromARGB(255, 248, 231, 174),
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
                                                    current_events[index].event_autor.avatarUrl!,
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(width : MediaQuery.of(context).size.width * 0.04,),
                                                Text(current_events[index].event_autor.username + "," + " " + current_events[index].event_autor.age.toString(),
                                                  style:
                                                  TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Oswald',
                                                    color: Color.fromARGB(255, 248, 231, 174),
                                                  ),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  child: Text(current_events[index].name,
                                                    softWrap: true,
                                                    style:
                                                    TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Oswald',
                                                      color: Color.fromARGB(255, 248, 231, 174),
                                                    ),),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  child:
                                                  Text(current_events[index].shortDescription,
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
                                                home_pics_builder(context, current_events[index].picURL1),
                                                SizedBox(width: 2,),
                                                home_pics_builder(context, current_events[index].picURL2),
                                              ],
                                            )
                                          ],
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Visibility(
                              visible: show_url_bttn,
                              child:
                            Row(
                              children: [
                                SizedBox(width: 10,),
                                TextButton(onPressed: (){
                                  openUrlInBrowser(Uri.parse(current_events[index].chatLink));
                                },
                                  child: Text("Перейти в чат участников",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          fontFamily: 'Oswald'
                                      )
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                        255, 251, 194, 235)),
                                    //minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-5,10))
                                  ),
                                ),
                              ],
                            ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        )


                      );

                    }
                ),
              ),

              
               ],
             ),
            ]
            ),

      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, PageTransition(
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
      bottomNavigationBar:BottomAppBar(
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
                          IconButton(onPressed: ((){
                            //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Home()));
                          }),
                              icon: Icon(Icons.map_outlined,  color: Color.fromARGB(255, 74, 68, 134),)
                          ),
                          Text(
                            'Обзор',
                            style:
                            TextStyle(
                              fontSize: 16,
                              fontFamily: 'Oswald',
                                color: Color.fromARGB(255, 74, 68, 134),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [

                          IconButton(onPressed: ((){
                            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Reg_p()));
                          }),
                            icon: Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.0)),
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
                          Text(
                            "Профиль",
                            style:
                            TextStyle(
                              fontSize: 16,
                              fontFamily: 'Oswald',
                              color: Color.fromARGB(255, 50, 50, 50),
                            ),
                          )
                        ],
                      )
                    ],),
                )
            ),
          )
      ),


    );
  }

  void openUrlInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}