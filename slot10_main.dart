import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
void main(){
  runApp(const Slot10());
}
class Slot10 extends StatelessWidget{
  const Slot10({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slot10',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: Slot10Listview(),//man hinh chinh
    );
  }
}
//dinh nghia man hinh chinh
class Slot10Listview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Slot10ListviewState();//lop quan ly trang thai cho man hinh chinh
  }
}
class _Slot10ListviewState extends State<Slot10Listview>{
  late List<Photo>? phs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    docDuLieuTuAPI(); //goi ham doc du lieu tu API
  }
  //dinh nghia ham docDuLieuTuAPI
Future<void> docDuLieuTuAPI() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos')
    );
    //kiem tra ket qua doc duoc
  if(res.statusCode == 200){//doc thanh cong
    final List<dynamic> jData = json.decode(res.body);
    phs = jData.map((item)=>Photo.fromJson(item)).toList();//chuyen sang list
    //reset trang thai
    setState(() {

    });
  }
  else {
    throw Exception("Load failed");
  }
}
//giao dien
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slot10 Listview'),),
      body: phs == null
      ? Center(child: CircularProgressIndicator(),)
      : ListView.builder(
          itemCount: phs!.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(phs![index].title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(phs![index].thumbnailUrl),
              ),
              onTap: (){
                //xu ly su kien khi nguoi dung click
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=> DetailScreen(
                          title: phs![index].title,
                          imageUrl: phs![index].thumbnailUrl,
                        )));
              },
            );
          }),
    );
  }
}
//lop DetailScreen
class DetailScreen extends StatelessWidget{
  final String title;
  final String imageUrl;
  DetailScreen({required this.title,required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Image.network(imageUrl),
          ],
        ),
      ),
    );
  }
}
//doi tuong dai dien cho 1 muc trong list
class Photo {
  final String title;
  final String url;
  final String thumbnailUrl;
  Photo({required this.title,required this.url,required this.thumbnailUrl});
  //ham chuyen doi tu json sang objects
  factory Photo.fromJson(Map<String,dynamic> json){
    return Photo(
        title: json['title'], 
        url: json['url'], 
        thumbnailUrl: json['thumbnailUrl']);
  }
}