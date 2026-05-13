//bai tinh tong 2 so
//1. import thu vien
import 'package:flutter/material.dart';
//2. ham main
void main(){
  runApp(const MyApp());//goi den lop MyApp (file cau hinh)
}
//dinh nghia MyApp (file cau hinh)
class MyApp extends StatelessWidget{
  //ham khoi tao
  const MyApp({super.key});
  //giao dien: goi den man hinh chinh
  @override
  Widget build(BuildContext context) {
    //xay dung giao dien thi dung Material
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyCalculator(),//giao dien chinh
    );
  }
}
//dinh nghia giao dien chinh
class MyCalculator extends StatefulWidget{
  //tao trang thai
    @override
  State<StatefulWidget> createState() {
    return _MyCalculatorState();//lop quan ly trang thai cua giao dien chinh
  }
}
//dinh nghia lop quan ly trang thai cua giao dien chinh
class _MyCalculatorState extends State<MyCalculator>{
  //khai bao 2 control cho phep nhap lieu
  TextEditingController n1Control = TextEditingController();
  TextEditingController n2Control = TextEditingController();
  //label ket qua
  String ketqua='';
  //viet ham tinh tong
  void tinhtong(){
    //lay gia tri nhap vao tu 2 control
    double n1=double.tryParse(n1Control.text) ?? 0.0;
    double n2=double.tryParse(n2Control.text) ?? 0.0;
    //thuc hien tinh tong
    double tong=n1+n2;
    //cap nhat trang thai
    setState(() {
      ketqua='Tong: $tong';
    });
  }
  //---------------giao dien cua man hinh chinh
  @override
  Widget build(BuildContext context) {
    return Scaffold(//tra ve 1 man hinh
      appBar: AppBar(title: Text('Ung dung tinh tong'),),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //thanh phan chinh: text1
              TextField(
                controller: n1Control,//gan voi so 1
                keyboardType: TextInputType.number,//chi cho nhap so
                decoration: InputDecoration(labelText: 'Nhap so 1'),
              ),
              SizedBox(height: 10.0,),//khoang cach
              //thanh phan chinh Text2
              TextField(
                controller: n2Control,//gan voi so 2
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'NHap so 2'),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: tinhtong, child: Text('Click me')),
              SizedBox(height: 20.0,),
              Text(
                ketqua,
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
            ],
          ),
      ),
    );
  }
}