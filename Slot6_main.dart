//hien thi listview co anh
import 'package:flutter/material.dart';
//ham main
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo- List view co Anh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyListViewSlot6(),
    );
  }
}
//man hinh chinh
class MyListViewSlot6 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyListViewSlot6State();
  }
}
//lop quan ly trang thai cho man hinh chinh
class _MyListViewSlot6State extends State<MyListViewSlot6>{
  //khai bao mang du lieu co anh (sau nay se doc tu server)
  final List<ListItem> items  =[
    ListItem(
        title: 'Cat',
        subtitle: 'Cute cat',
        imageUrl: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=200'
    ),
    ListItem(
        title: 'Dog',
        subtitle: 'Lovely dog',
        imageUrl: 'https://images.unsplash.com/photo-1517849845537-4d257902454a?w=200'
    ),
    ListItem(
        title: 'Mountain',
        subtitle: 'Beautiful mountain',
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=200'
    ),
  ];
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listview Example'),),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (contex, index){
            return ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].subtitle),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(items[index].imageUrl),
              ),
              onTap: (){
                print('Itemn Clicked: ${items[index].title}');
              },
            );
          }),
    );
  }
}
//lop quan ly doi tuong ListItem
class ListItem{
  final String title;
  final String subtitle;
  final String imageUrl;
  ListItem({
  required this.title, required  this.subtitle, required this.imageUrl
  });
}