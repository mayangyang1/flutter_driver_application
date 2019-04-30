import 'package:flutter/material.dart';
import '../components/progressDialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../config/service_url.dart';
import '../mode/waybill_detail_mode.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/util.dart';
import '../common/fullScreenWrapper.dart';
import '../components/show_modal.dart';
import '../components/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class WaybillDetailPage extends StatefulWidget {
  final code;
  WaybillDetailPage({Key key, this.code});
  @override
  _WaybillDetailPageState createState() => _WaybillDetailPageState();
}

class _WaybillDetailPageState extends State<WaybillDetailPage> {
  bool _loading = false;
  WaybillDetailContent waybillDetailObj;
  List loadingImageList = [];
  List unloadingImageList = [];
  List actionList = [];
  String urlName = '';
  String urls = '';
  String firstParty = '';
  @override
  void initState() { 
    super.initState();
    _loading = true;
    _getUrlMessage();
    _getWaybillDetailInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('运单详情'),),
      body: ProgressDialog(
        loading: _loading,
        msg: '正在加载',
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(actionList.length > 0?240 : 10)),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      consignorCompany(),
                      companyMessage(),
                      commonContent(),
                    ],
                  ),
                ),
              )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                child: Column(
                  children: actionList.length > 0
                  ? _actionButtonList(actionList, widget.code)
                  : [Text('')]
                ),
              ),
            )
          ],
        )
      )
    );
  }
   Widget consignorCompany(){
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(child: Text('托运运单方: ',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Color(0xFF666666)),),),
          Text(waybillDetailObj?.consignOrgName !=null? waybillDetailObj.consignOrgName : '',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Color(0xFF666666)),)
        ],
      )
    );
  }
  Widget companyMessage(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            left: 25,
            child: Container(
              height: ScreenUtil().setHeight(240),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
              ),
              child: Text(''),
            ),
          ),
          Column(
            children: <Widget>[
              commonItem('assets/images/f.png',waybillDetailObj?.loadingProvinceName !=null? '${waybillDetailObj.loadingProvinceName} ${waybillDetailObj.loadingCityName} ${waybillDetailObj.loadingCountyName}' : '', waybillDetailObj?.loadingAddr, waybillDetailObj?.loadingOrgName, waybillDetailObj?.loadingUserFullName != null?'${waybillDetailObj.loadingUserFullName} ${waybillDetailObj.loadingUserPhone}' : '' ,waybillDetailObj?.loadingUserPhone),
              Padding(child: Divider(),padding: EdgeInsets.only(left: 40),),
              commonItem('assets/images/z.png', waybillDetailObj?.unloadingProvinceName !=null?'${waybillDetailObj.unloadingProvinceName} ${waybillDetailObj.unloadingCityName} ${waybillDetailObj.unloadingCountyName}' : '', waybillDetailObj?.unloadingAddr, waybillDetailObj?.unloadingOrgName, waybillDetailObj?.unloadingUserFullName != null?'${waybillDetailObj.unloadingUserFullName} ${waybillDetailObj.unloadingUserPhone}' : '',waybillDetailObj?.unloadingUserPhone),
            ],
          ),
          Positioned(
            top: 10,
            right: 0,
            child: waybillDetailObj?.waybillStatus != null && (waybillDetailObj.waybillStatus =='unloading' || waybillDetailObj?.waybillStatus == 'going' || waybillDetailObj?.waybillStatus == 'finish')
            ? Image.asset(_statusImage(waybillDetailObj?.waybillStatus),width: ScreenUtil().setWidth(180),)
            : Text(''),
          ),
          
        ],
      ),
    );
  }
  Widget commonItem(String imageUrl, String cityName, String adress, String companyName, String userName, String phone){
    return LimitedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(250),
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: Image.asset(imageUrl,width: ScreenUtil().setWidth(60),),
              padding: EdgeInsets.only(right: 5,top: 10)
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(cityName !=null? cityName : '',style: TextStyle(height: 1.7,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(30)),),
                      Text(adress !=null? adress : '',style: TextStyle(height: 1.5),),
                      Text(companyName !=null? companyName : '',style: TextStyle(height: 1.5),),
                      Text(userName !=null? userName : '',style: TextStyle(height: 1.5),)
                    ],
                  ),
                  InkWell(
                    child: Image.asset('assets/images/phone.png',width:ScreenUtil().setWidth(60)),
                    onTap: (){
                      _launchURL(phone);
                    },
                  )
                  
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
  Widget commonButton(String title,String color, Function onTap) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          color: color == 'mainColor'? Theme.of(context).primaryColor : Colors.white,
          border: color == 'mainColor'? Border.all(width: 0) :  Border.all(width: 1,color: Color(0xFFCCCCCC)),
          borderRadius: BorderRadius.circular(5)
        ),
        width: MediaQuery.of(context).size.width-20,
        margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
        child: Center(
          child: Text(title,style: TextStyle(color: color == 'mainColor'? Colors.white : Color(0xFF454545),),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
   Widget commonContent(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          headerTitle('基本信息'),
          contentList(),
          headerTitle('收发信息'),
          sendInformation(),
          receiveInformation(),
          erCode()
        ],
      ),
    );
  }
  Widget headerTitle(String title) {
    return Container(
      color: Color(0xFFF2F2F2),
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.only(left: 10),
      child: Text(title,style: TextStyle(height: 2),),
    );
  }
  Widget contentList() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),

      ),
      child: Column(
        children: <Widget>[
          contentLi('运单号', waybillDetailObj?.waybillNo),
          contentLi('车牌号',waybillDetailObj?.truckLicenseNo),
          contentLi('运价', waybillDetailObj?.driverPrice != null?'${waybillDetailObj.driverPrice}${unit[waybillDetailObj.meterageType]['driver.price'][waybillDetailObj.driverPriceUnitCode]}': ''),
          contentLi('货物', waybillDetailObj?.goodsName),
          contentLi('原始客户', waybillDetailObj?.originalConsignOrgName)
        ],
      ),
    );
  }
  Widget sendInformation(){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),

      ),
      child: Column(
        children: <Widget>[
          contentLi('发货时间',waybillDetailObj?.loadingTime),
          contentLi('发货重量',waybillDetailObj?.loadingGoodsWeight),
          contentLi('发货体积', waybillDetailObj?.loadingGoodsVolume),
          contentLi('发货件数',waybillDetailObj?.loadingGoodsNum),
          Container(
            height: ScreenUtil().setHeight(120),
            child: Row(
              children: <Widget>[
                Container(child: Text('发货凭证',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),),width: ScreenUtil().setWidth(200)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: loadingImageList.length > 0
                    ? loadingImageList.map((item){
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Image.network(item,width:ScreenUtil().setWidth(100),fit: BoxFit.fill,),
                          ),
                          onTap: (){
                            _previewImage(item);
                          },
                        );
                      }).toList()
                   : <Widget>[
                     
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  
  Widget receiveInformation(){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),

      ),
      child: Column(
        children: <Widget>[
          contentLi('收货时间',waybillDetailObj?.unloadingTime),
          contentLi('收货重量',waybillDetailObj?.unloadingGoodsWeight),
          contentLi('收货体积', waybillDetailObj?.unloadingGoodsVolume),
          contentLi('收货件数',waybillDetailObj?.unloadingGoodsNum),
           Container(
            height: ScreenUtil().setHeight(120),
            child: Row(
              children: <Widget>[
                Container(child: Text('收货凭证',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),),width: ScreenUtil().setWidth(200)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: unloadingImageList.length > 0
                    ? unloadingImageList.map((item){
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Image.network(item,width:ScreenUtil().setWidth(100),fit: BoxFit.fill,),
                          ),
                          onTap: (){
                            _previewImage(item);
                          },
                        );  
                      }).toList()
                   : <Widget>[
                     
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget contentLi(title, dynamic value){
    return Container(
      height: ScreenUtil().setHeight(50),
      child: Row(
        children: <Widget>[
          Container(child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),),width: ScreenUtil().setWidth(200)),
          Text(value !=null? value.toString(): '',style: TextStyle(fontSize: ScreenUtil().setSp(30)),)
        ],
      ),
    );
  }
  Widget erCode(){
    return Container(
      padding: EdgeInsets.only(top: 30,bottom: 10),
      margin: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            waybillDetailObj?.waybillNo != null
            ?Image.network('$serviceUrl/driver-api/driver-api/generate_qr_code/string?value=${waybillDetailObj.waybillNo}',width: ScreenUtil().setWidth(400),)
            : Text(''),
            Text('扫描二维码读取运单号',style: TextStyle(fontSize: ScreenUtil().setSp(36),fontWeight: FontWeight.bold,))
          ],
        ),
      ),
    );
  }
  _previewImage(String url) {//预览图片
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return FullScreenWrapper(
        imageProvider:  NetworkImage(
          url
        )
      );
    }));
  }
  void _launchURL(contactPhone) async {//拨打电话
    String url = 'tel:' + contactPhone;
    if(await canLaunch(url)) {
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  _statusImage(status){
    if(status == 'unloading'){
      return 'assets/images/waitingLoading.png';
    }else if(status == 'going'){
      return 'assets/images/going.png';
    }else if(status == 'finish'){
      return 'assets/images/finish.png';
    }else{
      return '';
    }
  }
  _getWaybillDetailInfo(){//获取运单详情
    getAjaxStr('$serviceUrl/driver-api/driver-api/waybill/detail/${widget.code}', '', context).then((res){
      setState(() {
       _loading = false; 
      });
      WaybillDetailPageMode data = WaybillDetailPageMode.fromJson(res);
      if(data.code == 200){
        if(data.content?.loadingAttachment != null){
          List loadingList = data.content.loadingAttachment.split(':');
          loadingList.forEach((item){
            _getImageUrl(item, 'loading');
          });
        }
        if(data.content?.unloadingAttachment != null){
          List unloadingList = data.content.unloadingAttachment.split(':');
          unloadingList.forEach((item){
            _getImageUrl(item, 'unloading');
          });
        }
        _getActionList(widget.code);
        
        setState(() {
         waybillDetailObj = data.content; 
        });
      }
    });
  }
  _getUrlMessage()async{//跳到第三方域名
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map otherCofig =json.decode(prefs.getString('otherConfig'));
    setState(() {
    urlName =  otherCofig['other.statement.driverAgreementName'];
    urls = otherCofig['other.statement.driverAgreementUrl'];
    firstParty =otherCofig['coreOrgFullName'];
    });
  }
  _getImageUrl(String code, String type) {//获取图片地址
    getAjaxStr('$serviceUrl/waybill/fw/image/$code/get', '', context).then((res){
      if(res['code'] == 200 && res['content']['resourceCode'] != '') {
        print(res['content']['thumbnailList'][0]['url']);
        if(type == 'loading'){//发货
          setState(() {
            loadingImageList.add(res['content']['thumbnailList'][0]['url']);
          });
        }else {//收货
          setState(() {
           unloadingImageList.add(res['content']['thumbnailList'][0]['url']); 
          });
        }
      }
    });
  }
  _getActionList(code){//获取业务动作
    Map<String ,dynamic> params = {};
    params['type'] = 'driverApi';
    params['businessCodeList'] = code;
    postAjax('actionList', params, context).then((res){
      if(res['code'] == 200 && res['content'][code] is List) {
        print(res['content'][code]);
        setState(() {
          actionList = res['content'][code]; 
        });
      }
    });
  }
  _actionButtonList(List actionList, String code,) {
    List<Widget> buttonlist = [];
    actionList.forEach((item){
      if(item['actionCode'] == 'waybillDriverCancel' ||  item['actionCode'] == 'waybillDriverReject' ){
        buttonlist.add(commonButton(item['actionName'], 'default', (){
          if(item['actionCode'] == 'waybillDriverCancel'){
            _bindCancelWaybill(code);
          }
          if(item['actionCode'] == 'waybillDriverReject'){
            _bindRefuseWaybill(code);
          }
        }));
      }else{
        if(item['actionCode'] == 'waybillDriverLoading'){//装货
         buttonlist.insert(0,commonButton('装货', 'mainColor', (){}));
        }
        if(item['actionCode'] == 'waybillDriverUnloading'){//卸货
         buttonlist.insert(0,commonButton('装货', 'mainColor', (){}));
        }
        if(item['actionCode'] == 'waybillDriverAccept'){//确认运单
          buttonlist.insert(0,commonButton('确认运单', 'mainColor', (){
            showRecpitDialog(context,waybillDetailObj?.scheduleType == 'platform'? true : false, false,waybillDetailObj?.truckLicenseNo, waybillDetailObj?.goodsName, waybillDetailObj?.driverPrice !=null? '${waybillDetailObj.driverPrice}${unit[waybillDetailObj.meterageType]['driver.price'][waybillDetailObj.driverPriceUnitCode]}': '', waybillDetailObj?.originalConsignOrgName,urlName,'$urls?firstParty=$firstParty&secondParty=${waybillDetailObj?.driverFullName}&idNumber=${waybillDetailObj?.driverIdentityNumber}&phoneNumber=${waybillDetailObj?.driverPhone}',(res){
              if(res['key'] == 'confirm'){
                 _bindWaybillAccept(code);
              }
            });
           
          }));
        }        
      }      
    });
    return buttonlist;
  }
  _bindWaybillAccept(code) {//确认运单
    setState(() {
     _loading = true; 
    });
    var times =DateTime.now().toString().split('.')[0];
    print(times);
    Map<String, dynamic> params = {};
    params['code'] = code;
    params['driverConfirmTime'] = times;
    postAjax('waybillAccepy', params, context).then((res){
      _loading = false;
      if(res['code'] == 200) {
        setState(() {
          _loading = true;
        });
        waybillDetailObj = null;
        _getWaybillDetailInfo();
      }
    });
  }
  _bindRefuseWaybill(code){//拒绝运单
    showMyCupertinoDialog(context, '提示', '确认要拒绝该运单吗?', (res){
      if(res == 'confirm'){
          setState(() {
        _loading = true; 
        });
        var times =DateTime.now().toString().split('.')[0];
        Map<String, dynamic> params = {};
        params['code'] = code;
        params['driverConfirmTime'] =  times;
        postAjax('waybillRefuse', params, context).then((res){
          _loading = false;
          if(res['code'] == 200) {
            waybillDetailObj = null;
           _getWaybillDetailInfo();
          }
        });
      }
    });
    
  }
  _bindCancelWaybill(code) {//取消运单
    showMyCupertinoDialog(context, '提示', '确认要取消该运单吗?', (res){
      if(res == 'confirm'){
            setState(() {
          _loading = true; 
        });
        var times =DateTime.now().toString().split('.')[0];
        Map<String, dynamic> params = {};
        params['code'] = code;
        params['driverConfirmTime'] = times;
        postAjax('waybillCancel', params, context).then((res){
          _loading = false;
          if(res['code'] == 200) {
            waybillDetailObj = null;
            _getWaybillDetailInfo();
          }
        });
      }
    });
    
  }
  @override
  void dispose() {
    waybillDetailObj = null;
    loadingImageList = [];
    unloadingImageList = [];
    actionList = [];
    super.dispose();
  }
}

showRecpitDialog(BuildContext context, bool showAgreement, bool isAgreement, String truckLengthNo, String goods, String price, String company, String urlName, String urls, Function success) {
  showDialog(
  context: context,
  builder: (context) {
    return new SimpleDialog(
      title: Container(
        padding: EdgeInsets.all(14),
        color: Theme.of(context).primaryColor,
        child: Center(child: Text('确认运单',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.white),),),
      ),
      titlePadding: EdgeInsets.all(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      backgroundColor: Colors.white,
      children: <Widget>[
        titleLi('车  牌  号', truckLengthNo),
        titleLi('货        物', goods),
        titleLi('司机运价', price),
        titleLi('原始客户', company),
        Divider(),
        Text('点击 确认 后, 您跟平台之间的协议将立即生效', style: TextStyle(color: Colors.red),),
        showAgreement
        ?Container(
          height: ScreenUtil().setHeight(60),
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Row(
                children: <Widget>[
                  Checkbox(
                    value: isAgreement,
                    onChanged: (res){
                      print(res);
                      setState((){
                        isAgreement = !isAgreement;
                      });
                      print(isAgreement);
                    },
                  ),
                  Text('同意'),
                  InkWell(
                    child: Text('<<$urlName>>',style: TextStyle(color: Theme.of(context).primaryColor),),
                    onTap: ()async{
                      String url = urls;
                      if(await canLaunch(url)) {
                        await launch(url);
                      }else{
                        throw 'Could not launch $url';
                      }
                      
                    },
                  )
                  
                ],
              );
            },
          ),
        )
        : Padding(child: null,padding: EdgeInsets.only(left: 1),),
        Divider(),
        Container(
          height: ScreenUtil().setHeight(80),
          child: Row(
            children: <Widget>[
              Expanded(
                 child: InkWell(
                   child: Container(
                     decoration: BoxDecoration(
                       border: Border.all(width: 1,color: Color(0xFFF2F2F2))
                     ),
                     child: Center(
                       child: Text('取消'),
                     ),
                   ),
                   onTap: (){
                     Navigator.of(context).pop("点击了取消");
                      success({'key': 'cancel'}); 
                   },
                 )
              ),
              Padding(child: null,padding: EdgeInsets.only(left: 10)),
              Expanded(
                 child: InkWell(
                   child: Container(
                    color: Theme.of(context).primaryColor,
                      child: Center(
                       child: Text('确认',style: TextStyle(color: Colors.white),),
                     ),
                   ),
                   onTap: (){
                     if(showAgreement && isAgreement == false){
                      return Toast.toast(context, '请同意协议');
                     }
                     Navigator.of(context).pop("点击了确定");
                     var result = {};
                     result['key'] = 'confirm';
                     success(result);  
                   },
                 )
              )
            ],
          ),
        )
      ],
    );
  });
}
Widget titleLi( String title, value){
  return Container(
    height: ScreenUtil().setHeight(70),
    child: Row(
      children: <Widget>[
        Text(title !=null? title : ''),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(value != null? value : ''),
        ),
      ],
    ),
  );
}