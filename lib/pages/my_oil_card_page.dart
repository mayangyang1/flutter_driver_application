import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/service_method.dart';
import 'dart:convert';

class MyOilCardPage extends StatefulWidget {
  @override
  _MyOilCardPageState createState() => _MyOilCardPageState();
}

class _MyOilCardPageState extends State<MyOilCardPage> {
  TextEditingController oilCardController = TextEditingController();
  FocusNode oilCardFocusNode = FocusNode();
  String oilCardNo = '';
  bool enabled = false;
  @override
  void initState() { 
    super.initState();
    _getFuelCardMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的油卡信息'),),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        color: Color(0xFFF2F2F2),
        child: Column(
          children: <Widget>[
            inputOilCard('我的油卡号',oilCardController, '请输入油卡号', false, enabled, 'text',(res){
              setState(() {
               oilCardNo = res; 
              });
            }),
            Padding(child: null,padding: EdgeInsets.only(top: 30),),
            !enabled
            ? commonButton('修改',(){
                setState(() {
                  enabled = true;
                  FocusScope.of(context).requestFocus(oilCardFocusNode);
                });
             })
            : commonButton('确认保存',(){
  
               _setFuelCardMessage();
              
             }),
            
          ],
        ),
      ),
    );
  }
  Widget inputOilCard(String title, TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change){
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text(title),
          Expanded(
            child:  _inputWidget(controller, hintText, obscureText,enabled, inputType,change),
          )
        ],
      ),
    );
  }
  Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change){
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
        enabled: enabled,
        focusNode: oilCardFocusNode,
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
         margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
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
  _getFuelCardMessage()async {//获取油卡信息
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getAjax('selfInfo', '', context).then((res){
      if(res['code'] == 200) {
        prefs.setString('selfObj', json.encode(res['content']));
        setState(() {
          oilCardNo = res['content']['fuelCardNo'];
          oilCardController.text = oilCardNo;
        });
      }
    });
    
  }
  _setFuelCardMessage() {//修改油卡信息
    if(oilCardNo == '') {
      return Toast.toast(context, '请输入油卡号');
    }
    Map<String, dynamic> params = {'fuelCardNo': oilCardNo};
    postAjax('editeFuelCard', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '修改成功');
        setState(() {
          enabled = false;
          _getFuelCardMessage();
        });
      }
    });
  }
  @override
  void dispose() { 
    oilCardNo = '';
    enabled = false;
    super.dispose();
  }
}