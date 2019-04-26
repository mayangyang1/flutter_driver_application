import 'package:flutter/material.dart';
import '../common/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../common/util.dart';
import '../pages/resource_detail_page.dart';

class MyCollectRecodePage extends StatefulWidget {
  @override
  _MyCollectRecodePageState createState() => _MyCollectRecodePageState();
}

class _MyCollectRecodePageState extends State<MyCollectRecodePage> {
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  List resourceLists = [];
  int page = 1;
  @override
  void initState() { 
    super.initState();
    _getCollectRecodeMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的收藏'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        padding: EdgeInsets.only(top: 10),
        child: EasyRefresh(
          child: resourceLists.length > 0
          ? ListView.builder(
            itemCount:  resourceLists.length,
            itemBuilder: (BuildContext context, int index) {
            return resourceItem(index);
           },
          )
          : Center(child: Padding(child: Text('暂无收藏记录',style: TextStyle(fontSize: ScreenUtil().setSp(40)),),padding: EdgeInsets.only(top: 200))),
          loadMore: (){
            _getCollectRecodeMessage();
          },
          onRefresh: (){
            page = 1;
            resourceLists = [];
            _getCollectRecodeMessage();
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
    );
  }
  Widget resourceItem(int index){
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
            resourceLists[index]['routeName'] != null
            ? commonItem('线       路', "${resourceLists[index]['routeName']}")
            : Text('',style: TextStyle(fontSize: 0)),
            commonItem('货       品', "${resourceLists[index]['goodsName']}"),
            commonItem('司机运价',  "${resourceLists[index]['quotePrice']}${unit[resourceLists[index]['meterageType']]['driver.price'][resourceLists[index]['quotePriceUnitCode']]}"),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ResourceDetialPage(code: resourceLists[index]['code'],);
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
                child: Text("${resourceLists[index]['loadingCityName']} ${resourceLists[index]['loadingCountyName']}",style: TextStyle(fontSize: ScreenUtil().setSp(30),),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ),
              Image.asset('assets/images/big_arrow.png'),
              Container(
                width: ScreenUtil().setWidth(210),
                child:Text("${resourceLists[index]['unloadingCityName']} ${resourceLists[index]['unloadingCountyName']}",style: TextStyle(fontSize:  ScreenUtil().setSp(30),),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ),
              
            ],
          ),
          Text("${resourceLists[index]['publishTime'].split(' ')[0]} ${resourceLists[index]['publishTime'].split(' ')[1].split(':')[0]}:${resourceLists[index]['publishTime'].split(' ')[1].split(':')[1]}",style: TextStyle(fontSize:  ScreenUtil().setSp(28),color: Color(0xFF666666)),)
          
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
  _getCollectRecodeMessage() {
    String stringParams = '?page=$page&size=10';
    getAjax('recodeList', stringParams, context).then((res){
      if(res['code'] == 200 && res['content'].length > 0) {
        setState(() {
          resourceLists.addAll(res['content']);
          page++;
        });
      }else if(res['code'] == 200 && page == 1){
        setState(() {
         resourceLists = []; 
        });
      }
      
    });
  }
  @override
  void dispose() { 
    resourceLists = [];
    super.dispose();
  }
}