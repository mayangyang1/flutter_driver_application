import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../common/service_method.dart';
import '../common/util.dart';
import '../mode/waybill_list_mode.dart';
import '../pages/all_waybill_page.dart';
import '../components/progressDialog.dart';
import '../pages/waybill_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/show_modal.dart';

class WaybillPage extends StatefulWidget {
  _WaybillPageState createState() => _WaybillPageState();
}

class _WaybillPageState extends State<WaybillPage> {
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  List waybillList = [];
  int page = 1;
  int size = 10;
  String urlName = '';
  String urls = '';
  String firstParty = '';
  Map<String, dynamic> actionObj = {};
  bool _loading = false;
  void initState() { 
    super.initState();
    _loading = true;
    _getUrlMessage();
    _getWaybillList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('运单列表'), actions: <Widget>[Center(child: InkWell(child: Text('历史运单  ',style: TextStyle(fontSize: ScreenUtil().setSp(32) ),),onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllWaybillPage()));
      },),)],),
      body: ProgressDialog(
        loading: _loading,
        msg: '正在加载',
        child: Container(
          child: EasyRefresh(
            child: waybillList.length > 0
            ? ListView.builder(
              itemCount: waybillList.length,
              itemBuilder: (BuildContext context, int index) {
              return waybillItem(index);
              },
            )
            :Center(child: Padding(child: Text('暂无运单',style: TextStyle(fontSize: ScreenUtil().setSp(40)),),padding: EdgeInsets.only(top: 200))),
            loadMore: (){
              _getWaybillList();
            },
            onRefresh: (){
              page = 1;
              waybillList = [];
              _getWaybillList();
            },
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              bgColor: Colors.white,
              textColor: Colors.black26,
              moreInfoColor: Colors.black26,
              showMore: false,
              noMoreText: '',
              moreInfo: ' ',
              loadText: '上拉加载',
              loadReadyText: '上拉加载',
              loadedText: '加载完成',
              loadingText: '加载中'
            ),
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              bgColor: Colors.white,
              textColor: Colors.black26,
              moreInfoColor: Colors.black26,
              showMore: true,
              moreInfo: '加载中',
              refreshReadyText: '下拉刷新',
              refreshedText: '刷新完成',
            ),
          ),
        ),
      )
       
    );
  }
  Widget waybillItem(index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        // height: 200,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Color(0XFFCCCCCC)),top: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
          color: Color(0xFFFFFFFF)
        ),
        child: Column(
          children: <Widget>[
            lineRouteWidget(index),
            waybillList[index].loadingOrgName != null
            ? Row(children: <Widget>[Text('${waybillList[index].loadingOrgName} —— ${waybillList[index].unloadingOrgName}', style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6),)],)
            : Padding(child: null,padding: EdgeInsets.only(left: 0),),
            Row(children: <Widget>[
              Text('${waybillList[index].goodsName} ',style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6)),
              waybillList[index].driverPrice != null
              ? Text(' ${waybillList[index].driverPrice}${unit[waybillList[index].meterageType]['driver.price'][waybillList[index].driverPriceUnitCode]}',style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6))
              : Text('')
            ],),
            Row(children: <Widget>[
              Text('${waybillList[index].truckLicenseNo}',style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6)),
              Text('  派车时间: ${waybillList[index].createTime}',style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6))
            ],),
            Divider(color: Color(0xFFCCCCCC),),
            Container(
              height: ScreenUtil().setHeight(70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: waybillList.length > 0 && actionObj[waybillList[index].code] != null
                ? _actionButtonList(actionObj[waybillList[index].code], waybillList[index].code, index)
                : [Text('')]
              ),
            )
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return WaybillDetailPage(code: waybillList[index].code,);
        }));
      },
    );
  }
  Widget lineRouteWidget(int index){
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(210),
                child: Text("${waybillList[index].loadingCityName} ${waybillList[index].loadingCountyName}",style: TextStyle(fontSize: ScreenUtil().setSp(30),),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ),
              Image.asset('assets/images/big_arrow.png'),
              Container(
                width: ScreenUtil().setWidth(210),
                child:Text("${waybillList[index].unloadingCityName} ${waybillList[index].unloadingCountyName}",style: TextStyle(fontSize:  ScreenUtil().setSp(30),),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ),
              
            ],
          ),
          Text("${waybillStatus[waybillList[index].waybillStatus]}",style: TextStyle(fontWeight: FontWeight.bold, fontSize:  ScreenUtil().setSp(32),color: Theme.of(context).primaryColor),)
          
        ],
      ),
    );
  }

  Widget minButton( String title, bool isMainColor, Function change) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(70),
        decoration: BoxDecoration(
          color: isMainColor? Theme.of(context).primaryColor :Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width:1, color: isMainColor? Theme.of(context).primaryColor : Color(0xFFCCCCCC))
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: isMainColor? Color(0xFFFFFFFF) :Color(0xFF454545)),),
        ),
      ),
      onTap: change,
    );
  }
  _getWaybillList() {//获取运单列表
    String stringParams = '?page=$page&size=$size&waybillStatus=unloading,going&sort_driverConfirmStatus=asc&sort_id=desc';
    getAjax('waybillList', stringParams, context).then((res){
      setState(() {
        _loading = false;
      });
       WaybillListMode waybilllistmode =WaybillListMode.fromJson(res);
      if(waybilllistmode.code == 200 && waybilllistmode.content.length > 0) {
        setState(() {
         waybillList.addAll(waybilllistmode.content); 

        });
        page++;
        String waybillCodeList = '';
        List codeList = [];
        waybillList.forEach((item){
          codeList.add(item.code);
        });
        waybillCodeList = codeList.join(',');
        print(waybillCodeList);
        _getWaybillActionList(waybillCodeList);
      }else if(waybilllistmode.code == 200 && page == 1){
        waybillList = [];
      }
    });
  }
  _getWaybillActionList(String waybillCodeList) {//获取运单业务动作列表
    Map<String, dynamic> stringParams = {'type' : 'driverApi','businessCodeList' : waybillCodeList};
    postAjax('waybillActionList', stringParams, context).then((res){
      if(res != null && res['code'] == 200) {
        Map actions = res['content'];
        setState(() {
          actionObj = actions;
        });

      }
    });
  } 
  _actionButtonList(List actionList, String code,  int index) {
    List<Widget> buttonlist = [];
    actionList.forEach((item){
      if(item['actionCode'] == 'waybillDriverCancel' ||  item['actionCode'] == 'waybillDriverReject' ){
        buttonlist.insert(0,Padding(child: minButton('${item['actionName']}', false, () {
          if(item['actionCode'] == 'waybillDriverCancel'){//取消运单
            _bindCancelWaybill(waybillList[index].code);
          }
          if(item['actionCode'] == 'waybillDriverReject'){//拒绝运单
            _bindRefuseWaybill(waybillList[index].code);
          }
        }),padding: EdgeInsets.only(left: 10),));
      }else{
        if(item['actionCode'] == 'waybillDriverLoading'){//装货
          buttonlist.add(Padding(child: minButton('装货', true, () {
            
          
          }),padding: EdgeInsets.only(left: 10),));
        }
        if(item['actionCode'] == 'waybillDriverUnloading'){//卸货
          buttonlist.add(Padding(child: minButton('卸货', true, () {
            
          
          }),padding: EdgeInsets.only(left: 10),));
        }
        if(item['actionCode'] == 'waybillDriverAccept'){//确认运单
          buttonlist.add(Padding(child: minButton('确认运单', true, () {
            showRecpitDialog(context,waybillList[index].scheduleType == 'platform'? true: false  , false, waybillList[index]?.truckLicenseNo, waybillList[index]?.goodsName, waybillList[index]?.driverPrice!=null? '${waybillList[index].driverPrice}${unit[waybillList[index].meterageType]['driver.price'][waybillList[index].driverPriceUnitCode]}' : '', waybillList[index]?.originalConsignOrgName,  urlName, '$urls?firstParty=$firstParty&secondParty=${waybillList[index].driverFullName}&idNumber=${waybillList[index].driverIdentityNumber}&phoneNumber=${waybillList[index].driverPhone}', (res){
              if(res['key'] =='confirm'){
                _bindWaybillAccept(waybillList[index].code);
              }
            });         
          }),padding: EdgeInsets.only(left: 10),));
        }        
      }      
    });
    return buttonlist;
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
        page =1;
        waybillList = [];
        _getWaybillList();
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
            page =1;
            waybillList = [];
            _getWaybillList();
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
            page =1;
            waybillList = [];
            _getWaybillList();
          }
        });
      }
    });
    
  }
  @override
  void dispose() {
    waybillList = [];
    urlName = '';
    urls = '';
    firstParty = '';
    actionObj = {};
    _loading = false;
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