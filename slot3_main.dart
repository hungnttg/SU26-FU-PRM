//import thu vien
import 'package:flutter/material.dart';
//ham main
void main(){
  runApp(const MyApp());//goi den file cau hinh Flutter
}
//file cau hinh
class MyApp extends StatelessWidget{
  const MyApp({super.key});//ham khoi tao
  //cau hinh
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinh tong 2 so',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: MyCalculator1(), //goi den man hinh chinh
    );
  }
}
//dinh nghia man hinh chinh
class MyCalculator1 extends StatefulWidget{
  //tao lop quan ly trang thai cho MyCalculator1
  @override
  State<StatefulWidget> createState() {
    return _MyCalculator1State();//lop quan ly trang thai cua man hinh chinh
  }
}
//dinh nghia lop quan ly trang thai cua man hinh chinh
class _MyCalculator1State extends State<MyCalculator1>{
  //khai bao 2 control cho 2 text
  TextEditingController n1Ctrl = TextEditingController();//text1
  TextEditingController n2Ctrl = TextEditingController();//text2
  //bien luu kq tinh toan
  String result='';
  //dinh nghia ham tinh tong
  void hamTinhTong(){
    //lay gia tri o 2 o nhap nhieu
    double n1 = double.tryParse(n1Ctrl.text) ?? 0.0;
    double n2 = double.tryParse(n2Ctrl.text) ?? 0.0;
    //tinh tong
    double n = n1+n2;
    //cap nhat trang thai
    setState(() {
      result = 'Tong la: $n';
    });
    //Chuyen sang man hinh hien thi ket qua
    Navigator.push(context, MaterialPageRoute(builder: (conext)=>ResultScreen(result)),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ung dung tinh tong'),),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//giong ra giua
            children: [ //mang chua cac thanh phan giao dien
                //text1
                TextField(
                  controller: n1Ctrl, //gan voi so 1
                  keyboardType: TextInputType.number,//chi cho nhap so
                  decoration: InputDecoration(labelText: 'so 1'),//hint
                ),
                SizedBox(height: 10.0),//khoang cach
                //text2
                TextField(
                  controller: n2Ctrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'so 2'),
                ),
                SizedBox(height: 20.0,),//khoang cach
                //button
              ElevatedButton(onPressed: hamTinhTong, child: Text('Click me')),
              //hien thi ket qua
              // Text(
              //   result,
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),

            ],
          ),
      ),
    );//tra ve 1 man hinh
  }
}
//dinh nghia man hinh ResultScreen
class ResultScreen extends StatelessWidget{
  final String result;
  ResultScreen(this.result);//ham khoi tao
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ket qua'),),
      body: Center(
        child: Text(
          result,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
