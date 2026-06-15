//code man hinh dang nhap
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  runApp(MaterialApp(home:LoginPage()));
}
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}
class _LoginPageState extends State<LoginPage>{
  //code
  //--2 controller cho 2 o nhap lieu
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String msg = "";//thong bao
  bool loading = false;
  //ham login
Future login() async {
  setState(() {
    loading=true;
  });
  //ket noi voi API
  try {
    final res = await http.post(
      Uri.parse('http://10.22.10.72:3001/login'),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"email":user.text,"password":pass.text}),
    );
    final data = jsonDecode(res.body);//update vao data
    if(res.statusCode == 200){ //neu login thanh cong
      //khoi tao sharedPreference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["token"]);//luu vao sharedPreference
      setState(() {
        msg="Login thanh cong";//cap nhat thong bao
      });
    }
    else {
      setState(() {
        msg=data["error"]; //ket noi khong thanh cong thi dua ra loi
      });

    }
  }
  catch(e){
    msg="Loi ket noi";
  }
  setState(() {
    loading=false;
  });
}
  //layout
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login API"),),
      body: Padding(padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: user,
            decoration: InputDecoration(labelText: "Nhap Email"),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: pass,
            decoration: InputDecoration(labelText: "Password"),
          ),
          SizedBox(height: 20,),
          loading ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: login, child: Text("LOGIN")),
          SizedBox(height: 20,),
          Text(msg),
        ],
      ),),
    );
  }
}