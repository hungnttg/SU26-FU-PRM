import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//ham main
void main(){
  runApp(const MyApp());
}
//config
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slot9',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyListViewSlot9(),//man hinh chinh
    );
  }
}
//dinh nghia man hinh chinh
class MyListViewSlot9 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyListViewSlot9State();//lop quan ly trang thai cho man hinh chinh
  }
}
//dinh nghia lop quan ly trang thai cho man hinh chinh
class _MyListViewSlot9State extends State<MyListViewSlot9>{
  late List<Photo> photos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetDataFromServer();//ham doc du lieu tu server
  }
  //dinh nghia ham fetDataFromServer
Future<void> fetDataFromServer() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos')
    );
    if(response.statusCode == 200){//doc du lieu thanh cong
      //chuyen doi du lieu sang list object
      final List<dynamic> jsonData = json.decode(response.body);
      photos = jsonData.map((item)=>Photo.fromJson(item)).toList();
      //reset trang thai
      setState(() {

      });
    }
    else {
      throw Exception('Failed to load data from server');
    }
}
//giao dien
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Read data from Server'),),
      body: photos == null
      ? Center(child: CircularProgressIndicator(),)
      : ListView.builder(
          itemCount: photos.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(photos[index].title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(photos[index].thumbnailUrl),
              ),
              onTap: (){
                print('Item clicked: ${photos[index].title}');
              },
            );
          }),
    );
  }
}
//lop quan ly list item
class Photo{
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({ required this.title, required this.url, required this.thumbnailUrl});
  //ham chuyen doi tu Json sang Object cua dart
  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']
    );
  }
}