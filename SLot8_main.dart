import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //flutter pub get de cap nhat lib
void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyListViewSlot8(),
  ));
}
//man hinh chinh
class MyListViewSlot8 extends StatefulWidget{
  const MyListViewSlot8({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyListViewSlot8State();
  }
}
//lop quan ly trang thai cho man hinh chinh
class _MyListViewSlot8State extends State<MyListViewSlot8>{
  List products = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }
  Future<void> loadData() async {
    final resonse = await http.get(
      Uri.parse('https://hungnttg.github.io/shopgiay.json'),
    );
    final data = jsonDecode(resonse.body);//chuyen sang json
    //cap nhat vao state
    setState(() {
      products = data["products"];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products'),),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context,index){
            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(products[index]['search_image'],
                    width: 200,
                    height: 200,

                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        products[index]['product_additional_info'],
                        style: const TextStyle(fontSize: 18),
                      ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}