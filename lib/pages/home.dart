import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im2/pages/account.dart';
import 'package:im2/pages/Users.dart';
import 'package:im2/pages/Chats.dart';
import 'package:im2/pages/MyWidgets/home_pics.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Event.dart';
import 'package:im2/pages/add_event.dart';
import 'package:im2/pages/mycalendar.dart';
import 'package:im2/pages/Events.dart';

bool show_url_bttn2 = false;
String list_of = "Cобытия в городе";
bool myMode = false;

List<dynamic> costyl = [];
int cotyl_index = 1;
List<Event> sort_events(List<Event> events) {
  events.sort((a, b) => a.Date.compareTo(b.Date));
  //events.sort((a, b) => a.Time.compareTo(b.Time));
  return events;
}
bool userHasEvents = true;
bool thereAreEvents = true;


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = "home_page";

  @override
  HomeState createState() => HomeState();
}


class HomeState extends State<Home> {
  List<Event> current_events = sort_events(events_add_page);

  List<Event> filteredEvents = [];
  List<dynamic> listEvents = [];
  List<dynamic> searchEvents = [];
  List<dynamic> myEvents = [];

  //Event e1 = new Event();
  int Count = 0;
  int Current_index = 0;
  bool not_first = false;
  bool _my_events = false;

  @override
  void initState() {
    super.initState();
    Event().getEvent().then((value) {
      listEvents = value;
      setState(() {});
    });
  }

  List<Event> filterEventsByParticipant(List<Event> events, User participant) {
    return events
        .where((event) => event.participants.contains(participant))
        .toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green,
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 255, 247, 225),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Vector6.png',
              // Укажите размер изображения
              width: MediaQuery.of(context).size.width * 1,
              //height: MediaQuery.of(context).size.height * 1,
              fit: BoxFit.fill,
            ),
          ],
        ),
        ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
             Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Категории",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontFamily: 'Oswald',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {

                          searchEvents = listEvents
                              .where((e) => e["category"] == "Активный отдых")
                              .toList();
                          if(searchEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents= true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }

                      });
                    },
                    child: Image.asset(
                      "assets/active.png",
                      height: 82,
                      width: 172,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {

                          searchEvents = listEvents
                              .where((e) => e["category"] == "Кафе и рестораны")
                              .toList();
                          if(searchEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents = true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }

                      });
                      // Handle button press
                    },
                    child: Image.asset(
                      "assets/food.png",
                      height: 82,
                      width: 172,
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {

                          searchEvents = listEvents
                              .where((e) => e["category"] == "Искусство и культура")
                              .toList();
                          if(searchEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents = true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }

                      });
                    },
                    child: Image.asset(
                      "assets/art.png",
                      height: 82,
                      width: 172,
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if(!myMode) {
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Отдых на природе")
                              .toList();
                          if (searchEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents = true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }
                        }
                        else{
                          searchEvents = myEvents
                              .where((e) => e["category"] == "Отдых на природе")
                              .toList();
                          if (searchEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents = true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }
                        }


                      });
                    },
                    child: Image.asset(
                      "assets/nature.png",
                      height: 82,
                      width: 172,
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                          searchEvents = listEvents.where((e) => e["category"] == "Ночная жизнь").toList();

                        if(searchEvents.isNotEmpty) {
                          setState(() {
                            thereAreEvents = true;
                          });
                        }
                        else {
                          setState(() {
                            thereAreEvents = false;
                          });
                        }

                      });
                    },
                    child: Image.asset(
                      "assets/night.png",
                      height: 82,
                      width: 172,
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if(!myMode) {
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Путешествия")
                              .toList();
                          if (searchEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents = true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }
                        }
                        else{
                          searchEvents = myEvents
                              .where((e) => e["category"] == "Путешествия")
                              .toList();
                          if (myEvents.isNotEmpty) {
                            setState(() {
                              thereAreEvents = true;
                            });
                          }
                          else {
                            setState(() {
                              thereAreEvents = false;
                            });
                          }
                        }


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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 255, 255),
                        ),
                        elevation: MaterialStateProperty.all(8.0),
                      ),
                      onPressed: () {
                        setState(() {
                          list_of = "События в городе";
                          show_url_bttn = false;
                        });

                        Event().getEvent().then((value) {
                          setState(() {
                            listEvents = value;
                            current_events = sort_events(events_add_page);
                            userHasEvents = true;
                            thereAreEvents = true;
                            myMode = false;
                          });
                          // Очищаем searchEvents только после загрузки новых событий
                          searchEvents.clear();
                        });
                      },
                      child: const Text(
                        "Показать все",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 50, 50, 50),
                          fontFamily: 'Oswald',
                        ),
                      ),
                    ),

                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          list_of = "Мой календарь"; // Устанавливаем значение переменной list_of
                        });

                        setState(() {
                          show_url_bttn = true; // Показываем кнопку show_url_bttn
                        });

                        setState(() {
                          // Фильтруем события, в которых участвует текущий пользователь
                          searchEvents = listEvents.where((event) {
                            dynamic participants = event["participants"];
                            if (participants is List<dynamic>) {
                              return participants.any((participant) => participant["id"] == current_user.id);
                            }
                            myEvents = searchEvents;
                            myMode = true;
                            return false;
                          }).toList();
                          if(searchEvents.isNotEmpty){
                            setState(() {
                              userHasEvents = true;
                            });
                            //return true;
                          }
                          else{
                            setState(() {
                              userHasEvents = false;
                            });
                         //return false;
                          }
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 255, 255),
                        ),
                        elevation: MaterialStateProperty.all(8.0),
                      ),
                      child: Text(
                        "Мой календарь",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 50, 50, 50),
                          fontFamily: 'Oswald',
                        ),
                      ),
                    )

                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  list_of,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontFamily: 'Oswald',
                  ),
                ),
              ],
            ),
            listEvent()
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
        child: Image.asset(
          'assets/add2.png',
          // Укажите размер изображения
          width: 35,
          height: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          child: IconTheme(
            data: const IconThemeData(color: Colors.deepOrange),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: (() {
                                //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Home()));
                              }),
                              icon: Container(
                                width: 150.0,
                                height: 150.0,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/map_20dp.png',
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
                              color: Color.fromARGB(255, 74, 68, 134),
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
                                  current_user.avatarUrl ?? "",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Профиль",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Oswald',
                              color: Color.fromARGB(255, 50, 50, 50),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          )),
    );
  }

  appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      title: const Text(
        'События',
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'Oswald',
          color: Color.fromARGB(255, 50, 50, 50),
        ),
      ),
      centerTitle: false,
      leading: Padding(
          padding: EdgeInsets.only(left: 12.0, top: 7.0, bottom: 7.0),
          child: current_user.avatarUrl != null
              ? ClipOval(
                  child: Image.network(
                    current_user.avatarUrl ?? "",
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox()),
    );
  }

  listEvent() {
    if ((userHasEvents == true)&&(thereAreEvents == true)) {
      return SizedBox(
        height: listEvents.length * 260,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount:
            searchEvents.isEmpty ? listEvents.length : searchEvents.length,
            itemBuilder: (BuildContext context, int index) {
              var listEvent = searchEvents.isEmpty ? listEvents : searchEvents;
              return SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.95,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          //fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 170),
                          padding: const EdgeInsets.all(0),

                          backgroundColor: Colors.transparent,
                          side: const BorderSide(
                              color: Colors.transparent, width: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Event_page(
                                        event: listEvent[index],
                                      )));
                          costyl = listEvents;
                          cotyl_index = index;
                          // u_r_member = isUserExist(
                          //     events_add_page[Event_index].participants,
                          //     current_user.id);
                        },
                        // key: Key(current_events[index].index.toString()),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.95,
                          //height: 185,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, bottom: 15),
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
                                        "${DateTime
                                            .parse(listEvent[index]["date"])
                                            .day}/${DateTime
                                            .parse(listEvent[index]["date"])
                                            .month}/${DateTime
                                            .parse(listEvent[index]["date"])
                                            .year
                                            .toInt() % 100}",
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Oswald',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        listEvent[index]["time"]
                                            .split(':')
                                            .map((e) => e.padLeft(2, '0'))
                                            .join(':'),
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Oswald',
                                          color: Color.fromARGB(
                                              255, 248, 231, 174),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.03,
                                ),

                                SizedBox(
                                  // width: 30
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            listEvent[index]["event_autor"]["avatarUrl"] ??
                                                "",
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          //width: 30,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.04,
                                        ),
                                        Text(
                                          listEvent[index]["event_autor"]["username"] +
                                              "," + " " +
                                              listEvent[index]["event_autor"]["age"]
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Oswald',
                                            color: Color.fromARGB(
                                                255, 248, 231, 174),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.5,
                                          child: Text(
                                            listEvent[index]["name"],
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
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.5,
                                          child: Text(
                                            listEvent[index]["shortDescription"],
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
                                      child: Row(
                                        children: [
                                          home_pics_builder(context,
                                              listEvent[index]["picURL1"]),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          home_pics_builder(context,
                                              listEvent[index]["picURL2"]),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ]),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                                        builder: (context) =>
                                            Chat_p(
                                              event: listEvent[index],
                                            )));
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(8.0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 251, 194, 235)),
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
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ));
            }),
      );
    }else {
      // Если у пользователя нет событий, возвращаем пустой контейнер или другой контент
      return Container();
    }
  }

  // void openUrlInBrowser(Uri url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
