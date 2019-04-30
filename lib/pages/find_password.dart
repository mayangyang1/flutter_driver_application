import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../components/toast.dart';
import 'dart:async';

class FindPassword extends StatefulWidget {
  _FindPasswordState createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  TextEditingController phoneController =TextEditingController();
  TextEditingController codeController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  String newPassword = '';
  String mobilePhone = '';
  String verificationCode = '';
  bool isGetVerifyCode = false;
  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('找回密码'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Column(
          children: <Widget>[
            itemInputWidget('手机号', phoneController, '请输入手机号', false, 'number',(res){
              mobilePhone = res;
            }),
            Container(
              padding: EdgeInsets.only(left: 10,),
              height: ScreenUtil().setHeight(100),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC))),
                color: Color(0xFFFFFFFF)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('验证码'),
                  Expanded(
                    child:  _inputWidget(codeController, '请输入验证码', false, 'number', (res){
                      verificationCode = res;
                    }),
                  ),
                  isGetVerifyCode == false
                  ? InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
                          color: Color(0xFFDDDDDD)
                        ),
                        width: ScreenUtil().setWidth(200),
                        child: Center(
                          child: Text('获取验证码'),
                        ),
                      ),
                      onTap: (){
                        _getVerifyCode();
                      },
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
                        color: Color(0xFFDDDDDD)
                      ),
                      width: ScreenUtil().setWidth(200),
                      child: Center(
                        child: Text(_codeCountdownStr, style: TextStyle(color: Color(0XFF666666)),),
                      ),
                    )
                  
                
                ],
              ),
            ),
            itemInputWidget('新密码', passwordController, '请输入密码', true, 'text',(res){
              newPassword = res;
            }),
            Padding(child: null,padding: EdgeInsets.only(top: 100),),
            InkWell(
              child: Container(
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(80),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text('重置密码',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.white),),
                ),
              ),
              onTap: _checkParams,
            )
          ],
        )
      ),
    );
  }
  Widget itemInputWidget(String title, TextEditingController controller, String hintText,bool obscureText, String inputType, Function change) {
    return Container(
      padding: EdgeInsets.only(left: 10, right:10),
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC))),
        color: Color(0xFFFFFFFF)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title),
          Expanded(
            child:  _inputWidget(controller, hintText, obscureText, inputType, change),
          )
         
        ],
      ),
    );
  }
  Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, String inputType, Function change){
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0,),
      padding: EdgeInsets.only(left: 5.0),
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
    );
  }
  _checkParams() {
    if(mobilePhone == '') {
      return Toast.toast(context, '请输入手号');
    }
    if(verificationCode == '') {
      return Toast.toast(context, '请输入验证码');
    }
    if(newPassword == '') {
      return Toast.toast(context, '请输入密码');
    }
    _resetPassord();
  }
  _resetPassord() {//重置密码
    Map<String, dynamic> params = {
      'newPassword': newPassword.trim(),
      'mobilePhone': mobilePhone.trim(),
      'verificationCode': verificationCode.trim()
    };
    postAjax('resetPassword', params, context).then((res){
      if(res != '' && res['code'] == 200) {
        Toast.toast(context, '修改成功');
        Future.delayed(Duration(milliseconds: 1000),() => Navigator.pop(context));
      }
    });
  }
  _getVerifyCode() {//获取手机验证码
    RegExp regM = RegExp(r'(^1[23456789]{1}\d{9}$)');//匹配手机号
    if(regM.hasMatch(mobilePhone.trim())){
      postAjax('resetVerifyCode', {'mobilePhone':mobilePhone}, context).then((res){
        print(res);
        if(res['code'] == 200) {
          reGetCountdown();
          setState(() {
           isGetVerifyCode = true; 
          });
        }
      });
    }else{
      Toast.toast(context, '手机号不正确');
    }
  }

  void reGetCountdown() {//倒计时
    setState(() {
      if (_countdownTimer != null) {
          return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}秒重新获取';
      _countdownTimer =
        new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}秒重新获取';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
            isGetVerifyCode = false;
          }
        });
      });
    });
  }
  // 在这里释放掉Timer
 @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
}