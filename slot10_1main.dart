import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
void main(){
  runApp(MaterialApp(home:MyApp()));
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(); //lop quan ly trang thai
  }
}
class _MyAppState extends State<MyApp>{
  late Database db;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDB();//goi ham khoi tao database
  }
  //dinh nghia ham khoi tao
  Future initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(),'shop.db'),
      version: 1,
      onCreate: (db,v) async {
          await db.execute(
            'CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT)',
          );
          await db.insert('products', {'name':'Ao thun'});
          await db.insert('products', {'name':'Giay'});
      },
    );
    data = await db.query('products');
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQLite'),),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await db.insert('products', {'name':'San pham moi'});
            data = await db.query('products');
            setState(() {
              
            });
          }),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (_,i){
            return ListTile(
              title: Text(data[i]['name'].toString()),
            );
          }),
    );
  }
}