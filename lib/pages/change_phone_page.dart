import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../components/toast.dart';
import 'dart:async';

class ChangePhonePage extends StatefulWidget {
  @override
  _ChangePhonePageState createState() => _ChangePhonePageState();
}

class _ChangePhonePageState extends State<ChangePhonePage> {
  TextEditingController oldPhoneController = TextEditingController();
  TextEditingController oldPhoneCodeController = TextEditingController();
  TextEditingController newPhoneController = TextEditingController();
  TextEditingController newPhoneCodeController = TextEditingController();
  bool isGetVerifyCodeOne = false;
  Timer _countdownTimerOne;
  String _codeCountdownStrOne = '获取验证码';
  int _countdownNumOne = 59;
  bool isGetVerifyCodeTwo = false;
  Timer _countdownTimerTwo;
  String _codeCountdownStrTwo = '获取验证码';
  int _countdownNumTwo = 59;
  @override
  void initState() { 
    super.initState();
    _getSelfInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('找回密码'),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF2F2F2),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                child: null,
                padding: EdgeInsets.only(top: 10),
              ),
              itemInputWidget('原手机号', oldPhoneController, '请输入手机号', false, false, 'number',(res){
              
              }),
              Container(
                padding: EdgeInsets.only(left: 10,),
                height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Color(0xFFDDDDDD))),
                  color: Color(0xFFFFFFFF)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('验证码'),
                    Expanded(
                      child:  _inputWidget(oldPhoneCodeController, '请输入验证码', false, true, 'number', (res){
                        
                      }),
                    ),
                    isGetVerifyCodeOne == false
                    ? InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(width: 1,color: Color(0xFFDDDDDD))),
                            color: Color(0xFFDDDDDD)
                          ),
                          width: ScreenUtil().setWidth(200),
                          child: Center(
                            child: Text('获取验证码'),
                          ),
                        ),
                        onTap: (){
                          _getVerifyCodeOne();
                        },
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
                          color: Color(0xFFDDDDDD)
                        ),
                        width: ScreenUtil().setWidth(200),
                        child: Center(
                          child: Text(_codeCountdownStrOne, style: TextStyle(color: Color(0XFF666666)),),
                        ),
                      )
                    
                  
                  ],
                ),
              ),
              Padding(
                child: null,
                padding: EdgeInsets.only(top: 10),
              ),
              itemInputWidget('新手机号', newPhoneController, '请输入新手机号', false, true, 'number',(res){
                
              }),
              Container(
                padding: EdgeInsets.only(left: 10,),
                height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Color(0xFFDDDDDD))),
                  color: Color(0xFFFFFFFF)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('验证码'),
                    Expanded(
                      child:  _inputWidget(newPhoneCodeController, '请输入验证码', false, true, 'number', (res){
                        
                      }),
                    ),
                    isGetVerifyCodeTwo == false
                    ? InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(width: 1,color: Color(0xFFDDDDDD))),
                            color: Color(0xFFDDDDDD)
                          ),
                          width: ScreenUtil().setWidth(200),
                          child: Center(
                            child: Text('获取验证码'),
                          ),
                        ),
                        onTap: (){
                          _validatePhone();
                        },
                      )
                    : Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
                        color: Color(0xFFDDDDDD)
                      ),
                      width: ScreenUtil().setWidth(200),
                      child: Center(
                        child: Text(_codeCountdownStrTwo, style: TextStyle(color: Color(0XFF666666)),),
                      ),
                    )
                    
                  ],
                ),
              ),
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
                    child: Text('确认',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.white),),
                  ),
                ),
                onTap: (){
                  _changePhoneNumber();
                },
              )
            ],
          ),
        )
      ),
    );
  }
  Widget itemInputWidget(String title, TextEditingController controller, String hintText,bool obscureText, bool enabled, String inputType, Function change) {
    return Container(
      padding: EdgeInsets.only(left: 10, right:10),
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2))),
        color: Color(0xFFFFFFFF)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title),
          Expanded(
            child:  _inputWidget(controller, hintText, obscureText, enabled, inputType, change),
          )
         
        ],
      ),
    );
  }
  Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change){
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
        enabled: enabled,
        keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
        onChanged: (text){
          return change(text);
        },
      ),
    );
  }
  _getSelfInfo() {//查询个人信息
    getAjax('selfInfo', '', context).then((res){
      if(res['code'] == 200) {
        setState(() {
         oldPhoneController.text = res['content']['phone']; 
        });
      }
    });
  }
  _verifySelfCode( Function success) {//获取验证码接口
    postAjax('sendSelfVerifyCode', {}, context).then(success);
    
  }
   _verifyCode(mobilePhone, Function success) {//获取验证码接口
    RegExp regM = RegExp(r'(^1[23456789]{1}\d{9}$)');//匹配手机号
    if(regM.hasMatch(mobilePhone.trim())){
      postAjax('verifyCode', {'mobilePhone' : mobilePhone}, context).then(success);
    }else{
      return Toast.toast(context, '手机号不正确');
    }
    
  }
  _getVerifyCodeOne() {//获取验证码一
    _verifySelfCode((res){
      if(res['code'] == 200) {
        // setState(() {
          if (_countdownTimerOne != null) {
              return;
          }
          // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
          _codeCountdownStrOne = '${_countdownNumOne--}秒重新获取';
          _countdownTimerOne =
            new Timer.periodic(new Duration(seconds: 1), (timer) {
            setState(() {
              if (_countdownNumOne > 0) {
                _codeCountdownStrOne = '${_countdownNumOne--}秒重新获取';
              } else {
                _codeCountdownStrOne = '获取验证码';
                _countdownNumOne = 59;
                _countdownTimerOne.cancel();
                _countdownTimerOne = null;
                isGetVerifyCodeOne = false;
              }
            });
          });
        // });
        setState(() {
          isGetVerifyCodeOne = true; 
        });
      }
    });
  }
  _getVerifyCodeTwo() {//获取验证码二
    String mobilePhone = newPhoneController.text.trim();
    _verifyCode(mobilePhone,(res){
      if(res['code'] == 200) {
        // setState(() {
          if (_countdownTimerTwo != null) {
              return;
          }
          // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
          _codeCountdownStrTwo = '${_countdownNumTwo--}秒重新获取';
          _countdownTimerTwo =
            new Timer.periodic(new Duration(seconds: 1), (timer) {
            setState(() {
              if (_countdownNumTwo > 0) {
                _codeCountdownStrTwo = '${_countdownNumTwo--}秒重新获取';
              } else {
                _codeCountdownStrTwo = '获取验证码';
                _countdownNumTwo = 59;
                _countdownTimerTwo.cancel();
                _countdownTimerTwo = null;
                isGetVerifyCodeTwo = false;
              }
            });
          });
        // });
        setState(() {
          isGetVerifyCodeTwo = true; 
        });
      }
    });
  }
  _validatePhone() {//验证手机号是否已经注册
    String phone =newPhoneController.text.trim();
    postAjaxStr('/account/account/$phone/register/validate', {'loginAccount': phone}, context).then((res){
      if(res['code'] == 200) {
        _getVerifyCodeTwo();
      }else{
        return Toast.toast(context, res['content']);
      }
    });
  }
  _changePhoneNumber() {
    if(oldPhoneCodeController.text.trim() == '') {
      return Toast.toast(context, '验证码不能为空');
    }
    if(newPhoneController.text.trim() == '') {
      return Toast.toast(context, '手机号不能为空');
    }
    if(newPhoneCodeController.text.trim() == '') {
      return Toast.toast(context, '验证码不能为空');
    }
    Map<String, dynamic> params = {};
    params['oldVerifyCode'] = oldPhoneCodeController.text.trim();
    params['newVerifyCode'] = newPhoneCodeController.text.trim();
    params['newLoginAccount'] = newPhoneController.text.trim();
    print(params);
    postAjax('modifyLoginAccount', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '修改成功');
        Future.delayed(Duration(milliseconds: 1000),()=> Navigator.pop(context));
      }
    });
  }
  // 在这里释放掉Timer
 @override
  void dispose() {
    oldPhoneCodeController = null;
    oldPhoneController = null;
    newPhoneCodeController = null;
    newPhoneController = null;
    _countdownTimerOne?.cancel();
    _countdownTimerOne = null;
    _countdownTimerTwo?.cancel();
    _countdownTimerTwo = null;
    super.dispose();
  }
}