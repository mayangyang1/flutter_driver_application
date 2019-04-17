import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../mode/bank_card_mode.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../mode/bank_card_add_mode.dart';
import '../components/toast.dart';

class BankCardPage extends StatefulWidget {
  @override
  _BankCardPageState createState() => _BankCardPageState();
}

class _BankCardPageState extends State<BankCardPage> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  BankCardContent bankCardMessage;
  bool isEdite = false;
  @override
  void initState() { 
    super.initState();
    _getBankCardMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的银行卡'),),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFF2F2F2),
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              liItem( '我的开户行',bankNameController, '我的开户行', false, 'text', (){}),
              liItem('我的银行户名',userNameController, '我的银行户名', false, 'text', (){}),
              liItem('我的银行账户',accountNumberController, '我的银行账号', false, 'text', (){}),
              liItem('描述',descriptionController, '描述', false, 'text', (){}),
              Container(child: null,height: ScreenUtil().setHeight(100),),
              commonButton('确认保存',(){
                _setBankCardMessage();
              })
            ],
          ),
        ),
      )
    );
  }

  Widget liItem( String leadingTitle,TextEditingController controller, String hintText, bool obscureText, String inputType, Function change) {
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 10, right:10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2))),
        color: Colors.white
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(220),
            child: Text(leadingTitle,style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xFF666666)),),
          ),
          Expanded(
            flex: 1,
            child: _inputWidget(controller, hintText, obscureText,  inputType, change),
          )
        ],
      ),
    );
  }
  Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, String inputType, Function change){
    return Container(
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
  Widget commonButton(String title, Function success) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(500),
        height: ScreenUtil().setHeight(90),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Colors.white),),
        ),
      ),
      onTap: success,
    );
  }
  _getBankCardMessage() {
    getAjax('myBankCardAccount', '', context).then((res){
      BankCardMode bankCardObj =BankCardMode.fromJson(res);
      if(bankCardObj.code == 200 && bankCardObj.content.bankName != null) {
        setState(() {
          isEdite = true;
         bankCardMessage = bankCardObj.content; 
         bankNameController.text = bankCardMessage.bankName;
         userNameController.text = bankCardMessage.bankAccountName;
         accountNumberController.text = bankCardMessage.bankAccountNo;
         descriptionController.text = bankCardMessage.description;
        });
      }else{
        isEdite = false;
      }
    });
  }
  _setBankCardMessage()async {
     RegExp regM = RegExp(r'(^([\u4e00-\u9fa5]){2,7}$)');//校验中文
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map selfObj = json.decode(pref.getString('selfObj'));
    String personCode = selfObj['code'];
    String bankName = bankNameController.text.trim();
    String bankAccountName = userNameController.text.trim();
    String bankAccountNo = accountNumberController.text.trim();
    String description = descriptionController.text.trim();
    if(!regM.hasMatch(bankAccountName)) {
      return Toast.toast(context, '银行户名不正确');
    }
    if(bankAccountNo == ''){
      return Toast.toast(context, '请输入银行账号');
    }
    Map<String, dynamic> params = {};
    params['personCode'] = personCode;
    params['bankName'] = bankName;
    params['bankAccountName'] = bankAccountName;
    params['bankAccountNo'] = bankAccountNo;
    params['description'] = description;
    print(params);
    if(isEdite){
      _editeBankCardMessage(params);
    }else{
      _addBankCardMessage(params);
    }
  }
  _addBankCardMessage(Map<String, dynamic> params) {
    postAjax('myBankCardAccountAdd', params, context).then((res){
      BankCardAddMode data = BankCardAddMode.fromJson(res);
      if(data.code == 200) {
        Toast.toast(context, '新增成功');
        Future.delayed(Duration(milliseconds: 1000), (){
          return Navigator.pop(context);
        });
      }
    });
  }
  _editeBankCardMessage(Map<String, dynamic> params) {
    postAjax('myBankCardAccountEdit', params, context).then((res){
      BankCardAddMode data = BankCardAddMode.fromJson(res);
      if(data.code == 200) {
        Toast.toast(context, '编辑成功');
      }
      Future.delayed(Duration(milliseconds: 1000),()=> Navigator.pop(context));
    });
  }

  @override
  void dispose() { 
    bankCardMessage = null;
    bankNameController = null;
    userNameController = null;
    accountNumberController = null;
    descriptionController = null;
    super.dispose();
  }
}