import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/change_password_page.dart';

class SecuritySettingPage extends StatefulWidget {
  @override
  _SecuritySettingPageState createState() => _SecuritySettingPageState();
}

class _SecuritySettingPageState extends State<SecuritySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('安全设置'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            safeSettingItem('设置交易密码', 0),
            safeSettingItem('修改交易密码', 1),
            safeSettingItem('忘记交易密码', 2)
          ],
        ),
      ),
    );
  }
  Widget safeSettingItem(String title, int type){
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 10,right:10),
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2))),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Image.asset('assets/images/arrow.png',width: ScreenUtil().setWidth(22),)
          ],
        ),
      ),
      onTap: (){
        if(type == 0){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ChangePasswordPage(type: 0,);
          }));
        }else if(type == 1) {
           Navigator.push(context, MaterialPageRoute(builder: (context){
            return ChangePasswordPage(type: 1,);
          }));
        }else{
           Navigator.push(context, MaterialPageRoute(builder: (context){
            return ChangePasswordPage(type: 2,);
          }));
        }
      },
    );
  }
}