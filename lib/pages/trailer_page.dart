import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';

class TrailerPage extends StatefulWidget {
  @override
  _TrailerPageState createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  TextEditingController carNumberController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController carLengthController = TextEditingController();
  TextEditingController carWeigthController = TextEditingController();
  TextEditingController numberTypeController = TextEditingController();
  TextEditingController transportNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('挂车信息'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              textMessageList(),
              imageMessageList()
            ],
          ),
        )
      )
    );
  }
  Widget textMessageList () {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          itemMessage('车牌号',carNumberController, '请输入车牌号', false, true, 'text',(){}),
          itemMessage('车型',carTypeController, '请选择车型', false, false, 'text',(){}),
          itemMessage('车长',carLengthController, '请输入车长', false, true, 'number',(){}),
          itemMessage('载重',carWeigthController, '请输入载重', false, true, 'text',(){}),
          itemMessage('牌照类型',numberTypeController, '请选择牌照类型', false, false, 'text',(){}),
          itemMessage('运输证号',transportNumberController, '请输入运输证号', false, true, 'text',(){}),
        ],
      ),
    );
  }
  Widget itemMessage(String title, TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change) {
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
          Container(
            width: ScreenUtil().setWidth(180),
            child: Text(title),
          ),
          Expanded(
            child: _inputWidget(controller, hintText, obscureText, enabled, inputType, change),
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
  Widget imageMessageList() {
    return Container(
      child: Column(
        children: <Widget>[
          itemImageMessage(),
          itemImageMessage(),
          itemImageMessage(),
        ],
      ),
    );
  }
  Widget itemImageMessage() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(child: Text('行驶证',),padding: EdgeInsets.fromLTRB(10, 10, 10, 10),),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(width: 1, color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC)))
            ),
            child: Row(
              children: <Widget>[
                upLoadeImage(),

                upLoadeImage(),

              ],
            ),
          )
        ],
      ),
    );
  }
  Widget upLoadeImage() {
    return Container(
      margin: EdgeInsets.only(right:20),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Image.asset('assets/images/pic.png',width: ScreenUtil().setWidth(240),height: ScreenUtil().setHeight(240),),
          )
        ],
      ),
    );
  }
}