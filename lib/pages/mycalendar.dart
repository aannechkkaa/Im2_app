//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:im2/pages/account.dart';
// import 'package:im2/pages/Users.dart';
// import 'package:im2/pages/MyWidgets/home_pics.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'Event.dart';
// import 'package:im2/pages/add_event.dart';
// import 'package:im2/pages/mycalendar.dart';
// import 'package:im2/pages/Events.dart';
// import 'package:im2/pages/home.dart';
//
// List<Event> filterEventsByParticipant(List<Event> events, User participant) {
//   return events.where((event) => event.participants.contains(participant)).toList();
// }
//
// List<Event> my_events =[];
//
// class Calendar_dart extends StatefulWidget {
//   const Calendar_dart({super.key});
//   @override
//   State<Calendar_dart> createState() => _Calendar_dartState();
// }
//
// class _Calendar_dartState extends State<Calendar_dart> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color.fromARGB(255, 16, 79, 58),
//         title: Text('Ваши ближайшие события', style:
//         TextStyle(
//           fontSize: 30,
//           fontFamily: 'Oswald',
//           color: Colors.white,
//         ),
//         ),
//         centerTitle: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Colors.white,
//           iconSize: 30,
//           onPressed: () => {
//             Navigator.of(context).pop(),
//           },
//         ),
//
//       ),
//       body:
//
//       SizedBox(
//         height: my_events.length * 250,
//         child:
//         ListView.builder(
//             itemCount: my_events.length,
//             itemBuilder: (BuildContext context, int index){
//               return
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.95,
//                   child:
//                       Column(
//                         children:[
//                       IntrinsicHeight(
//                         child: ElevatedButton(
//                           style:
//                           ElevatedButton.styleFrom(
//                             elevation: 0,
//                             //fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 170),
//                             padding: EdgeInsets.all(0),
//
//                             backgroundColor: Colors.transparent,
//                             //borderRadius: BorderRadius.all(Radius.circular(20)),
//                             side: BorderSide(color: Colors.transparent,
//                                 width: 1),
//                           ),
//                           onPressed: (){
//                             //Navigator.pushNamed(context, '/event');
//                             //Event_page() event_page = new Event_page();
//                             // String event_short_description = events_add_page[index].shortDescription;
//                             // Event this_event = events_add_page.firstWhere((event) => event.shortDescription == event_short_description);
//                             // print(this_event.name);
//                             Event_index = my_events[index].index;
//                             Navigator.push(context, new MaterialPageRoute(
//                                 builder: (context) => new Event_page())
//                             );
//                             u_r_member = isUserExist(events_add_page[Event_index].participants, current_user.id);
//                           },
//                           key: Key(my_events[index].index.toString()),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.95,
//                             //height: 185,
//                             margin: const EdgeInsets.only(top: 10),
//                             padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
//                             // constraints: BoxConstraints(
//                             //   minHeight: 40, //minimum height
//                             //   maxHeight: 185,
//                             // ),
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(20)),
//                               color: Color.fromARGB(255, 16, 79, 58),
//
//                             ),
//                             child:
//                             Row(
//
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Visibility(
//                                     visible: true,
//                                     child:  Row(
//                                       children: [
//                                         TextButton(
//                                             onPressed: (){
//                                               setState(() {
//                                                 events_add_page.removeAt(index + 1);
//                                                 my_events.removeAt(index + 1);
//                                               });
//                                             },
//                                             child: Text("Удалить")
//                                         )
//                                       ],
//                                     ),
//                                   ),
//
//                                   SizedBox(
//                                     width: 70,
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(width : 20),
//                                         Text(my_events[index].Date.day.toString() + "/" + my_events[index].Date.month.toString() + "/" + (my_events[index].Date.year.toInt() % 100).toString(),
//
//                                           style:
//                                           TextStyle(
//                                             fontSize: 21,
//                                             fontFamily: 'Oswald',
//                                             color: Colors.white,
//                                           ),),
//
//                                         Text(my_events[index].Time.toString()[10] + my_events[index].Time.toString()[11] + my_events[index].Time.toString()[12] + my_events[index].Time.toString()[13] + my_events[index].Time.toString()[14] ,
//                                           style:
//                                           TextStyle(
//                                             fontSize: 21,
//                                             fontFamily: 'Oswald',
//                                             color: Color.fromARGB(255, 247, 183, 59),
//                                           ),),
//
//                                         SizedBox(height : 10),
//                                         Row(
//
//                                           children: [
//
//
//                                             SizedBox(
//                                               width: 70,
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Column(
//                                                         children: [
//                                                           Icon(Icons.place_outlined),
//                                                         ],
//                                                       ),
//                                                       Column(
//                                                         children: [
//                                                           Container(
//                                                             width: 40,
//                                                             child:
//                                                             Flexible(child:
//                                                             Text(my_events[index].place,
//                                                               softWrap: true,
//                                                               maxLines: 2,
//
//                                                               style:
//                                                               TextStyle(
//                                                                 fontSize: 15,
//                                                                 fontFamily: 'Oswald',
//                                                                 color: Color.fromARGB(255, 154, 220, 184),
//                                                               ),),),
//                                                           ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//
//
//                               SizedBox(width : MediaQuery.of(context).size.width * 0.03,),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         height: 5,
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Image(image: AssetImage('assets/Vector_1.png')),
//                                       // Divider(
//                                       //   height: double.infinity,
//                                       //   thickness: 2,
//                                       //   color: Colors.grey,
//                                       //   indent: 10,
//                                       //   endIndent: 10,
//                                       // )
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         height: 5,
//                                       )
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                               SizedBox(width : MediaQuery.of(context).size.width * 0.03,),
//
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       ClipOval(
//                                         child: Image.network(
//                                           my_events[index].event_autor.avatarUrl!,
//                                           width: 30,
//                                           height: 30,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       SizedBox(width : MediaQuery.of(context).size.width * 0.04,),
//                                       Text(my_events[index].event_autor.username + "," + " " + my_events[index].event_autor.age.toString(),
//                                         style:
//                                         TextStyle(
//                                           fontSize: 18,
//                                           fontFamily: 'Oswald',
//                                           color: Color.fromARGB(255, 247, 183, 59),
//                                         ),),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: MediaQuery.of(context).size.width * 0.5,
//                                         child: Text(my_events[index].name,
//                                           softWrap: true,
//                                           style:
//                                           TextStyle(
//                                             fontSize: 18,
//                                             fontFamily: 'Oswald',
//                                             color: Color.fromARGB(255, 247, 183, 59),
//                                           ),),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: MediaQuery.of(context).size.width * 0.5,
//                                         child:
//                                         Text(my_events[index].shortDescription,
//                                           softWrap: true,
//                                           style:
//                                           TextStyle(
//                                             fontSize: 15,
//                                             fontFamily: 'Oswald',
//                                             color: Colors.white,
//                                           ),),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         height: 8,
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       home_pics_builder(context, my_events[index].picURL1),
//                                       SizedBox(width: 2,),
//                                       home_pics_builder(context, my_events[index].picURL2),
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ]
//                         ),
//                       ),
//                     ),
//                   ),
//
//                           SizedBox(height: 10,),
//                           Row(
//                             children: [
//                               SizedBox(width: 10,),
//                               TextButton(onPressed: (){
//                                 openUrlInBrowser(Uri.parse(my_events[index].chatLink));
//                               },
//                                 child: Text("Перейти в чат участников",
//                                     style: TextStyle(
//                                         fontSize: 17,
//                                         color: Colors.blueGrey,
//                                         fontFamily: 'Oswald'
//                                     )
//                                 ),
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                   )),
//                                   backgroundColor: MaterialStateProperty.all(Colors.transparent,),
//                                   //minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-5,10))
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20,)
//
//                     ]
//                 ),
//
//                 );
//
//
//             }
//         ),
//       ),
//     );
//   }
//
//   void openUrlInBrowser(Uri url) async {
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
