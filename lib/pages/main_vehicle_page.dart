import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../common/util.dart';
import '../config/service_url.dart';
import '../components/single_picker.dart';
import '../components/toast.dart';
import '../components/show_modal.dart';

class MainVehiclePage extends StatefulWidget {
  @override
  _MainVehiclePageState createState() => _MainVehiclePageState();
}

class _MainVehiclePageState extends State<MainVehiclePage> {
  TextEditingController carNumberController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController carLengthController = TextEditingController();
  TextEditingController carWeigthController = TextEditingController();
  TextEditingController powerTypeController = TextEditingController();
  TextEditingController numberTypeController = TextEditingController();
  TextEditingController transportNumberController = TextEditingController();
  List attachList =['driveringOne', 'driveringTwo', 'transportLicenseRecourseCodeOne', 'transportLicenseRecourseCodeTwo'];
  Map<String, Map> attachmentsObj = {
    'driveringOne': { 'name': '行驶证第一联', 'value': 'assets/images/pic.png', 'status': 'hidden', 'resourceCode': '' },
    'driveringTwo': { 'name': '行驶证第二联', 'value': 'assets/images/pic.png', 'status': 'hidden', 'resourceCode': '' },
    'transportLicenseRecourseCodeOne': { 'name': '运输证第一联', 'value': 'assets/images/pic.png', 'status': 'hidden', 'resourceCode': '' },
    'transportLicenseRecourseCodeTwo': { 'name': '运输证第二联', 'value': 'assets/images/pic.png', 'status': 'hidden', 'resourceCode': '' },
  };
  List<Map> truckModelList = [
    {'id': 'H01', 'key': '普通货车'},
    {'id': 'H02', 'key': '厢式货车'},
    {'id': 'H04', 'key': '罐式货车'},
    {'id': 'Q00', 'key': '牵引车'},
    {'id': 'G01', 'key': '普通挂车'},
    {'id': 'G03', 'key': '罐式挂车'},
    {'id': 'G05', 'key': '集装箱挂车'},
    {'id': 'H09', 'key': '仓栅式货车'},
    {'id': 'H03', 'key': '封闭货车'},
    {'id': 'H05', 'key': '平板货车'},
    {'id': 'H06', 'key': '集装箱车'},
    {'id': 'H07', 'key': '自卸货车'},
    {'id': 'H08', 'key': '特殊结构货车'},
    {'id': 'Z00', 'key': '专项作业车'},
    {'id': 'G02', 'key': '厢式挂车'},
    {'id': 'G07', 'key': '仓栅式挂车'},
    {'id': 'G04', 'key': '平板挂车'},
    {'id': 'G06', 'key': '自卸挂车'},
    {'id': 'G09', 'key': '专项作业挂车'},
    {'id': 'X91', 'key': '车辆运输车'},
    {'id': 'X92', 'key': '车辆运输车（单排）'},
  ];
  List<Map> powerTypeList = [
    {'key': '气车', 'id': 'gas'},
    {'key': '油车', 'id': 'oil'},
  ];
  List<Map> licensePlateList = [
    {'key': '大型汽车号牌', 'id': '01'},
    {'key': '小型汽车号牌', 'id': '02'},
    {'key': '其他号牌', 'id': '99'},
  ];
  int licensePlateIndex = 0;
  int powerTypeIndex = 0;
  int truckModeIndex = 0;
  bool canEdite = true;
  Map<String, dynamic> mainTruckObj = {};
  String truckModelCode = ''; //车型
  String powerType = '';//动力类型
  String truckLicenseType = ''; //牌照类型
  int attachIndex = 0;
  String code = '';//主车code
  @override
  void initState() { 
    super.initState();
    _getMainTruckMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('车辆/主车信息'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              textMessageList(),
              imageMessageList(),
              Padding(child: null,padding: EdgeInsets.only(top:20),),
              canEdite
              ? commonButton('暂存', (){
                  _saveMainVehicleMessage();
                })
              :Padding(child: null,padding: EdgeInsets.only(top: 0),),
              canEdite
              ? commonButton('提交认证',(){
                 _verifyMainVehicleMessage();
               })
              : Padding(child: null,padding: EdgeInsets.only(top: 0),),
              Padding(child: null,padding: EdgeInsets.only(top:20),),
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
          itemMessage('车牌号',carNumberController, '请输入车牌号', false, canEdite, 'text',(res){
            if(res.trim().length == 7) {
              _searchTruckLiceseNo(res.trim());
            }
          },(){}),
          itemMessage('车型',carTypeController, '请选择车型', false, false, 'text',(){},(){
            if(canEdite) {
              singlePicker(context, truckModelList, truckModeIndex, (res){
                if(res['key'] == 'confirm') {
                  carTypeController.text = truckModelList[res['value']]['key'];
                  truckModeIndex = res['value'];
                  truckModelCode = truckModelList[res['value']]['id'];
                }
              });
            }
          }),
          itemMessage('车长',carLengthController, '请输入车长', false, canEdite, 'number',(){},(){}),
          itemMessage('载重',carWeigthController, '请输入载重', false, canEdite, 'text',(){},(){}),
          itemMessage('动力类型',powerTypeController, '请选择动力类型', false, false, 'text',(){},(){
            if(canEdite) {
              singlePicker(context, powerTypeList, powerTypeIndex, (res){
                if(res['key'] == 'confirm') {
                  powerTypeController.text = powerTypeList[res['value']]['key'];
                  powerTypeIndex = res['value'];
                  powerType =  powerTypeList[res['value']]['id'];
                }
              });
            }
          }),
          itemMessage('牌照类型',numberTypeController, '请选择牌照类型', false, false, 'text',(){},(){
            if(canEdite) {
              singlePicker(context, licensePlateList, licensePlateIndex, (res){
                if(res['key'] == 'confirm') {
                  numberTypeController.text = licensePlateList[res['value']]['key'];
                  licensePlateIndex = res['value'];
                  truckLicenseType = licensePlateList[res['value']]['id'];
                }
              });
            }
          }),
          itemMessage('运输证号',transportNumberController, '请输入运输证号', false, canEdite, 'text',(){},(){}),
        ],
      ),
    );
  }
  Widget itemMessage(String title, TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change, Function onTap) {
    return InkWell(
      child: Container(
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
      ),
      onTap: onTap,
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
          itemImageMessage('行驶证',1),
          itemImageMessage('道路运输证', 2),
        ],
      ),
    );
  }
  Widget itemImageMessage(String title, int type) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(child: Text(title,),padding: EdgeInsets.fromLTRB(10, 10, 10, 10),),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(width: 1, color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC)))
            ),
            child: Row(
              children: showType(type)
            ),
          )
        ],
      ),
    );
  }
  Widget upLoadeImage(String typeName) {
    return Container(
      margin: EdgeInsets.only(right:20),
      child: Column(
        children: <Widget>[
          attachmentsObj[typeName]['status'] == 'hidden'
          ? InkWell(
              child: Image.asset(attachmentsObj[typeName]['value'],width: ScreenUtil().setWidth(240),height: ScreenUtil().setHeight(240),fit: BoxFit.fill,),
              onTap: (){
                getImage(typeName);
              },
            )
          :Stack(
            children: <Widget>[
              InkWell(
                child: Image.network(attachmentsObj[typeName]['value'],width: ScreenUtil().setWidth(240),height: ScreenUtil().setHeight(240),fit: BoxFit.fill,),
                onTap: (){
                  _previewImage(typeName);
                },
              ),
              canEdite
              ? Positioned(
                  child: InkWell(
                    child: Image.asset('assets/images/btn_delete_photo.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),),
                    onTap: (){
                    _closeImage(typeName);
                    },
                  ),
                  top: 0,
                  right: 0,
                )
              :Padding(child: null,padding: EdgeInsets.only(top: 0)),
            ],
          ),
          Padding(child: null,padding: EdgeInsets.only(top: 10)),
          Text(attachmentsObj[typeName]['name'])
        ],
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
  showType(int type) {
    if(type == 1) {//身份证
      return <Widget>[
        upLoadeImage('driveringOne'),
        upLoadeImage('driveringTwo'),
      ];
    }else{//驾驶证
      return <Widget>[
        upLoadeImage('transportLicenseRecourseCodeOne'),
        upLoadeImage('transportLicenseRecourseCodeTwo'),
      ];
    }
  }
  Future getImage(String typeName) async {//上传图片
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    FormData formData =FormData.from({
      "file": new UploadFileInfo(image, 'upload-image') 
    });
    uploaFile('updateImage', formData, context).then((res){
      if(res['code'] == 200) {
        String imageUrl = res['content']['thumbnailList'][0]['url'];
        String resourceCode = res['content']['resourceCode'];
        setState(() {
         attachmentsObj[typeName]['value'] =  imageUrl;
         attachmentsObj[typeName]['resourceCode'] =  resourceCode;
         attachmentsObj[typeName]['status'] =  'show';
        });
        print('上传成功');
        print(res['content']);
      }
    });
  } 
  _closeImage(String typeName) {//删除已经上传的图片
    setState(() {
      attachmentsObj[typeName]['value'] =  'assets/images/pic.png';
      attachmentsObj[typeName]['resourceCode'] =  '';
      attachmentsObj[typeName]['status'] =  'hidden';
    });
  }
  _previewImage(String typeName) {//预览图片
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return FullScreenWrapper(
        imageProvider:  NetworkImage(
          attachmentsObj[typeName]['value']
        )
      );
    }));
  }
  _getMainTruckMessage() {//获取车辆信息
    getAjax('mainTruckMessage', '?size=1', context).then((res){
      if(res['code'] == 200 && res['content'].length > 0) {
        mainTruckObj = res['content'][0];

        for(var i=0; i<truckModelList.length; i++) {
          if(truckModelList[i]['id'] == mainTruckObj['truckModelCode']){
            setState(() {
             truckModeIndex = i; 
            });
          }
        }

        for(var i=0; i<powerTypeList.length; i++) {
          if(powerTypeList[i]['id'] == mainTruckObj['powerType']){
            setState(() {
             powerTypeIndex = i; 
            });
          }
        }

        for(var i=0; i<licensePlateList.length; i++) {
          if(licensePlateList[i]['id'] == mainTruckObj['truckLicenseType']){
            setState(() {
             licensePlateIndex = i; 
            });
          }
        }

        Map truckObj = {};
        truckObj['attachmentName'] = '行驶证';
        truckObj['attachmentResourceCode'] = mainTruckObj['drivingLicenseRecourseCode'] != null? mainTruckObj['drivingLicenseRecourseCode'] : '';
        Map transportObj = {};
        transportObj['attachmentName'] = '运输证';
        transportObj['attachmentResourceCode'] = mainTruckObj['transportLicenseRecourseCode'] != null? mainTruckObj['transportLicenseRecourseCode'] : '';
        List truckAttachmentsList = [];
        truckAttachmentsList
        ..add(truckObj)
        ..add(transportObj);
        _attachment(truckAttachmentsList);

        setState(() {
         carNumberController.text = mainTruckObj['truckLicenseNo']?? '';
         carTypeController.text = mainTruckObj['truckModelName']?? '';
         carLengthController.text = mainTruckObj['truckLength'] != null? mainTruckObj['truckLength'].toString() : '';
         carWeigthController.text = mainTruckObj['regTonnage'] != null? mainTruckObj['regTonnage'].toString() : '';
         powerTypeController.text = powerTypeMap[mainTruckObj['powerType']]??'';
         numberTypeController.text = licensePlate[mainTruckObj['truckLicenseType']]?? '';
         transportNumberController.text = mainTruckObj['transportLicenseNo']?? '';
         
         canEdite = mainTruckObj['certStatus'] == 'authenticating' || mainTruckObj['certStatus'] == 'authenticated'? false : true;
        });
        truckModelCode = mainTruckObj['truckModelCode'];
        powerType = mainTruckObj['powerType'];
        truckLicenseType = mainTruckObj['truckLicenseType'];
        code =mainTruckObj['code'];
      }else{
        code = '';
      }
    });
  }
  _attachment( List attachments){//获取图片
    List arrList = attachments;
    List newArrList = [];
    arrList.forEach((_item) {
      if (_item['attachmentName'] == '行驶证') {
        List attachmentResourceCode = _item['attachmentResourceCode'].split(':');
        var cardFront = {};
        cardFront['attachmentName'] = '行驶证第一联';
        cardFront['attachmentResourceCode'] = attachmentResourceCode[0];
        newArrList.add(cardFront);
        Map cardAfter = {};
        cardAfter['attachmentName'] = '行驶证第二联';
        cardAfter['attachmentResourceCode'] = attachmentResourceCode[1];
        newArrList.add(cardAfter);
      }
      if (_item['attachmentName'] == '运输证') {
        List attachmentResourceCode = _item['attachmentResourceCode'].split(':');
        Map driverOne = {};
        driverOne['attachmentName'] = '运输证第一联';
        driverOne['attachmentResourceCode'] = attachmentResourceCode[0];
        newArrList.add(driverOne);
        Map driverTwo = {};
        driverTwo['attachmentName'] = '运输证第二联';
        driverTwo['attachmentResourceCode'] = attachmentResourceCode[1];
        newArrList.add(driverTwo);
      }
    });
    _initAttachments(newArrList);
  }
  _initAttachments (arrList) {//根据resourceCode获取图片
    if (attachIndex >= arrList.length){
     return;
    }
    var attachmentName = arrList[attachIndex]['attachmentName'];
    for (var i = 0, len = attachList.length; i < len; i++) {
      var key = attachList[i];
      if (attachmentName == attachmentsObj[key]['name']) {
        if (attachIndex >= arrList.length) return;
        var resourceCode = attachmentsObj[key]['resourceCode'] = arrList[attachIndex]['attachmentResourceCode'];
        if (resourceCode != ''){
          attachmentsObj[key]['status'] = 'show';
          getAjaxStr('$serviceUrl/person/fw/image/${arrList[attachIndex]['attachmentResourceCode']}/get', '', context).then((res){
            if(res['code'] == 200){
              List thumbnailList = res['content']['thumbnailList'];
              if(thumbnailList.length > 0) {
                setState(() {
                  attachmentsObj[key]['value'] = thumbnailList[0]['url'];
                });
              }
              attachIndex++;
              _initAttachments(arrList);
            }
          });
        }else{
          setState(() {
            attachmentsObj[key]['status'] = 'hidden';
            attachmentsObj[key]['value'] = 'assets/images/pic.png';
            attachmentsObj[key]['resourceCode'] = '';
          });
          
        }
      }
    }
    attachIndex++;
    _initAttachments(arrList);  
  }
  _saveMainVehicleMessage() {//暂存主车信息
    Map<String, dynamic> params = {};
    if(carNumberController.text == '') {
      return Toast.toast(context, '请输入车牌号');
    }
    params['truckLicenseNo'] = carNumberController.text.trim();
    params['truckModelName'] = carTypeController.text.trim();
    params['truckModelCode'] = truckModelCode;
    params['regTonnage'] = carWeigthController.text.trim();
    params['truckLicenseType'] = truckLicenseType;
    params['transportLicenseNo'] = transportNumberController.text.trim();
    params['truckLength'] = carLengthController.text.trim();
    params['powerType'] = powerType;

    List drivingLicenseRecourseCodeList = [];
    drivingLicenseRecourseCodeList
    ..add(attachmentsObj['driveringOne']['resourceCode'])
    ..add(attachmentsObj['driveringTwo']['resourceCode']);
    params['drivingLicenseRecourseCode'] = drivingLicenseRecourseCodeList.join(':');

    List transportLicenseRecourseCodeList = [];
    transportLicenseRecourseCodeList
    ..add(attachmentsObj['transportLicenseRecourseCodeOne']['resourceCode'])
    ..add(attachmentsObj['transportLicenseRecourseCodeTwo']['resourceCode']);
    params['transportLicenseRecourseCode'] = transportLicenseRecourseCodeList.join(':');

    params.forEach((key,values){
      mainTruckObj[key] = values;
      // mainTruckObj.update(key, (value)=>values);
    });
    params = mainTruckObj;
    String url = '';
    if(code == '' ) {
      url = 'truckAdd';
    }else{
      url = 'truckEdite';
    }
    postAjax(url, params, context).then((res){//暂存主车信息
      if(res['code'] == 200){
        Toast.toast(context, '暂存成功');
        Future.delayed(Duration(milliseconds: 1000),()=>Navigator.pop(context));
      }
    });
  }
  _verifyMainVehicleMessage() {//提交认证主车信息
    Map<String, dynamic> params = {};
    if(carNumberController.text == '') {
      return Toast.toast(context, '请输入车牌号');
    }
    params['truckLicenseNo'] = carNumberController.text.trim();
    params['truckModelName'] = carTypeController.text.trim();
    params['truckModelCode'] = truckModelCode;
    params['regTonnage'] = carWeigthController.text.trim();
    params['truckLicenseType'] = truckLicenseType;
    params['transportLicenseNo'] = transportNumberController.text.trim();
    params['truckLength'] = carLengthController.text.trim();
    params['powerType'] = powerType;

    List drivingLicenseRecourseCodeList = [];
    drivingLicenseRecourseCodeList
    ..add(attachmentsObj['driveringOne']['resourceCode'])
    ..add(attachmentsObj['driveringTwo']['resourceCode']);
    params['drivingLicenseRecourseCode'] = drivingLicenseRecourseCodeList.join(':');

    List transportLicenseRecourseCodeList = [];
    transportLicenseRecourseCodeList
    ..add(attachmentsObj['transportLicenseRecourseCodeOne']['resourceCode'])
    ..add(attachmentsObj['transportLicenseRecourseCodeTwo']['resourceCode']);
    params['transportLicenseRecourseCode'] = transportLicenseRecourseCodeList.join(':');

    params.forEach((key,values){
      mainTruckObj.update(key, (value)=>values);
    });
    params = mainTruckObj;
    String url = '';
    if(code == '' ) {
      url = 'truckAdd';
    }else{
      url = 'truckEdite';
    }
    
    postAjax(url, params, context).then((res){//暂存主车信息
      if(res['code'] == 200){
        code = res['content']['code'];
        postAjaxStr('$serviceUrl/driver-api/truck/$code/verify', params, context).then((res){
          if(res['code'] == 200) {
            Toast.toast(context, '认证申请成功');
            Future.delayed(Duration(milliseconds: 1000),()=>Navigator.pop(context));
          }
        });
        

      }
    });
  }
  _searchTruckLiceseNo(truckLicenseNo) {//查询车辆
    String stringParams = '?truckLicenseNo=$truckLicenseNo&size=1';
    getAjax('searchTruckInfo', stringParams, context).then((res){
      if(res['code'] == 200 && res['content'].length > 0){
        String truckCode = res['content'][0]['truckCode'];
        showMyCupertinoDialog(context, '提示', '车辆已经存在，是否直接添加', (res){
          if(res == 'confirm'){
            _rebindTruck(truckCode);
          }
        });
      }
    });
  }
  _rebindTruck(truckCode) {//绑定车辆
    postAjaxStr('$serviceUrl/driver-api/driver-api/truck/rebind/$truckCode', {'truckCode':truckCode}, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '绑定车辆成功');
        Future.delayed(Duration(milliseconds: 1000),()=>Navigator.pop(context));
      }
    });
  }
  @override
  void dispose() {
    attachmentsObj = {};
    super.dispose();
  }
}



class FullScreenWrapper extends StatelessWidget {
  const FullScreenWrapper(
      {this.imageProvider,
      this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialScale,
      this.basePosition = Alignment.center});

  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final Alignment basePosition;

  @override
  Widget build(BuildContext context) {
    return Container(
    constraints: BoxConstraints.expand(
      height: MediaQuery.of(context).size.height,
    ),
    child: PhotoView(
      imageProvider: imageProvider,
      loadingChild: loadingChild,
      backgroundDecoration: backgroundDecoration,
      minScale: minScale,
      maxScale: maxScale,
      initialScale: initialScale,
      basePosition: basePosition,
    ));
  }
}