import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/service_url.dart';
import '../common/service_method.dart';
import '../mode/resource_detail_mode.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/util.dart';
import 'package:flutter/cupertino.dart';
import '../components/toast.dart';
import '../components/show_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/progressDialog.dart';
class ResourceDetialPage extends StatefulWidget {
  final code;
  ResourceDetialPage({key:Key, this.code});
  @override
  _ResourceDetialPageState createState() => _ResourceDetialPageState();
}

class _ResourceDetialPageState extends State<ResourceDetialPage> {
  DetailMode resourceDetailObj ;
  List goodsRecordList = [];
  String personCertStatus = '';//司机认证状态
  String truckCertStatus = '';//车辆认证状态
  String truckLicenseNo = '';
  bool agrement = false;
  String quotePriceUnitCode = '';
  String quoteType = 'price';//抢单模式 price 一口价 quote司机要价
  String urlName = '';
  String urls = '';
  bool isCollect = false;
  String collectCode = '';
  bool _loading = false;
  @override
  void initState() { 
    _loading = true;
    super.initState();
    _getResourceDetail(widget.code);
    _getUrlMessage();
    _getCollectReocrd(widget.code);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('货源详情'),),
      body: ProgressDialog(
        loading: _loading,
        msg: '正在加载',
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(240)),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      consignorCompany(),
                      companyMessage(),
                      commonContent(),
                      recordList()
                    ],
                  )
                ),
              )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    commonButton('抢单','mainColor',(){
                      _bindReciveResource();
                    }),
                    commonButton(isCollect?  '取消收藏': '收藏货源','default',(){
                      if(isCollect){
                        _deleteRecord();
                      }else{
                        _addRecord();
                      }
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
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
          Container(child: Text('货源托运方: ',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Color(0xFF666666)),),),
          Text(resourceDetailObj?.consignOrgName != null? resourceDetailObj?.consignOrgName : '',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Color(0xFF666666)),)
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
              height: ScreenUtil().setHeight(190),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
              ),
              child: Text(''),
            ),
          ),
          Column(
            children: <Widget>[
              commonItem('assets/images/f.png', resourceDetailObj?.loadingProvinceName !=null?'${resourceDetailObj?.loadingProvinceName} ${resourceDetailObj?.loadingCityName} ${resourceDetailObj?.loadingCountyName}': null, resourceDetailObj?.loadingAddress, resourceDetailObj?.loadingOrgName),
              Padding(child: Divider(),padding: EdgeInsets.only(left: 40),),
              commonItem('assets/images/z.png',resourceDetailObj?.unloadingProvinceName !=null?'${resourceDetailObj?.unloadingProvinceName} ${resourceDetailObj?.unloadingCityName} ${resourceDetailObj?.unloadingCountyName}': null, resourceDetailObj?.unloadingAddress, resourceDetailObj?.unloadingOrgName),
            ],
          ),
          Positioned(
            top: 10,
            right: 0,
            child: Image.asset('assets/images/r.png',width: ScreenUtil().setWidth(180),),
          ),
          
        ],
      ),
    );
  }
  Widget commonItem(String imageUrl, String cityName, String adress, String name){
    return LimitedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(200),
        margin: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: Image.asset(imageUrl,width: ScreenUtil().setWidth(60),),
              padding: EdgeInsets.only(right: 5,top: 10)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cityName !=null? cityName : '',style: TextStyle(height: 1.7,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(30)),),
                Text(adress !=null? adress : '',style: TextStyle(height: 1.5),),
                Text(name !=null? name : '',style: TextStyle(height: 1.5),)
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget commonContent(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          headerTitle('联系人'),
          Container(
            padding: EdgeInsets.only(left: 10,right:20),
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
               color: Colors.white,
               border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('${resourceDetailObj?.contactUserFullName !=null? resourceDetailObj?.contactUserFullName : ''}'),
                    Padding(child: null,padding: EdgeInsets.only(left: 10),),
                    Text('${resourceDetailObj?.contactPhone !=null? resourceDetailObj?.contactPhone : ''}'),
                  ],
                ),
                InkWell(
                  child: Image.asset('assets/images/phone.png',width: ScreenUtil().setWidth(60),),
                  onTap:_launchURL
                )
              ],
            ),
          ),
          headerTitle('基本信息'),
          contentList(),
          headerTitle('接货记录'),
          Container(
            padding: EdgeInsets.only(left: 10,right:20),
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
               color: Colors.white,
               border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
            ),
            child: Row(
              children: <Widget>[
                Text('当前使用车辆'),
                Padding(child: null,padding: EdgeInsets.only(left: 10),),
                Text('沪A25867'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget headerTitle(String title) {
    return Container(
       width: MediaQuery.of(context).size.width,
      color: Color(0xFFF2F2F2),
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
          contentLi('货源号',resourceDetailObj?.freightNo),
          contentLi('货物',resourceDetailObj?.goodsName),
          contentLi('线路', resourceDetailObj?.routeName),
          contentLi('司机运价',resourceDetailObj?.quoteType == 'price'?'${resourceDetailObj?.quotePrice}${unit[resourceDetailObj?.meterageType]['driver.price'][resourceDetailObj.quotePriceUnitCode]}' : '司机报价'),
          contentLi('原始客户', resourceDetailObj?.originalConsignOrgName),
          resourceDetailObj?.truckModelRequire != null
          ? contentLi('车型要求', truckModel[resourceDetailObj?.truckModelRequire])
          : Padding(child: null,padding: EdgeInsets.only(left: 0),),
          resourceDetailObj?.truckLengthRequires != null
          ? contentLi('车长要求', resourceDetailObj?.truckLengthRequires)
          : Padding(child: null,padding: EdgeInsets.only(left: 0),),
          contentLi('需求车次', resourceDetailObj?.truckQty != null? resourceDetailObj?.truckQty.toString() : ''),
          contentLi('已接车次', resourceDetailObj?.acceptTruckNumber != null? resourceDetailObj?.acceptTruckNumber.toString() : ''),
          resourceDetailObj?.goodsWeight != null || resourceDetailObj?.goodsVolume != null || resourceDetailObj?.goodsAmount != null
          ? contentLi(
            '货源总货量',
            '${resourceDetailObj?.goodsWeight != null? resourceDetailObj?.goodsWeight : '0'}吨 ${resourceDetailObj?.goodsVolume != null? resourceDetailObj?.goodsVolume : '0'}方 ${resourceDetailObj?.goodsAmount != null? resourceDetailObj?.goodsAmount : '0'}件'
          )
          : Padding(child: null,padding: EdgeInsets.only(left: 0),),
          contentLi('备注',resourceDetailObj?.description == null? '' : resourceDetailObj?.description),
        ],
      ),
    );
  }
  Widget contentLi(String title, String value){
    return Container(
      height: ScreenUtil().setHeight(50),
      child: Row(
        children: <Widget>[
          Container(child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),),width: ScreenUtil().setWidth(200)),
          Text(value !=null? value: '',style: TextStyle(fontSize: ScreenUtil().setSp(30)),)
        ],
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
  Widget recordList(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: goodsRecordList.length > 0
        ? goodsRecordList.map((item){
           return recordItem(item['truckLicenseNo'], '${item['driverPrice']}${unit[item['meterageType']]['driver.price'][item['driverPriceUnitCode']]}', item['createTime'], item['driverAcceptStatus'],item['code']);
         }).toList()
        : []
      ),
    );
  }
  Widget recordItem(String carNumber, String price, String time, String driverStatus, String code) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFcccccc)))
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row( children: <Widget>[
                  Text('接货车辆',style: TextStyle(height: 1.6,color: Color(0xFF888888)),),
                  Padding(child: null,padding: EdgeInsets.only(left: 10),),
                  Text(carNumber,style: TextStyle(height: 1.6),),
                ],),
                Row(children: <Widget>[
                  Text('司机运价',style: TextStyle(height: 1.6,color: Color(0xFF888888)),),
                  Padding(child: null,padding: EdgeInsets.only(left: 10),),
                  Text(price,style: TextStyle(height: 1.6),),
                ],),
                Row(children: <Widget>[
                  Text('接货时间',style: TextStyle(height: 1.6,color: Color(0xFF888888)),),
                  Padding(child: null,padding: EdgeInsets.only(left: 10),),
                  Text(time,style: TextStyle(height: 1.6),),
                ],),
              ],
            ),
          ),
          Container(
            child: Column(
              children: returnDriverStatus(driverStatus,code)
            ),
          )
        ],
      ),
    );
  }
  returnDriverStatus(driverStatus,code) {//接货记录的状态
    switch (driverStatus) {
      case 'undispatched':
        return <Widget>[
          Text('等待派车',style: TextStyle(height: 1.6),),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Color(0xFFCCCCCC))
              ),
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text('取消接货'),
              ),
            ),
            onTap: (){
              _cancelReceipt(code);
            },
          )
        ];
        break;
      case 'ignored':
        return <Widget>[
          Text('忽略派车',style: TextStyle(height: 1.6),),
          
        ];
      break;
      case 'dispatched':
        return <Widget>[
          Text('已派车',style: TextStyle(height: 1.6),),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Color(0xFFCCCCCC))
              ),
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text('查看运单'),
              ),
            ),
            onTap: (){

            },
          )
        ];
      break;
      case 'comfirmed':
        return <Widget>[
          Text('已派车',style: TextStyle(height: 1.6),),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Color(0xFFCCCCCC))
              ),
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text('查看运单'),
              ),
            ),
            onTap: (){

            },
          )
        ];
      break;
      case 'canceled':
        return <Widget>[
          Text('已取消',style: TextStyle(height: 1.6),),
        ];
      break;
      default:
    }
  }
  void _launchURL() async {//拨打电话
    String url = 'tel:' + resourceDetailObj.contactPhone;
    if(await canLaunch(url)) {
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  _getResourceDetail(freightCode){//获取货源信息
    getAjaxStr('$serviceUrl/driver-api/driver-api/freight/$freightCode/get', '', context).then((res){
      _loading = false;
      ResourceDetailMode data =ResourceDetailMode.fromJson(res);
      if(data.code == 200){
        if(data.content?.truckLengthRequires != null){
         List truckLengthRequiresList = data.content.truckLengthRequires.split(',');
         for(var i =0; i< truckLengthRequiresList.length; i++){
           truckLengthRequiresList[i] = truckLengthRequiresList[i] + '米';
         }
         data.content.truckLengthRequires = truckLengthRequiresList.join(',');
        }
        setState(() {
         resourceDetailObj = data.content; 
         quoteType = data.content.quoteType;
         quotePriceUnitCode = data.content.quotePriceUnitCode;
        });
        _getCollectRecord(freightCode);
        _getSelfInfo();
        _getTruckInfo();
      }
    });
  }
  _getCollectRecord(freightCode){//获取接货记录列表
    getAjaxStr('$serviceUrl/driver-api/driver-api/freight/accept_record_list?freightCode=$freightCode', '', context).then((res){
      if(res['code'] == 200 && res['content'].length > 0) {
        setState(() {
         goodsRecordList = res['content']; 
        });
      }
    });
  }
  _getSelfInfo() {//获取人员信息
    getAjax('selfInfo', '', context).then((res){
      if(res['code'] == 200){
        personCertStatus = res['content']['certStatus'];
      }
    });
  }
  _getTruckInfo() {//获取车辆信息
    getAjax('mainTruckMessage', '?size=1', context).then((res){
      if(res['code'] == 200){
        truckCertStatus = res['content'][0]['certStatus'];
        var truckLicenseNo = res['content'][0]['truckLicenseNo'];
        setState(() {
          truckLicenseNo = truckLicenseNo;
        });
      }
    });
  }
  _bindReciveResource(){//确认抢单
    if(personCertStatus == 'authenticated' && truckCertStatus == 'authenticated'){//人车都已认证
      if(quoteType == 'price'){//一口价
        showRecpitDialog('${resourceDetailObj.loadingCityName} ${resourceDetailObj.loadingCountyName}','${resourceDetailObj?.unloadingCityName} ${resourceDetailObj?.unloadingCountyName}',resourceDetailObj?.quotePrice != null? resourceDetailObj.quotePrice.toString() : '',unit[resourceDetailObj.meterageType]['driver.price'][resourceDetailObj.quotePriceUnitCode] , urlName, urls,context,(res){
          if(res['key'] == 'confirm'){//确认抢单
            _sureDeliveryResource(res['price'], 'price');
          }
        },agrement, false);
      }else{//司机要价
        showRecpitDialog('${resourceDetailObj.loadingCityName} ${resourceDetailObj.loadingCountyName}','${resourceDetailObj?.unloadingCityName} ${resourceDetailObj?.unloadingCountyName}',resourceDetailObj?.quotePrice != null? resourceDetailObj.quotePrice.toString() : '',unit[resourceDetailObj.meterageType]['driver.price'][resourceDetailObj.quotePriceUnitCode] ,urlName, urls,context,(res){
          if(res['key'] == 'confirm'){//确认抢单
             _sureDeliveryResource(res['price'], 'quote');
          }
        },agrement, true);
      }
    }else if(personCertStatus != 'authenticated' && truckCertStatus != 'authenticated'){//
      return Toast.toast(context, '人车都未认证');
    }else{
      if(personCertStatus != 'authenticated'){
        return Toast.toast(context, '人未认证通过');
      }
      if(truckCertStatus != 'authenticated'){
        return Toast.toast(context, '车未认证通过');
      }
    }
  }
  _sureDeliveryResource(String price,String quoteType){
    if(quoteType == 'price'){
      Map<String, dynamic> params = {};
      _receiptWaybill(params,widget.code);
    }else{
      Map<String, dynamic> params = {};
      params['price'] = price;
      params['priceUnitCode'] = quotePriceUnitCode;
      _receiptWaybill(params,widget.code);
    }
    
  }
  _receiptWaybill(Map<String,dynamic> params, String freightCode){//调取抢单接口
    postAjaxStr('$serviceUrl/driver-api/driver-api/freight/accept_waybill/$freightCode', params, context).then((res){
      if(res['code'] == 200) {
        goodsRecordList = [];
        _getCollectRecord(widget.code);
        return Toast.toast(context, '抢单成功');
       
      }
    });
  }
  _cancelReceipt(code){//取消接货
    showMyCupertinoDialog(context,'提示', '确认取消接货?', (res){
      if(res == 'confirm'){
        Map<String, dynamic> params = {};
        params['code'] = code;
        postAjaxStr('$serviceUrl/driver-api/driver-api/freight_accept_record/cancel/$code', params, context).then((res){
          if(res['code'] == 200) {
            _getCollectRecord(widget.code);
          }
        });
      }
    });
  }
 _getUrlMessage()async{//跳到第三方域名
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map otherCofig =json.decode(prefs.getString('otherConfig'));
  setState(() {
   urlName =  otherCofig['other.statement.tradeRulesName'];
   urls = otherCofig['other.statement.tradeRulesUrl'];
  });
 }
 _getCollectReocrd(freightCode) {
  getAjaxStr('$serviceUrl/driver-api/driver-api/driver_api_collect_record/1/$freightCode/get', '', context).then((res){
    if(res != null){
      collectCode = res['content']['code'];
      setState(() {
       isCollect = true; 
      });
    }else{
      isCollect = false;
    }
  });
 }
  _addRecord() {//收藏货源
    Map<String ,dynamic> params = {};
    params['collectSource'] = 1;
    params['collectSourceCode'] =widget.code;
    postAjax('collectRecordAdd', params, context).then((res){
      if(res['code'] == 200) {
        setState(() {
         isCollect = true; 
         collectCode = res['content']['code'];
        });
        return Toast.toast(context, '收藏成功');
      }
    });
  }
  _deleteRecord() {//取消收藏货源
    postAjaxStr('$serviceUrl/driver-api/driver-api/driver_api_collect_record/$collectCode/delete', {}, context).then((res){
      if(res['code'] == 200) {
        setState(() {
         isCollect = false; 
        });
        return Toast.toast(context, '已取消收藏');
      }
    });
  }
  @override
  void dispose() {
    resourceDetailObj = null;
    goodsRecordList = [];
    urlName = '';
    urls = '';
    collectCode = '';
    super.dispose();
  }



  
}
showRecpitDialog(String startAdress, String endAdress, String price, String priceUnicode, String urlName, String urls, BuildContext context, Function success, bool isAgreement, bool enabled) {
  TextEditingController inputController =TextEditingController();
  inputController.text = price;
  showDialog(
  context: context,
  builder: (context) {
    return new SimpleDialog(
      title: new Text('接货',style: TextStyle(fontSize: ScreenUtil().setSp(34)),),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      backgroundColor: Colors.white,
      children: <Widget>[
        Divider(),
        Container(
          height: ScreenUtil().setHeight(70),
          child: Row(
            children: <Widget>[
              Text('运输线路'),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: ScreenUtil().setWidth(180),
                child: Text(startAdress,overflow: TextOverflow.ellipsis,),
              ),
              Image.asset('assets/images/big_arrow.png',width: ScreenUtil().setWidth(30),),
              Container(
                width: ScreenUtil().setWidth(180),
                child: Text(endAdress,overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          height: ScreenUtil().setHeight(70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('运费报价'),
              Expanded(
                flex: 1,
                child: _inputWidget(inputController,'请输入金额', false, enabled, 'number',(res){

                }),
              ),
              Text(priceUnicode)
            ],
          ),
        ),
        Divider(),
        Container(
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
        ),
        Divider(),
        Container(
          height: ScreenUtil().setHeight(80),
          child: Row(
            children: <Widget>[
              Expanded(
                 child: InkWell(
                   child: Container(
                     decoration: BoxDecoration(
                       border: Border(right: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
                     ),
                     child: Center(
                       child: Text('取消接单'),
                     ),
                   ),
                   onTap: (){
                     Navigator.of(context).pop("点击了取消");
                      success({'key': 'cancel'}); 
                   },
                 )
              ),
              Expanded(
                 child: InkWell(
                   child: Container(
                      child: Center(
                       child: Text('确认接单'),
                     ),
                   ),
                   onTap: (){
                     if(enabled && inputController.text == ''){
                      return Toast.toast(context, '请填写报价');
                     }
                     if(isAgreement == false){
                       return Toast.toast(context, '请同意协议');
                     }
                     Navigator.of(context).pop("点击了确定");
                     var result = {};
                     result['key'] = 'confirm';
                     result['price'] = inputController.text.trim();
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
Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText,bool enabled, String inputType, Function change){
  return Container(
    padding: EdgeInsets.only(left: 10.0),
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



