import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(home:MyApp()));
}
//dinh nghia man hinh chinh
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();//lop quan ly trang thai cua man hinh chinhy
  }
}
class _MyAppState extends State<MyApp>{
  //code
  List data =[];
  TextEditingController txt = TextEditingController();
  String url = "http://10.22.10.72:3001/products";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  //doc du lieu
  Future loadData() async {
    final res = await http.get(Uri.parse(url)); //doc du lieu tu server
    setState(() {
      data = jsonDecode(res.body);//chuyen sang json va tra ve data
    });
  }
  //ham them du lieu
  Future addData() async {
    await http.post(
      Uri.parse(url),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"name": txt.text}),
    );
    txt.clear();//reset du lieu
    loadData();//load lai du lieu
  }
  //ham xoa du lieu
  Future deleteData(id) async {
    await http.delete(Uri.parse("$url/$id")); //thuc hien xoa
    loadData();//load lai du lieu
  }
  //giao dien
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD API"),),
      body: Column(
        children: [
          TextField(
            controller: txt,
            decoration: InputDecoration(hintText: "Ten san pham"),
          ),
          ElevatedButton(onPressed: addData, child: Text("Them")),
          Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_,i){
                    return ListTile(
                      title: Text(data[i]["name"]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                          onPressed: (){
                            deleteData(data[i]["id"]);
                          }, ),
                    );
                  })),
        ],
      ),
    );
  }
}