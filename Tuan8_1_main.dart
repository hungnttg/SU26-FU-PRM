import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main(){
  runApp(MaterialApp(home: MyApp(),));
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _MyAppState();
  }
}
class _MyAppState extends State<MyApp>{
  //code
  List data=[];
  TextEditingController txt = TextEditingController();
  String url="http://10.22.10.72:3001/products";
  //cap nhat trang thai
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();//goi ham load du lieu tu server
  }
  //dinh nghia ham load du lieu tu server
  Future load() async {
    var response = await http.get(Uri.parse(url));//doc du lieu
    //cap nhat vao trang thai
    setState(() {
      data = jsonDecode(response.body);//tra du lieu doc duoc tu server cho data
    });
  }
  //Dinh nghia ham them du lieu
  Future add() async {
    await http.post(
      Uri.parse(url),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"name":txt.text}),//them gia tri do nguoi dung nhap
    );
    txt.clear();//reset
    load();//reload
  }
  //sua
  Future update(id) async {
    await http.put(
      Uri.parse("$url/$id"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"name":txt.text}),//update dua tren text nguoi dung nhap
    );
    txt.clear();//reset
    load();//reload data
  }
  //xoa
  Future delete(id) async {
    await http.delete(Uri.parse("$url/$id"));
    load();
  }
  //layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ket noi voi MySQL"),),
      body: Column(
        children: [
          TextField(
            controller: txt,
            decoration: InputDecoration(hintText: "name"),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: add, child: Text("THEM")),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                if(data.isNotEmpty){
                  update(data[0]["id"]);//chi update dong 0
                }
              }, child: Text("Sua"),),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_,i){
                    return ListTile(
                      title: Text(data[i]["name"]),
                      onTap: (){
                        txt.text = data[i]["name"];
                      },
                      trailing: IconButton(onPressed: (){
                        delete(data[i]["id"]);
                      }, icon: Icon(Icons.delete)),
                    );
                  })),
        ],

      ),
      //   listview
    );
  }
}