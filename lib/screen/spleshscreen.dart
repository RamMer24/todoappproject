
import 'package:flutter/material.dart';
import 'package:todoappproject/screen/Viewscreen.dart';

class spleshscreen extends StatefulWidget {


  @override

  State<spleshscreen> createState() => _spleshscreenState();
}

class _spleshscreenState extends State<spleshscreen> {

  cheklogin()async
  {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Viewscreen()));
  }
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      cheklogin();
    });

  }
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/todo.jpg',), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: 100,
              width: 100,
            ),
            Container(
              padding: EdgeInsets.only(left: 70, top: 100),
              child: Text(
                'WELCOM TO\nTO DO APP',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
