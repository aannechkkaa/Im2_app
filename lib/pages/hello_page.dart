import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im2/pages/first_page.dart';
import 'dart:html';


class hello_page extends StatefulWidget {
  const hello_page({super.key});

  @override
  State<hello_page> createState() => _hello_pageState();
}

class _hello_pageState extends State<hello_page> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => First_p()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Colors.pink,
        // backgroundColor:  Color.fromARGB(255, 255, 247, 225),
      body:
          Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Center(
          //       child: Image.asset("assets/lolgo.gif",
          //         width: 200,
          //         height: 200,),
          //     ),
          //     Center(
          //       // child: SvgPicture.asset(
          //       //   'assets/hello_page_logo.svg',
          //       //   // Укажите размер изображения
          //       //   width: MediaQuery.of(context).size.width * 0.8,
          //       //   //height: 130,
          //       // ),
          //
          //     )
          //   ],
          )
        
    );
  }
}
