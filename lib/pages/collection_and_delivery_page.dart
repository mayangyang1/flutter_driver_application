import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/date_picker.dart';
import '../common/fullScreenWrapper.dart';
import 'package:image_picker/image_picker.dart';
import '../common/service_method.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:amap_location/amap_location.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import '../components/toast.dart';

class CollectionAndDeliveryPage extends StatefulWidget {
  final String code;
  final num type;
  CollectionAndDeliveryPage({Key key, this.code, this.type}):super(key:key);
  @override
  _CollectionAndDeliveryPageState createState() => _CollectionAndDeliveryPageState();
}

class _CollectionAndDeliveryPageState extends State<CollectionAndDeliveryPage> {
  TextEditingController timeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String times = DateTime.now().toString().split('.')[0];
  String title = '装货';
  double latitude;
  double longitude;
  List attachments = [
    { 'resourceCode': '', 'value': 'assets/images/pic.png', 'status': 'hidden' }, 
    { 'resourceCode': '', 'value': 'assets/images/pic.png', 'status': 'hidden' },
    { 'resourceCode': '', 'value': 'assets/images/pic.png', 'status': 'hidden' }
  ];
  @override
  void initState() { 
    super.initState();
    timeController.text = times;
    widget.type == 0? title = '装货': title = '卸货';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              textContent(),
              imageContent(),
              Padding(child: null,padding: EdgeInsets.only(top: 60)),
              commonButton('确认', 'mainColor',(){
                _bindOperation();
              }),
              commonButton('取消', '', (){
                Navigator.of(context).pop();
              })
            ],
          ),
        )
      )
    );
  }
  Widget textContent() {
    return Container(
      child: Column(
        children: <Widget>[
          textItem('$title时间',timeController, '', false, false, 'number',(res){}, (){
            dataPicker(context, times, (res){
              setState(() {
               times = res;
               timeController.text = times; 
              });
            });
          },''),
          textItem('$title重量',weightController, '请输入装货重量', false, true, 'number',(res){
            weightController.text = res.trim();
          }, (){}, '吨'),
          textItem('$title体积',volumeController, '请输入装货体积', false, true, 'number',(res){
            volumeController.text = res.trim();
          }, (){}, '方'),
          textItem('$title数量',numberController, '请输入装货数量', false, true, 'number',(res){
            numberController.text = res.trim();
          }, (){}, '件'),
        ],
      ),
    );
  }
  Widget textItem(String title, TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change, Function onTap, String unit) {
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
            // Text('*',style: TextStyle(color: Colors.red),),
            Container(
              width: ScreenUtil().setWidth(140),
              child: Text(title,style: TextStyle(fontSize: ScreenUtil().setWidth(32)),),
            ),
            Expanded(
              child: _inputWidget(controller, hintText, obscureText, enabled, inputType, change),
            ),
            unit == ''
            ? Image.asset('assets/images/arrow.png',width: ScreenUtil().setWidth(20),)
            : Text(unit,style: TextStyle(fontSize: ScreenUtil().setWidth(30)),)

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

  Widget imageContent(){
    return Container(
      padding: EdgeInsets.only(left: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(child:null,padding: EdgeInsets.only(top: 10),),
          Text('上传$title凭证',style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
          Padding(child:null,padding: EdgeInsets.only(top: 10),),
          Row(
            children: <Widget>[
              upLoadeImage(0),
              upLoadeImage(1),
              upLoadeImage(2),
            ],
          )
        ],
      ),
    );
  }
  Widget upLoadeImage(int index) {
    return Container(
      margin: EdgeInsets.only(right:15),
      child: Column(
        children: <Widget>[
          attachments[index]['status'] == 'hidden'
          ? InkWell(
              child: Image.asset( attachments[index]['value'],width: ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(200),fit: BoxFit.fill,),
              onTap: (){
                 getImage( index);
              },
            )
          :Stack(
            children: <Widget>[
              InkWell(
                child: Image.network( attachments[index]['value'],width: ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(200),fit: BoxFit.fill,),
                onTap: (){
                  _previewImage( index);
                },
              ),
              Positioned(
                child: InkWell(
                  child: Image.asset('assets/images/btn_delete_photo.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),),
                  onTap: (){
                  _closeImage(index);
                  },
                ),
                top: 0,
                right: 0,
              )
            ],
          ),
          Padding(child: null,padding: EdgeInsets.only(top: 10)),
          Text('装货凭证')
        ],
      ),
    );
  }
  Future getImage(int index) async {//上传图片
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    FormData formData =FormData.from({
      "file": new UploadFileInfo(image, 'upload-image') 
    });
    uploaFile('updateImage', formData, context).then((res){
      if(res['code'] == 200) {
        String imageUrl = res['content']['thumbnailList'][0]['url'];
        String resourceCode = res['content']['resourceCode'];
        setState(() {
          attachments[index]['value'] =  imageUrl;
          attachments[index]['resourceCode'] =  resourceCode;
          attachments[index]['status'] =  'show';
        });
        print('上传成功');
        print(res['content']);
      }
    });
  } 
  _closeImage(int index) {//删除已经上传的图片
    setState(() {
       attachments[index]['value'] =  'assets/images/pic.png';
       attachments[index]['resourceCode'] =  '';
       attachments[index]['status'] =  'hidden';
    });
  }
  _previewImage(int index) {//预览图片
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return FullScreenWrapper(
        imageProvider:  NetworkImage(
           attachments[index]['value']
        )
      );
    }));
  }
  Widget commonButton(String title, String color, Function success) {
    return InkWell(
      child: Container(
         margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(90),
        decoration: BoxDecoration(
          color: color == 'mainColor'? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(5),
         border: color == 'mainColor'?  Border.all(width: 0, color: Colors.transparent): Border.all(width: 1, color: Color(0xFFDDDDDD))
        ),
        child: Center(
          child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(32),color: color == 'mainColor'? Colors.white :Color(0xFF454545)),),
        ),
      ),
      onTap: success,
    );
  }
  _getLocation(String resourceCodeString)async {//获取经纬度
    await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));

    // bool hasPermission = await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
    // if (!hasPermission) {
    //   PermissionStatus requestPermissionResult =
    //       await SimplePermissions.requestPermission(
    //           Permission.WhenInUseLocation);
    //   if (requestPermissionResult != PermissionStatus.authorized) {
    //     Toast.toast(context, "申请定位权限失败");
    //     return;
    //   }
    // }

   AMapLocation _loc =  await AMapLocationClient.getLocation(false);//true 获取详细地址 false不获取地址
    if(_loc.isSuccess()) {
      // if(_loc.hasAddress()) {//需要获取详细地址时起效果
        // print('获取经纬度');
        // print('${_loc.latitude}and ${_loc.longitude}');
        //获取地址 ${loc.formattedAddress} 城市:${loc.city} 省:${loc.province}
      // }
      latitude = _loc.latitude;
      longitude = _loc.longitude;

      if(widget.type == 0) {//装货
        _collectionGoods(resourceCodeString);
      }else{//卸货
        _deliveryGoods(resourceCodeString);
      }
      
    }else{
      return Toast.toast(context, '该应用没有开启定位权限 请先开启定位权限设置');
    }

  }
  _collectionGoods(String loadingAttachment) {//装货
    Map<String, dynamic> params = {};
    params['loadingTime'] = times;
    params['loadingGoodsWeight'] = weightController.text;
    params['loadingGoodsVolume'] = volumeController.text;
    params['loadingGoodsNum'] = numberController.text;
    params['code'] = widget.code;
    params['loadingAttachment'] = loadingAttachment;
    params['loadingAddrLon'] = longitude;
    params['loadingAddrLat'] = latitude;
    postAjax('waybillLoading', params, context).then((res){
      if(res['code'] == 200) {
        Navigator.of(context).pop('loading');
      }
    });
  }
  _deliveryGoods(String loadingAttachment) {//卸货
    Map<String, dynamic> params = {};
    params['unloadingTime'] = times;
    params['unloadingGoodsWeight'] = weightController.text;
    params['unloadingGoodsVolume'] = volumeController.text;
    params['unloadingGoodsNum'] = numberController.text;
    params['code'] = widget.code;
    params['unloadingAttachment'] = loadingAttachment;
    params['unloadingAddrLon'] = longitude;
    params['unloadingAddrLat'] = latitude;
    postAjax('waybillUnloading', params, context).then((res){
      if(res['code'] == 200) {
        Navigator.of(context).pop('unloading');
      }
    });
  }
  _bindOperation() {//操作收发货
    var resourceCode = [];
    attachments.forEach((item){
      var code = item['resourceCode'];
      if(code != ''){
        resourceCode.add(code);
      }
    });
    if(resourceCode.length == 0){
      return  Toast.toast(context, '请上传图片');
    }
    String resourceCodeString = resourceCode.join(':');
    _getLocation(resourceCodeString);
    

  }
  @override
  void dispose() {
    AMapLocationClient.stopLocation();
    AMapLocationClient.shutdown();
    times = null;
    latitude = null;
    longitude = null;
    attachments = [];
    super.dispose();
  }
}