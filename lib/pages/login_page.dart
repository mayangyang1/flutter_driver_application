import 'package:flutter/material.dart';
import '../components/toast.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../common/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/find_password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String userName = '';
  String password = '';
  _loginAccount()async {//登录
    SharedPreferences prefs =await SharedPreferences.getInstance();

    if(userName == '') {
     return Toast.toast(context, '请输入账号');
    }
    if(password == '') {
      return Toast.toast(context, '请输入密码');
    }
    try {
      print('获取数据');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
      response = await dio.post('https://rltx2-yfb-gateway.rltx.com/account/driverLogin', data: {'account':userName.trim(), 'password':password.trim()});
      print(response.data['code']);
      if(response.data['code'] == 200) {
        String cookies = getCookieAndSaveInStorage(response);
        prefs.setString('cookies', cookies);
        Navigator.pushNamedAndRemoveUntil(context, '/resource', (route)=>false);
      }else{
        Toast.toast(context, response.data['content']);
      }
    } on DioError catch (e) {
      if (e.response.data['code'] == 401) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录'),),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            children: <Widget>[
              _logoImage(),
              loginWidget()
            ],
          )
        )
      )
    );
  }
  Widget _logoImage() {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(top: 60.0,bottom: 40.0),
      child: Center(
        child: Image.asset('assets/images/logo.png',width: ScreenUtil().setWidth(340),),
      )
    );
  }
  Widget loginWidget() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            _inputWidget(userNameController, 'assets/images/users.png', '请输入用户名', false , 'number', (res){
              setState(() {
                print(res);
               userName = res; 
              });
            }),
            _inputWidget(passwordController,'assets/images/password.png', '请输入密码', true, 'text', (res){
              setState(() {
               password = res; 
              });
            }),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(100),
                margin: EdgeInsets.only(top: 20.0,  left: 20.0,right: 20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text('登录', style:TextStyle(fontSize: ScreenUtil().setSp(40),color: Colors.white)),
                ),
              ),
              onTap: (){
                _loginAccount();
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
               margin: EdgeInsets.only(top: 10.0,  left: 20.0,right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Text('立即注册', style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Colors.black26),),
                    onTap: (){
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  InkWell(
                    child: Text('找回密码', style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Colors.black26),),
                    onTap: (){
                      print('点击');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return FindPassword();
                      }));
                    },
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
  Widget _inputWidget(TextEditingController controller, String imgUrl, String hintText, bool obscureText, String inputType, Function change){
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      padding: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Row(
        children: <Widget>[
          Image.asset(imgUrl,width: ScreenUtil().setWidth(60),),
          Padding(child: null,padding: EdgeInsets.only(left: 10),),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                disabledBorder: InputBorder.none,
                enabledBorder:InputBorder.none,
                focusedBorder:InputBorder.none
              ),
              cursorColor: Colors.black,
              obscureText: obscureText,
              keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
              onChanged: (text){
                return change(text);
              },
            ),
          )
        ],
      ),
    );
  }
  
}