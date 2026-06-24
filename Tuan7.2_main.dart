import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main(){
  runApp(MaterialApp(home:MyApp()));
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp>{
  //code
  List products = [];
  TextEditingController txt = TextEditingController();
  String url = "http://10.22.10.72:3001/products";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProduct();//load cac san pham trong database
  }
  //dinh nghia ham load san pham trong db
  Future loadProduct() async {
   var res = await http.get(
      Uri.parse(url)
    );
   //update trang thai
    setState(() {
      products = jsonDecode(res.body);
    });
  }
  //ham them du lieu
  Future addProduct() async {
    await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type":"application/json"
      },
      body: jsonEncode({
        "name":txt.text
      }),
    );
    txt.clear();//reset
    loadProduct();//reload
  }
  //giao dien
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MySQL demo"),),
      body: Column(
        children: [
          TextField(
            controller: txt,
            decoration: InputDecoration(hintText: "Ten san pham"),
          ),
          ElevatedButton(onPressed: addProduct, child: Text("Them")),
          Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_,i){
                    return ListTile(
                      title: Text(products[i]["name"]),
                    );
                  })),
        ],
        
      ),
    );
  }
}