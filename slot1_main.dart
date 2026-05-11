//import thu vien
import 'package:flutter/material.dart';
//ham main
void main(){
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PRM393- FLutter Demo'),
        ),
        body: const Center(
          child: Text(
            'Hello Flutter',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    ),
  );
}