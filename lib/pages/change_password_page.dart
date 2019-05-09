import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../components/toast.dart';
import 'dart:async';

class ChangePasswordPage extends StatefulWidget {
  final int type;
  ChangePasswordPage({Key key, this.type});
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController surePasswordController = TextEditingController();
  Map accountObj = {};
  String barTitle = '设置';
  bool isGetVerifyCode = false;
  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  @override
  void initState() { 
    super.initState();
    if(widget.type == 0) {
      barTitle = '设置';
    }else if(widget.type == 1) {
      barTitle = '修改';
    }else{
      barTitle = '忘记';
    }
    _getAccountMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$barTitle交易密码'),),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF2F2F2),
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              itemInputWidget('手  机  号', phoneController, '请输入手机号', false, false, 'number',(res){}),
              Container(
                padding: EdgeInsets.only(left: 10,),
                height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2))),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('验  证  码'),
                    Expanded(
                      child:  _inputWidget(codeController, '请输入验证码', false, true, 'number', (res){
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
              Padding(child: null,padding: EdgeInsets.only(top:10),),
              itemInputWidget('交易密码', passwordController, '请输入密码', true, true,'text',(res){}),
              itemInputWidget('确认密码', surePasswordController, '请输入密码', true, true, 'text',(res){}),
              Padding(child: null,padding: EdgeInsets.only(top:30),),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right:10),
                  height: ScreenUtil().setHeight(100),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text('确定',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.white),),
                  ),
                ),
                onTap: (){
                  _checkParams();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget itemInputWidget(String title, TextEditingController controller, String hintText,bool obscureText,bool enabled, String inputType, Function change) {
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
            child:  _inputWidget(controller, hintText, obscureText,enabled, inputType, change),
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
        enabled: enabled,
        cursorColor: Colors.black,
        obscureText: obscureText,
        keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
        onChanged: (text){
          return change(text);
        },
      ),
    );
    
  }
  _getAccountMessage() {//获取交易账户信息
    postAjax('mobileUserMoney', {}, context).then((res){
      if(res['code'] == 200) {
        setState(() {
          accountObj = res['content'];
          phoneController.text = accountObj['phoneNumber'].trim();
        });
      }
    });
  }
  _checkParams() {//交易参数
    if(codeController.text.trim() == ''){
      return Toast.toast(context, '请输入验证码');
    }
    if(passwordController.text.trim() == '') {
      return Toast.toast(context, '请输入交易密码');
    }
    if(surePasswordController.text == '') {
      return Toast.toast(context, '请输入确认密码');
    }
    if(passwordController.text.trim()  != surePasswordController.text.trim()){
      return Toast.toast(context, '两次输入密码不一致');
    }
    _modifyPassword();
  }
  _modifyPassword() {//修改交易密码
    Map<String, dynamic> params = {};
    params['mobile'] =  accountObj['phoneNumber'].trim();
    params['verifyCode'] = codeController.text.trim();
    params['password'] = passwordController.text.trim();
    postAjax('modifyPassword', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '修改成功');
      }
      Future.delayed(Duration(milliseconds: 1000),(){
        Navigator.of(context).pop();
      });
    });
  }
  _getVerifyCode() {//获取手机验证码
    RegExp regM = RegExp(r'(^1[23456789]{1}\d{9}$)');//匹配手机号
    if(regM.hasMatch(phoneController.text.trim())){
      postAjax('sendModifyCode', {'mobile':phoneController.text.trim()}, context).then((res){
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