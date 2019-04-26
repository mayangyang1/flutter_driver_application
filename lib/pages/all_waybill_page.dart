import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../common/service_method.dart';
import '../common/util.dart';
import '../mode/waybill_list_mode.dart';
import '../components/progressDialog.dart';

class AllWaybillPage extends StatefulWidget {
  _AllWaybillPageState createState() => _AllWaybillPageState();
}

class _AllWaybillPageState extends State<AllWaybillPage> {
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  List waybillList = [];
  int page = 1;
  int size = 10;
  Map<String, dynamic> actionObj = {};
  bool _loading = false;
  void initState() { 
    super.initState();
    _loading = true;
    _getWaybillList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true, title: Text('运单列表')),
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
    return Container(
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
          Row(children: <Widget>[Text('${waybillList[index].loadingOrgName} —— ${waybillList[index].unloadingOrgName}', style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6),)],),
          Row(children: <Widget>[
            Text('${waybillList[index].goodsName} ',style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6)),
            Text(' ${waybillList[index].driverPrice}${unit[waybillList[index].meterageType]['driver.price'][waybillList[index].driverPriceUnitCode]}',style: TextStyle(fontSize: ScreenUtil().setSp(28),height: 1.6))
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
              ? _actionButtonList(actionObj[waybillList[index].code], waybillList[index].code)
              : [Text('')]
            ),
          )
        ],
      ),
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
    String stringParams = '?page=$page&size=$size';
    getAjax('waybillList', stringParams, context).then((res){
      _loading = false;
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
  _actionButtonList(List actionList, String code) {
    List<Widget> buttonlist = [];
    actionList.forEach((item){
      if(item['actionCode'] == 'waybillDriverCancel' ||  item['actionCode'] == 'waybillDriverReject' ){
        buttonlist.insert(0,Padding(child: minButton('${item['actionName']}', false, () {}),padding: EdgeInsets.only(left: 10),));
      }else{
        buttonlist.add(Padding(child: minButton('${item['actionName']}', true, () {}),padding: EdgeInsets.only(left: 10),));

      }
      
    });
    return buttonlist;
  }
  @override
  void dispose() {
    waybillList = [];
    actionObj = {};
    super.dispose();
  }
}