import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import 'dart:async';
import '../components/toast.dart';
import 'dart:convert';
import '../config/service_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController phoneController = new TextEditingController();
  TextEditingController versionCodeController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController surePasswordController = new TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();

  String loginAccount = ''; //账号
  String verifyCode = ''; //验证码
  String password = ''; //密码
  String fullName = ''; //用户名
  String surePassword = ''; //确认密码
  bool check = false; //checkbox默认不选中
  String agreementName = '';//协议名称
  String agreementUrl = ''; //协议地址
  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  bool isGetVerifyCode = false;
  void initState() { 
    _getOtherConfig(); //获取other配置
    _phoneFocusNode.addListener((){
      if(!_phoneFocusNode.hasFocus) {//失去焦点
        print('失去焦点');
          _validateAccount();
      }
    });
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册'),),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          color: Color(0xFFF2F2F2),
          child: Column(
            children: <Widget>[
              _padding(),
              _inputItem(phoneController, _phoneFocusNode, '手 机 号', '请输入手机号', false, 'number', (res){
                setState(() {
                  loginAccount = res;
                });
              }),
              Container(
                height:ScreenUtil().setHeight(100),
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Colors.black12)),
                  color: Colors.white
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(130),
                      child: Text('验 证 码', style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
                    ),
                    Expanded(
                      flex: 1,
                      child: _inputWidget(versionCodeController, null, '请输入验证码', false, 'number',(res){
                        // setState(() {
                         verifyCode = res; 
                        // });
                      }),
                    ),
                    isGetVerifyCode ==false
                    ? InkWell(
                      child: Container(
                        width: ScreenUtil().setWidth(220),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border(left: BorderSide(width: 1,color: Colors.black12))
                        ),
                        child:Center(
                          child: Text( '获取验证码', style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
                        )
                      ),
                      onTap: (){
                        _getVerifyCode();
                      },
                    )
                    : InkWell(
                      child: Container(
                        width: ScreenUtil().setWidth(220),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border(left: BorderSide(width: 1,color: Colors.black12))
                        ),
                        child:Center(
                          child: Text( _codeCountdownStr, style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFFCCCCCC)),),
                        )
                      ),
                      onTap: (){
                        
                      },
                    )
                    
                  ],
                ),
              ),
              _inputItem(userNameController, null, '用 户 名', '请输入用户名', false, 'number', (res){
                fullName = res;
              }),
              _padding(),
              _inputItem(passwordController, null, '密      码', '请输入密码', true, 'number', (res){
                password = res;
              }),
              _inputItem(surePasswordController, null, '确认密码', '请确认密码', true, 'number', (res){
                surePassword = res;
              }),
              Container(
                margin: EdgeInsets.only(top: 1.0,),
                child: Row(
                  children: <Widget>[
                    Checkbox(value: check,onChanged: (res){
                      setState(() {
                       check = !check; 
                      });
                    },),
                    Text('同意 '),
                    InkWell(
                      child: Text('<<$agreementName>>',style: TextStyle(color: Theme.of(context).primaryColor),),
                      onTap: () async{
                        if(agreementUrl != '' && await canLaunch(agreementUrl)) {
                          await launch(agreementUrl);
                        }else{
                          throw 'Could not launch $agreementUrl';
                        }
                      },
                    )
                   
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  width: ScreenUtil().setWidth(400),
                  height: ScreenUtil().setHeight(90),
                  margin: EdgeInsets.only(top:40.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black12),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Center(
                    child: Text('注册',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(30)),),
                  ),
                ),
                onTap: (){
                  if(check != true){
                    return Toast.toast(context, '请同意协议');
                  }
                  if(loginAccount != '' && verifyCode != '' && fullName != '' && password != '') {
                    if(password != surePassword) {
                      return Toast.toast(context, '两次输入密码不一致');
                    }
                    _registerLoginAccount();

                  }else{
                    return Toast.toast(context, '信息不全');
                  }
                },
              )
            ],
          )
        ),
      ),
    );
  }
  Widget _padding(){
    return Container(
      height: 20.0,
      color: Color(0xFFF2F2F2),
    );
  }
  Widget _inputItem(TextEditingController controller, FocusNode _focusNode, String title, String hintText,  bool obscureText, String inputType, Function change) {
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Colors.black12)),
        color: Colors.white
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(130),
            child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
          ),
          Expanded(
            flex: 1,
            child: _inputWidget(controller, _focusNode, hintText, obscureText, inputType,change),
          ),

        ],
      ),
    );
  }
  Widget _inputWidget(TextEditingController controller, FocusNode _focusNode, String hintText, bool obscureText, String inputType, Function change){
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      child: TextField(
        controller: controller,
        focusNode: _focusNode,
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

  _getVerifyCode() {
    RegExp regM = RegExp(r'(^1[23456789]{1}\d{9}$)');//匹配手机号
    if(regM.hasMatch(loginAccount.trim())){
      postAjax('verifyCode', {'mobilePhone':loginAccount}, context).then((res){
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
  _validateAccount() {//校验手机号
  RegExp regM = RegExp(r'(^1[23456789]{1}\d{9}$)');//匹配手机号
    if(loginAccount != '' && regM.hasMatch(loginAccount.trim())){
       postAjaxStr('$serviceUrl/account/account/$loginAccount/validate', {'loginAccount': loginAccount}, context).then((res){
        
      });
    }else{
      return Toast.toast(context, '请检查手机号码');
    }
   
  }
  _registerLoginAccount() { //注册账号
    Map<String, dynamic> params = {
      'loginAccount': loginAccount,
      'verifyCode': verifyCode,
      'fullName': fullName,
      'password': password
    };
    postAjax('accountRegistry', params, context).then((res){
      Toast.toast(context, '注册成功');
      Future.delayed(Duration(milliseconds: 1000),()=> Navigator.pushNamed(context, '/login'));
    });
  }
  _getOtherConfig()async {//获取other配置
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get('otherConfig') != null) {
      Map otherConfig =json.decode(prefs.get('otherConfig'));
      setState(() {
      agreementName =  otherConfig['other.statement.tradeRulesName'];
      agreementUrl = otherConfig['other.statement.tradeRulesUrl'];
      });
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