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


List<dynamic> costyl = [];
int cotyl_index = 1;
List<Event> sort_events(List<Event> events) {
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


class HomeState extends State<Home> {
  List<Event> current_events = sort_events(events_add_page);

  List<Event> filteredEvents = [];
  List<dynamic> listEvents = [];
  List<dynamic> searchEvents = [];

  //Event e1 = new Event();
  int Count = 0;
  int Current_index = 0;
  bool not_first = false;
  bool _my_events = false;
  bool show_url_bttn = false;
  String list_of = "Cобытия в городе";

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
                        if(listEvents.where((e) => e["category"] == "Активный отдых").toList().length == 0){
                          searchEvents == 0;
                        }
                        else{
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Активный отдых")
                              .toList();
                          // current_events = sort_events(events_add_page
                          //     .where(
                          //         (event) => event.category == "Активный отдых")
                          //     .toList());
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
                        if(listEvents
                            .where((e) => e["category"] == "Кафе и рестораны").toList().length == 0){
                          searchEvents == 0;
                        }
                        else{
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Кафе и рестораны")
                              .toList();
                          // current_events = sort_events(events_add_page
                          //     .where(
                          //         (event) => event.category == "Кафе и рестораны")
                          //     .toList());
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
                        if(listEvents.where((e) => e["category"] == "Искусство и культура").toList().length == 0){
                          searchEvents == 0;
                        }
                        else{
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Искусство и культура")
                              .toList();
                          // current_events = sort_events(events_add_page
                          //     .where(
                          //         (event) => event.category == "Кафе и рестораны")
                          //     .toList());
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
                        if(listEvents.where((e) => e["category"] == "Отдых на природе").toList().length == 0){
                          searchEvents == [];
                        }
                        else{
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Отдых на природе")
                              .toList();
                          // current_events = sort_events(events_add_page
                          //     .where(
                          //         (event) => event.category == "Отдых на природе")
                          //     .toList());
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

                        if(listEvents.where((e) => e["category"] == "Ночная жизнь").toList().length == 0){
                          searchEvents == [];
                        }
                        else{
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Ночная жизнь")
                              .toList();
                          // current_events = sort_events(events_add_page
                          //     .where(
                          //         (event) => event.category == "Ночная жизнь")
                          //     .toList());
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

                        if(listEvents.where((e) => e["category"] == "Путешествия").toList().length == 0){
                          searchEvents == [];
                        }
                        else{
                          searchEvents = listEvents
                              .where((e) => e["category"] == "Путешествия")
                              .toList();
                          // current_events = sort_events(events_add_page
                          //     .where(
                          //         (event) => event.category == "Путешествия")
                          //     .toList());
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
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        Event().getEvent().then((value) {
                          searchEvents.clear();
                          listEvents = value;
                          setState(() {});
                          current_events = sort_events(events_add_page);
                          show_url_bttn = false;
                          list_of = "События в городе";
                        });
                      });
                    },
                    child: const Text(
                      "Показать всe",
                      style: TextStyle(
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
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      searchEvents = listEvents
                          .where(

                              (e) => e["participants"]["id"] == current_user.id).toList();
                      setState(() {
                        current_events = current_events
                            .where((event) =>
                                event.participants.contains(current_user))
                            .toList();
                        show_url_bttn = true;
                        list_of = "Мой календарь";
                      });
                    },
                    child: const Text(
                      "Показать только мои события",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        //fontFamily: 'Oswald',
                      ),
                    )),
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
                              icon: const Icon(
                                Icons.map_outlined,
                                color: Color.fromARGB(255, 74, 68, 134),
                              )),
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
    return SizedBox(
      height: listEvents.length * 250,
      child: ListView.builder(
          itemCount:
              searchEvents.isEmpty ? listEvents.length : searchEvents.length,
          itemBuilder: (BuildContext context, int index) {
            var listEvent = searchEvents.isEmpty ? listEvents : searchEvents;
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
                          //Navigator.pushNamed(context, '/event');
                          //Event_page() event_page = new Event_page();
                          // String event_short_description = events_add_page[index].shortDescription;
                          // Event this_event = events_add_page.firstWhere((event) => event.shortDescription == event_short_description);
                          // print(this_event.name);
                          // Event_index = current_events[index].index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Event_page(
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
                          width: MediaQuery.of(context).size.width * 0.95,
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
                          IntrinsicWidth(
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
                                        "${DateTime.parse(listEvent[index]["date"]).day}/${DateTime.parse(listEvent[index]["date"]).month}/${DateTime.parse(listEvent[index]["date"]).year.toInt() % 100}",
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Oswald',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        listEvent[index]["time"].split(':').map((e) => e.padLeft(2, '0')).join(':'),
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Oswald',
                                          color: Color.fromARGB(255, 248, 231, 174),
                                        ),
                                      ),
                                      SizedBox(height: 10),
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
                                                          child: Flexible(
                                                            child: Text(
                                                              listEvent[index]
                                                                  ["place"],
                                                              softWrap: true,
                                                              maxLines: 2,
                                                              style:
                                                                  const TextStyle(fontSize: 15,
                                                                    fontFamily:
                                                                    'Oswald',
                                                                color: Color.fromARGB(255, 248, 231, 174),
                                                              ),
                                                            ),
                                                          ),
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
                                // SizedBox(
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.03,
                                // ),
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                          width: 1,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image(
                                            image: AssetImage('assets/Vector_1.png')),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                          width: 1,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            listEvent[index]["event_autor"]["avatarUrl"] ?? "",
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                        Text(
                                          listEvent[index]["event_autor"]
                                                  ["username"] +
                                              "," +
                                              " " +
                                              listEvent[index]["event_autor"]
                                                      ["age"]
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
                                    IntrinsicWidth(
                                      child:
                                    Row(
                                    children: [
                                    Container(
                                    width: 100,
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
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text(
                                            listEvent[index]
                                                ["shortDescription"],
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
                                      builder: (context) => Chat_p(
                                            event: listEvent[index],
                                          )));
                            },
                            style: ButtonStyle(
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
  }

  void openUrlInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
