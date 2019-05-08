import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../common/service_method.dart';
import 'dart:convert';
import '../common/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mode/resource_list_model.dart';
import '../pages/resource_detail_page.dart';
import '../components/progressDialog.dart';

class ResourcePage extends StatefulWidget {
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();

  List<Map> singlePickerList = [{'key':'全部货源', 'id': 'all'},{'key':'订阅货源', 'id': 'subscribe'}];
  int page = 1;
  int size = 10;
  int mark = 0;
  int _index = 0;//默认全部货源
  List resourceLists = [];
  bool isSubscribe = false;
  String goodsName = '';
  String loadingProvinceCode = '';
  String loadingCityCode = '';
  String loadingCountyCode = '';
  String unloadingProvinceCode = '';
  String unloadingCityCode = '';
  String unloadingCountyCode = '';
  bool _loading = false;
  @override
  void initState() {
    _loading = true;
    _getFreightList();
    _getConfigOther();
    _getSelfInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('货源大厅'),),
      body: ProgressDialog(
        loading: _loading,
        msg: '正在加载',
        child: Container(
          color: Color(0XFFF2F2F2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              searchBar(
                context,
                singlePickerList,
                _index,
                (val){//搜索框
                print(val);
                  loadingProvinceCode = val['startCodeMap'] != null? val['startCodeMap']['provinceCode'] : '';
                  loadingCityCode = val['startCodeMap'] !=null? val['startCodeMap']['cityCode'] : '';
                  loadingCountyCode = val['startCodeMap'] != null? val['startCodeMap']['areaCode'] : '';
                  unloadingProvinceCode = val['endCodeMap'] != null? val['endCodeMap']['provinceCode'] : '';
                  unloadingCityCode = val['endCodeMap'] != null? val['endCodeMap']['cityCode'] : '';
                  unloadingCountyCode = val['endCodeMap'] != null? val['endCodeMap']['areaCode'] : '';
                  goodsName = val['goodsName'];
                  page = 1;
                  resourceLists = [];
                  _getFreightList();
                },
                (val){//切换货源
                  setState(() {
                    _index = val['value'];
                  });
                  page = 1;
                  resourceLists = [];
                  _getFreightList();
                }
              ),
              Expanded(
                child: resourceList(),
              )
            ],
          ),
        ),
      )
      
      
    );
  }
  Widget resourceList() {
    return EasyRefresh(
      child: resourceLists.length > 0
      ?ListView.builder(
          itemCount: resourceLists.length,
          itemBuilder: (BuildContext context, int index) {
          return itemCard(index);
        },
      )
      : Center(child: Padding(child: Text('暂无货源',style: TextStyle(fontSize: ScreenUtil().setSp(40)),),padding: EdgeInsets.only(top: 200))),
      loadMore: (){
        page++;
        _getFreightList();
      },
      onRefresh: (){
        page = 1;
        resourceLists = [];
        _getFreightList();
      },
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        bgColor: Colors.white,
        textColor: Colors.black26,
        moreInfoColor: Colors.black26,
        showMore: false,
        noMoreText: '没有更多',
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
    );
  }
  Widget itemCard(int index){
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
            resourceLists[index].routeName != null
            ? commonItem('线       路', "${resourceLists[index].routeName}")
            : Text('',style: TextStyle(fontSize: 0)),
            commonItem('货       品', "${resourceLists[index].goodsName}"),
            commonItem('司机运价',  "${resourceLists[index].quotePrice}${unit[resourceLists[index].meterageType]['driver.price'][resourceLists[index].quotePriceUnitCode]}"),
          ],
        ),
      ),
      onTap: (){
        String code = resourceLists[index].code;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResourceDetialPage(code: code,)));
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
                child: Text("${resourceLists[index].loadingCityName} ${resourceLists[index].loadingCountyName}",style: TextStyle(fontSize: ScreenUtil().setSp(30),),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ),
              Image.asset('assets/images/big_arrow.png'),
              Container(
                width: ScreenUtil().setWidth(210),
                child:Text("${resourceLists[index].unloadingCityName} ${resourceLists[index].unloadingCountyName}",style: TextStyle(fontSize:  ScreenUtil().setSp(30),),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ),
              
            ],
          ),
          Text("${resourceLists[index].publishTime.split(' ')[0]} ${resourceLists[index].publishTime.split(' ')[1].split(':')[0]}:${resourceLists[index].publishTime.split(' ')[1].split(':')[1]}",style: TextStyle(fontSize:  ScreenUtil().setSp(28),color: Color(0xFF666666)),)
          
        ],
      ),
    );
  }
  Widget commonItem(String title, String value) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(child: Text(title,style:TextStyle(fontSize:ScreenUtil().setSp(26),color:Color(0xFF666666))),width: ScreenUtil().setWidth(140),),
          Text(value, style: TextStyle(fontSize: ScreenUtil().setSp(28)),)
        ],
      ),
    );
  }
  _getFreightList(){
    String stringParams = '?page=$page&size=$size';
    if(mark != 0){
      stringParams = stringParams + '&mark=$mark';
    }
    if(_index != 0) {
      stringParams = stringParams + '&isSubscribe=true';
    }
    if(goodsName != '') {
      stringParams = stringParams + '&goodsName=$goodsName';
    }
    if(loadingProvinceCode != '') {
      stringParams = stringParams + '&loadingProvinceCode=$loadingProvinceCode';
    }
    if(loadingCityCode != '') {
      stringParams = stringParams + '&loadingCityCode=$loadingCityCode';
    }
    if(loadingCountyCode != '') {
      stringParams = stringParams + '&loadingCountyCode=$loadingCountyCode';
    }
    if(unloadingProvinceCode != '') {
      stringParams = stringParams + '&unloadingProvinceCode=$unloadingProvinceCode';
    }
    if(unloadingCityCode != '') {
      stringParams = stringParams + '&unloadingCityCode=$unloadingCityCode';
    }
    if(unloadingCountyCode != '') {
      stringParams = stringParams + '&unloadingCountyCode=$unloadingCountyCode';
    }

    getAjax('apiFreightlist', stringParams, context).then((res){
      // var data = json.decode(res.toString());
      _loading = false;
      ResourceListMode resourceListMode =ResourceListMode.fromJson(res);
      if(resourceListMode.code == 200 && resourceListMode.content.length > 0) {
        setState(() {
          resourceLists.addAll(resourceListMode.content);
        });
      }else if(resourceListMode.code == 200 && page == 1){
        setState(() {
         resourceLists = []; 
        });
      }
    });
  }
  _getConfigOther()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    getAjax('configOther', '', context).then((res){
      if(res['code'] == 200) {
        String value =  json.encode(res['content']);
        prefs.setString('otherConfig', value);
      }
    });
  }
  _getSelfInfo()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getAjax('selfInfo', '', context).then((res){
      if(res['code'] == 200) {
        prefs.setString('selfObj', json.encode(res['content']));
      }
    });
  }
  @override
  void dispose() {
    resourceLists = [];
    _index = 0;
    super.dispose();
  }
}