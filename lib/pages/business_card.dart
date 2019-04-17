import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../mode/self_info_mode.dart';
import '../mode/main_truck_list_mode.dart';
import '../mode/trailer_truck_mode.dart';
import 'package:photo_view/photo_view.dart';
import '../config/service_url.dart';


class  BusinessCardPage extends StatefulWidget {
  @override
  _BusinessCardPageState createState() => _BusinessCardPageState();
}

class _BusinessCardPageState extends State<BusinessCardPage> {
  Content selfMessage ;
  TruckContent mainTruckMessage;
  TrialerTruckContent trialerTruckMessage;
  String driverStatus = '未提交认证';
  String mainTruckStatus = '未提交认证';
  String trailerTruckStatus = '未提交认证';
  bool showTrailerTruck = false;
  @override
  void initState() { 
    super.initState();
    _getSelfInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的名片'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Column(
          children: <Widget>[
            driverMessageModel(),
            mainTruckMessageModel(),
            showTrailerTruck
            ? trailerTruckMessageModel()
            : Divider(color: Colors.transparent,)
          ],
        ),
      ),
    );
  }
  Widget driverMessageModel() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
        color: Color(0xFFFFFFFF)
      ),
      child: Column(
        children: <Widget>[
          statusItem('司机', driverStatus),
          commonItem('姓名', selfMessage?.fullName, true),
          commonItem('手机',  selfMessage?.phone, true),
          ewItem('二维码名片')
        ],
      ),
    );
  }
  Widget mainTruckMessageModel() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
        color: Color(0xFFFFFFFF)
      ),
      child: Column(
        children: <Widget>[
           statusItem('主车', mainTruckStatus),
           commonItem('车牌号', mainTruckMessage?.truckLicenseNo, true),
           commonItem('车型', mainTruckMessage?.truckModelName, false)
        ],
      ),
    );
  }
  Widget trailerTruckMessageModel() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
        color: Color(0xFFFFFFFF)
      ),
      child: Column(
        children: <Widget>[
           statusItem('挂车', trailerTruckStatus),
           commonItem('车牌号', trialerTruckMessage?.truckLicenseNo, true),
           commonItem('车型', trialerTruckMessage?.truckModelName, false)
        ],
      ),
    );
  }
  Widget statusItem(String title, String status) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        border: Border(bottom: BorderSide(width:1, color: Color(0xFFCCCCCC)))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),),
          Text(status, style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),)
        ],
      ),
    );
  }
  Widget commonItem(String title, String content, bool border){
    return Container(
      height: ScreenUtil().setHeight(80),
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: border? Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2))) :Border.all(width: 0,color: Colors.transparent)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xFF454545)),),
          Row(children: <Widget>[
            Text(content != null? content : '', style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xFF454545)),),
            Text(' '),
            Image.asset('assets/images/arrow.png',width: ScreenUtil().setWidth(30),height: ScreenUtil().setHeight(30),)
          ],)
        ],
      ),
    );
  }
  Widget ewItem( String title){
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(80),
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xFF454545)),),
            Image.asset('assets/images/ewm.png',width: ScreenUtil().setWidth(70),height: ScreenUtil().setHeight(70),)
          ],
        ),
      ),
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return FullScreenWrapper(
            imageProvider:  NetworkImage(
              '${servicePath['getEWMImage']}?code=${selfMessage?.code}'
            )
          );
        }));
      }
    );
  }
  _getSelfInfo()async {//获取司机信息
    getAjax('selfInfo', '', context).then((res){
      SelfInfoMode selfObj = SelfInfoMode.fromJson(res);
      if(selfObj.code == 200) {
        String statusName = '未提交认证';
        if(selfObj.content.certStatus == 'authenticating') {
          statusName = '认证中';
        }else if (selfObj.content.certStatus == 'authenticated'){
          statusName = '已认证';
        }else{
          statusName = '未提交认证';
        }
        setState(() {
          selfMessage = selfObj.content;
          driverStatus = statusName;
        });
        _getMainTruckMessage();
      }
    });
  }
  _getMainTruckMessage() {//获取主车信息
    getAjax('mainTruckMessage', '?size=1', context).then((res){
      MainTruckListMode mainTruckInfo =MainTruckListMode.fromJson(res);
      if(mainTruckInfo.code == 200 && mainTruckInfo.content.length > 0) {
        String statusName = '未提交认证';
        if(mainTruckInfo.content[0].certStatus == 'authenticating'){
          statusName = '认证中';
        }else if(mainTruckInfo.content[0].certStatus == 'authenticated'){
          statusName = '已认证';
        }else{
          statusName = '未提交认证';
        }
        setState(() {
         mainTruckMessage =  mainTruckInfo.content[0];
         mainTruckStatus = statusName;
        });
        if(mainTruckMessage.code != null) {
          setState(() {
           showTrailerTruck = true; 
          });
          _getTrailerTruckMessage(mainTruckMessage.truckCode);
        }
      }
    });
  }
  _getTrailerTruckMessage(truckCode) {//获取挂车信息
     String stringParams = '?platformTruckCode=$truckCode';
    getAjax('trailerTruckMessage', stringParams, context).then((res){
      TrialerTruckMode trialerTruckMode = TrialerTruckMode.fromJson(res);
      if(trialerTruckMode.code == 200) {
        String statusName = '未提交认证';
        if(trialerTruckMode.content.certStatus == 'authenticating'){
          statusName = '认证中';
        }else if(trialerTruckMode.content.certStatus == 'authenticated'){
          statusName = '已认证';
        }else{
          statusName = '未提交认证';
        }
        setState(() {
         trialerTruckMessage =  trialerTruckMode.content;
         trailerTruckStatus = statusName;
        });
      }
    });
  }
  @override
  void dispose() {
    selfMessage = null;
    mainTruckMessage = null;
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