import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../config/service_url.dart';
import '../components/show_modal.dart';
import '../mode/subscribe_line_route_mode.dart';
import '../components/city_picker.dart';
import '../components/toast.dart';

class SubscribeLineRoutePage extends StatefulWidget {
  @override
  _SubscribeLineRoutePageState createState() => _SubscribeLineRoutePageState();
}

class _SubscribeLineRoutePageState extends State<SubscribeLineRoutePage> {
  List lineRouteList = [];
  TextEditingController fromAreaController =TextEditingController();
  TextEditingController endAreaController =TextEditingController();
  String startName = '';
  String endName = '';
  String  startProvinceCode = '';
  String startCityCode = '';
  String endProvinceCode = '';
  String endCityCode = '';

  @override
  void initState() { 
    super.initState();
    _getLineRouteList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('订阅线路'),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF2F2F2),
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
              lineRoureListWidget(),
              inputArea('出发地', fromAreaController, '请选择出发地', false, false, 'number', (res){},(){
                showPicker(context,(res){
                  print(res);
                  setState(() {
                   startName = res['textValue'];
                   startProvinceCode = res['provinceCode'];
                   startCityCode = res['cityCode'];
                   fromAreaController.text = res['textValue'];
                  });
                  
                },false);
              }),
              inputArea('目的地', endAreaController, '请选择目的', false, false, 'number', (res){}, (){
                showPicker(context,(res){
                  print(res);
                  setState(() {
                   endName = res['textValue'];
                   endProvinceCode = res['provinceCode'];
                   endCityCode = res['cityCode'];
                   endAreaController.text = res['textValue'];
                  });
                },false);
              }),
              Padding(child: null,padding: EdgeInsets.only(top: 30),),
              commonButton('加入公司', (){
                _addLineRoute();
              })
            ],
          ),
        )
      ),
    );
  }
  Widget lineRoureListWidget() {
    return LimitedBox(
      maxHeight: ScreenUtil().setHeight(500),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: lineRouteList.length > 0
            ? lineRouteList.map((item){
                return lineRouteItem(item);
              }).toList()
            : [
              Container( 
                padding: EdgeInsets.only(left: 10, right:10),
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(width: 1, color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC)))
                ),
                height: ScreenUtil().setHeight(100),
                child: Center(
                  child: Text('暂未添加订阅线路',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Color(0xFF888888)),),
                )
              )
            ]
          )
        )
      ),
    );
  }
  Widget lineRouteItem(item) {
    return Container( 
      padding: EdgeInsets.only(left: 10, right:10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC)))
      ),
      height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Text(item?.loadingProvinceName != null? item.loadingProvinceName : ''),
                Text(' - '),
                Text(item?.loadingCityName != null? item.loadingCityName : ''),
                Text(' 至 '),
                Text(item?.unloadingProvinceName != null? item.unloadingProvinceName : ''),
                Text(' - '),
                Text(item?.unloadingCityName != null? item.unloadingCityName : ''),

              ],
            ),
          ),
          
          Switch(value: true,onChanged: (value){
            showMyCupertinoDialog(context, '提示', '确认要删除该订阅线路?', (res){
              if(res == 'confirm') {
                _cancelLineRoute(item?.code);
              }
            });
            
          },)
        ],
      ),
    );
  }
  Widget inputArea(String title,TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change, Function tap) {
    return InkWell(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(child: Text(title),padding: EdgeInsets.only(left: 10,top: 15,),),
            _inputWidget( controller, hintText, obscureText,enabled, inputType, change)
          ],
        ),
      ),
      onTap: tap,
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
  Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change){
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      padding: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black54),
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xFFF2F2F2)
      ),
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
  _getLineRouteList() {//获取订阅线路列表
    getAjax('resourceRouteSubscribe', '', context).then((res){
      SubScribeLineRouteMode data = SubScribeLineRouteMode.fromJson(res);
      if(data.code == 200 && data.content.length > 0) {
        setState(() {
         lineRouteList =  data.content;
        });
      }
    });
  }
  _cancelLineRoute(String code) {//取消订阅线路
    postAjaxStr('$serviceUrl/resource/resource/resource_route_subscribe/$code/delete', {}, context).then((res){
      if(res['code'] == 200) {
        _getLineRouteList();
      }
    });
  }
  _addLineRoute(){//添加订阅线路
    Map<String, dynamic> params = {};
    if(lineRouteList.length > 4) {
      return Toast.toast(context, '最多五条线路');
    }
    if(startProvinceCode == '') {
      return Toast.toast(context, '请输入出发地');
    }
    if(startCityCode == '') {
      return Toast.toast(context, '出发地选择到市');
    }
    if(endProvinceCode == '') {
      return Toast.toast(context, '请输入目的地');
    }
    if(endCityCode == '') {
      return Toast.toast(context, '目的地选择到市');
    }
    params['loadingProvinceCode'] = startProvinceCode;
    params['loadingCityCode'] = startCityCode;
    params['unloadingProvinceCode'] = endProvinceCode;
    params['unloadingCityCode'] = endCityCode;
    postAjax('addSubscribeRoure', params, context).then((res){
      if(res['code'] == 200) {
        _getLineRouteList();
        setState(() {
          startProvinceCode = '';
          startCityCode = '';
          endProvinceCode = '';
          endCityCode = '';
          startName = '';
          endName = '';
          fromAreaController.text = '';
          endAreaController.text = '';
        });
      }
    });
  }
  @override
  void dispose() {
    startProvinceCode = '';
    startCityCode = '';
    endProvinceCode = '';
    endCityCode = '';
    startName = '';
    endName = '';
    fromAreaController.text = '';
    endAreaController.text = '';
    super.dispose();
  }
}