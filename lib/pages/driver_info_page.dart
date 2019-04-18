import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../common/util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:photo_view/photo_view.dart';
import '../config/service_url.dart';
import '../components/single_picker.dart';
import '../components/toast.dart';
class DriverInfoPage extends StatefulWidget {
  @override
  _DriverInfoPageState createState() => _DriverInfoPageState();
}

class _DriverInfoPageState extends State<DriverInfoPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userSexController = TextEditingController();
  TextEditingController userIdentityController = TextEditingController();
  TextEditingController userCarTypeController = TextEditingController();
  TextEditingController userdriverNumberController = TextEditingController();
  TextEditingController userOccupationalController = TextEditingController();
  List carTypesList = carTypes;
  List<Map> carTypeList = [{'key': 'A1', 'id': 'A1'},{'key': 'A2', 'id': 'A2'},{'key': 'A3', 'id': 'A3'},{'key': 'B1', 'id': 'B1'},{'key': 'B2', 'id': 'B2'},{'key': 'C1', 'id': 'C1'},{'key': 'C2', 'id': 'C2'}];
  int carTypeIndex = 0;
  Map attachmentsObj = {};
  int attachIndex = 0;
  Map driverInfo;
  String code = '';
  List<Map> genderList = [{'key': '男', 'id': 'female'},{'key': '女', 'id': 'male'}];
  int genderIndex = 0;
  bool canEdite = false;
  @override
  void initState() { 
    attachmentsObj = attachments;
    super.initState();
    _getDriverInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('司机信息'),),
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
                  _saveDriverInfoMessage();
                })
              :Padding(child: null,padding: EdgeInsets.only(top: 0),),
              canEdite
              ? commonButton('提交认证',(){
                 _verifyDriverInfoMessage();
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
          itemMessage('姓名',userNameController, '请输入姓名', false, canEdite, 'text',(){},(){}),
          itemMessage('性别',userSexController, '请选择性别', false, false, 'text',(){},(){//点击切换性别
            if(canEdite){
              singlePicker(context, genderList, genderIndex, (res){
              if(res['key'] == 'confirm') {
                setState(() {
                  userSexController.text = genderList[res['value']]['key'];
                  genderIndex = res['value'];
                });
              }
              
            });
            }
            
          }),
          itemMessage('身份证号',userIdentityController, '请输入身份证号', false, canEdite, 'number',(){},(){}),
          itemMessage('准驾车型',userCarTypeController, '请选择准驾车型', false, false, 'text',(){},(){//点击选择准驾车型
            if(canEdite){
              singlePicker(context, carTypeList, carTypeIndex, (res){
                if(res['key'] == 'confirm') {
                  userCarTypeController.text = carTypeList[res['value']]['key'];
                  carTypeIndex = res['value'];
                }
              });
            }
              
          }),
          itemMessage('驾驶证档案编号',userdriverNumberController, '请输入驾驶证档案编号', false, canEdite, 'text',(){},(){}),
          itemMessage('从业资格证号',userOccupationalController, '请输入从业资格证号', false, canEdite, 'text',(){},(){}),
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
              width: ScreenUtil().setWidth(210),
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
          itemImageMessage('身份证', 1),
          itemImageMessage('驾驶证', 2),
          itemImageMessage('从业资格证', 3),
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
        upLoadeImage('cardFront'),
        upLoadeImage('cardAfter'),
      ];
    }else if(type == 2) {//驾驶证
      return <Widget>[
        upLoadeImage('driverOne'),
        upLoadeImage('driverTwo'),
      ];
    }else{//从业资格
      return <Widget>[
        upLoadeImage('qualificationCertificateResourceCodeOne'),
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
  _getDriverInfo() {//获取司机信息
    getAjax('selfInfo', '', context).then((res){
      if(res['code'] == 200) {
        driverInfo = res['content'];
        Map identityObj = {};
        identityObj['attachmentName'] = '身份证';
        identityObj['attachmentResourceCode'] = driverInfo['identityResourceCode'];
        Map driverLicenseObj = {};
        driverLicenseObj['attachmentName'] = '驾驶证';
        driverLicenseObj['attachmentResourceCode'] = driverInfo['driverLicenseResourceCode'];
        Map qualificationObj = {};
        qualificationObj['attachmentName'] = '从业资格证';
        qualificationObj['attachmentResourceCode'] = driverInfo['qualificationCertificateResourceCode'];
        List personAttachment = [];
        personAttachment.add(identityObj);
        personAttachment.add(driverLicenseObj);
        personAttachment.add(qualificationObj);
        _attachment(personAttachment);
        for(var i=0; i<carTypeList.length; i++) {
          if(carTypeList[i]['key'] == driverInfo['driverLicenseAcceptType']){
            setState(() {
             carTypeIndex = i; 
            });
          }
        }
        setState(() {
          userNameController.text = driverInfo['fullName'];
          userSexController.text = driverInfo['gender'] == 'female'? '男' : '女';
          genderIndex = driverInfo['gender'] == 'female'? 0 : 1;
          userIdentityController.text = driverInfo['identityNumber'];
          userCarTypeController.text = driverInfo['driverLicenseAcceptType'];
          userdriverNumberController.text = driverInfo['driverLicenseNo'];
          userOccupationalController.text = driverInfo['qualificationCertificateNumber'];
          code = driverInfo['code'];
          canEdite = driverInfo['certStatus'] == 'authenticating' || driverInfo['certStatus'] == 'authenticating'? false : true;
        });
      }
    });
  }
  _attachment( List attachments){//获取图片
    List arrList = attachments;
    List newArrList = [];
    arrList.forEach((_item) {
      if (_item['attachmentName'] == '身份证') {
        List attachmentResourceCode = _item['attachmentResourceCode'].split(':');
        var cardFront = {};
        cardFront['attachmentName'] = '身份证正面';
        cardFront['attachmentResourceCode'] = attachmentResourceCode[0];
        newArrList.add(cardFront);
        Map cardAfter = {};
        cardAfter['attachmentName'] = '身份证反面';
        cardAfter['attachmentResourceCode'] = attachmentResourceCode[1];
        newArrList.add(cardAfter);
      }
      if (_item['attachmentName'] == '驾驶证') {
        List attachmentResourceCode = _item['attachmentResourceCode'].split(':');
        Map driverOne = {};
        driverOne['attachmentName'] = '驾驶证第一联照片';
        driverOne['attachmentResourceCode'] = attachmentResourceCode[0];
        newArrList.add(driverOne);
        Map driverTwo = {};
        driverTwo['attachmentName'] = '驾驶证第二联照片';
        driverTwo['attachmentResourceCode'] = attachmentResourceCode[1];
        newArrList.add(driverTwo);
      }
      if (_item['attachmentName'] == '从业资格证') {
        List attachmentResourceCode = _item['attachmentResourceCode'].split(':');
        Map qualificationCertificateResourceCodeOne = {};
        qualificationCertificateResourceCodeOne['attachmentName'] = '从业资格证照片一';
        qualificationCertificateResourceCodeOne['attachmentResourceCode'] = attachmentResourceCode[0];
        newArrList.add(qualificationCertificateResourceCodeOne);
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
  _saveDriverInfoMessage() {//暂存司机信息
    Map<String, dynamic> params = {};
    if(userNameController.text == ''){
      return Toast.toast(context, '请输入姓名');
    }
    params['fullName'] = userNameController.text.trim();
    params['gender'] = genderIndex == 1? 'female' : 'male';
    params['identityNumber'] = userIdentityController.text.trim();
    params['driverLicenseNo'] =userdriverNumberController.text.trim();
    params['qualificationCertificateNumber'] =userOccupationalController.text.trim();
    if(userCarTypeController.text.trim() != '') {
      params['driverLicenseAcceptType'] = userCarTypeController.text.trim();
    }
    params['code'] = code;

    List identityResourceCodeList = [];
    identityResourceCodeList.add(attachmentsObj['cardFront']['resourceCode']);
    identityResourceCodeList.add(attachmentsObj['cardAfter']['resourceCode']);
    params['identityResourceCode'] = identityResourceCodeList.join(':');

    List driverLicenseResourceCodeList = [];
    driverLicenseResourceCodeList.add(attachmentsObj['driverOne']['resourceCode']);
    driverLicenseResourceCodeList.add(attachmentsObj['driverTwo']['resourceCode']);
    params['driverLicenseResourceCode'] = driverLicenseResourceCodeList.join(':');

    List qualificationCertificateResourceCodeList = [];
    qualificationCertificateResourceCodeList.add(attachmentsObj['qualificationCertificateResourceCodeOne']['resourceCode']);
    if(qualificationCertificateResourceCodeList[0] != ''){
      params['qualificationCertificateResourceCode'] = qualificationCertificateResourceCodeList.join(':');
    }else{
       params['qualificationCertificateResourceCode'] =  ':';
    }

    params.forEach((key,values){
      driverInfo.update(key, (value)=>values);
    });
    params = driverInfo;
    postAjax('personalSelfEdit', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '暂存成功');
        Future.delayed(Duration(milliseconds: 1000),(){
          return Navigator.pop(context);
        });
      }
    });

  }
  _verifyDriverInfoMessage() {//提交认证司机信息
    Map<String, dynamic> params = {};
    if(userNameController.text.trim() == '') {
      return Toast.toast(context, '请输入姓名');
    }
    if(userIdentityController.text.trim() == '') {
      return Toast.toast(context, '请输入身份证');
    }
    if(userdriverNumberController.text.trim() == '') {
      return Toast.toast(context, '请输入驾驶证档案编号');
    }
    if(userOccupationalController.text.trim() == ''){
      return Toast.toast(context, '请输入从业资格证号');
    }
    if(attachmentsObj['cardFront']['resourceCode'] == '') {
      return Toast.toast(context, '请上传身份证正面');
    }
    if(attachmentsObj['cardAfter']['resourceCode'] == '') {
      return Toast.toast(context, '请上传身份证反面');
    }
    if(attachmentsObj['driverOne']['resourceCode'] == '') {
      return Toast.toast(context, '请上传驾驶证第一联照片');
    }
    if(attachmentsObj['driverTwo']['resourceCode'] == '') {
      return Toast.toast(context, '请上传驾驶证第二联照片');
    }
    if(attachmentsObj['qualificationCertificateResourceCodeOne']['resourceCode'] == '') {
      return Toast.toast(context, '请上传从业资格证照片');
    }

    params['fullName'] = userNameController.text.trim();
    params['gender'] = genderIndex == 1? 'female' : 'male';
    params['identityNumber'] = userIdentityController.text.trim();
    params['driverLicenseNo'] =userdriverNumberController.text.trim();
    params['qualificationCertificateNumber'] =userOccupationalController.text.trim();
    // if(userCarTypeController.text.trim() != '') {
      params['driverLicenseAcceptType'] = userCarTypeController.text.trim();
    // }else{
    //   return Toast.toast(context, '')
    // }
    params['code'] = code;
    List identityResourceCodeList = [];
    identityResourceCodeList.add(attachmentsObj['cardFront']['resourceCode']);
    identityResourceCodeList.add(attachmentsObj['cardAfter']['resourceCode']);
    params['identityResourceCode'] = identityResourceCodeList.join(':');

    List driverLicenseResourceCodeList = [];
    driverLicenseResourceCodeList.add(attachmentsObj['driverOne']['resourceCode']);
    driverLicenseResourceCodeList.add(attachmentsObj['driverTwo']['resourceCode']);
    params['driverLicenseResourceCode'] = driverLicenseResourceCodeList.join(':');

    List qualificationCertificateResourceCodeList = [];
    qualificationCertificateResourceCodeList.add(attachmentsObj['qualificationCertificateResourceCodeOne']['resourceCode']);
    params['qualificationCertificateResourceCode'] = qualificationCertificateResourceCodeList.join(':');
    
    params.forEach((key,values){
      driverInfo.update(key, (value)=>values);
    });
    params = driverInfo;

    postAjax('newPersonalSelfCentry', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '提交认证成功');
        Future.delayed(Duration(milliseconds: 1000),(){
            return Navigator.pop(context);
          });
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