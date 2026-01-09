import 'package:flutter/material.dart';

import 'notodo_screen.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoToDo",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500),),
        centerTitle: true,

        backgroundColor: Colors.black54,
      ),
      body: NotoDoScreen(),
    );
  }
}
