import 'package:flutter/material.dart';
import '../components/toast.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';

class AddBankCardPage extends StatefulWidget {
  @override
  _AddBankCardPageState createState() => _AddBankCardPageState();
}

class _AddBankCardPageState extends State<AddBankCardPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController identyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  Map accountObj = {};
  String barTitle = '设置';
  bool isGetVerifyCode = false;
  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加银行卡'),),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              itemInputWidget('持卡人姓名(全称)', userNameController, '例如：张三', false, true, 'text',(res){}),
              itemInputWidget('银行账号', accountController, '请输入银行账号', false, true, 'number',(res){}),
              itemInputWidget('身份证号', identyController, '请输入身份证号', false, true, 'text',(res){}),
              itemInputWidget('手  机  号', phoneController, '请输入银行卡开户预留手机号', false, true, 'number',(res){}),
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
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                color: Colors.white,
                child: Text('交行、平安（含原深发）、上海银行、浦发、邮储，上述银行卡需通过https://www.95516.com/portal.open/init.do开通银联在线支付业务',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Theme.of(context).primaryColor),),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 10,right:10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text('确认添加',style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Colors.white),),
                  ),
                  height: ScreenUtil().setHeight(100),
                  
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
  _checkParams() {//校验参数
    if(userNameController.text.trim() == '') {
      return Toast.toast(context, '请输入持卡人姓名');
    }
    if(accountController.text.trim() == '') {
      return Toast.toast(context, '请输入银行账号');
    }
    if(identyController.text.trim() == '') {
      return Toast.toast(context, '请输入身份证号');
    }
    if(phoneController.text.trim() == '') {
      return Toast.toast(context, '请输入手机号');
    }
    if(codeController.text.trim() == '') {
      return Toast.toast(context, '请输入验证码');
    }
    _addBankCard();
  }
  _addBankCard() {
    Map<String, dynamic> params = {};
    params['bankName'] = '';
    params['accountName'] =userNameController.text.trim();
    params['accountNo'] =accountController.text.trim();
    params['idCard'] =identyController.text.trim();
    params['mobile'] =phoneController.text.trim();
    params['verificationCode'] =codeController.text.trim();

    postAjax('addBankCard', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '添加成功');
        Navigator.of(context).pop('add');
      }else{
        Toast.toast(context, res['content']);
      }
    });
  }
  _getVerifyCode() {//获取手机验证码
    RegExp regM = RegExp(r'(^1[23456789]{1}\d{9}$)');//匹配手机号
    if(regM.hasMatch(phoneController.text.trim())){
      postAjax('sendBankCardVerifyCode', {'mobile':phoneController.text.trim()}, context).then((res){
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