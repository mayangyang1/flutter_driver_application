import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import './trade_record_detail_page.dart';

class TradeRecodePage extends StatefulWidget {
  @override
  _TradeRecodePageState createState() => _TradeRecodePageState();
}

class _TradeRecodePageState extends State<TradeRecodePage> {
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  int page = 1;
  List recordList = [];
  @override
  void initState() { 
    super.initState();
    _getRecordListMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('交易记录'),),
      body:Container(
        child:EasyRefresh(
          child: recordList.length > 0
          ? ListView.builder(
              itemCount: recordList.length,
              itemBuilder: (BuildContext context, int index) {
                return recordItem(index);
              } 
            )
          :Center(
            child: Padding(
              child: Text('暂无交易记录', style:TextStyle(fontSize:ScreenUtil().setSp(46),color:Color(0xFF666666))),
              padding: EdgeInsets.only(top: 200),
            ),
          ),
          loadMore: (){
            page++;
            _getRecordListMessage();
          },
          onRefresh: (){
            page = 1;
            recordList = [];
            _getRecordListMessage();
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
        )  
      )
    );
  }
  Widget recordItem(int index) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
              ),
              child: Image.asset(_getAssetsImage(recordList[index]['detailType']) != null? _getAssetsImage(recordList[index]['detailType']) : 'assets/images/transaction-r.png',width: ScreenUtil().setWidth(80),),
            ),
            Padding(child: null,padding: EdgeInsets.only(left:10),),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${recordList[index]['details']}(尾号${recordList[index]['lastNum']})'),
                      Padding(child: null,padding: EdgeInsets.only(top: 10),),
                      Text('${recordList[index]['transferTime']}',style: TextStyle(color: Color(0xFFBCBCBC)),)
                    ],
                  ),
                  recordList[index]['balanceOfPaymentsType'] == 1
                  ? Text('+${ recordList[index]['transferAmount']}',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Theme.of(context).primaryColor),)
                  : Text('-${ recordList[index]['transferAmount']}',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Theme.of(context).primaryColor),)
                ],
              ),
            )
          ],
        ),
      ),
      onTap: (){
        Map tradeItem = recordList[index];

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TradeRecordDetailPage(tradeItem: tradeItem);
        }));
      },
    );
  }
  _getAssetsImage(type) {
    Map imageTypes = {
      1001: 'assets/images/putforward.png',
      1002: 'assets/images/cashfailure.png',
      1003: 'assets/images/cashfailure.png',
      1004: 'assets/images/cashfailure.png',
      1006: 'assets/images/cashfailure.png',
      1701: 'assets/images/transaction-r.png',
      1702: 'assets/images/transaction-r.png',
      1801: 'assets/images/cancle-waybill.jpg',
      1802: 'assets/images/cancle-waybill.jpg',
    };
    return imageTypes[type]; 
  }
  _getDetailType(num type) {
    Map types = {
      1001: '提现',
      1002: '核心企业提现手续费',
      1003: '提现手续费',
      1004: '提现失败回冲',
      1006: '提现手续费回冲',
      1701: '运费收入',
      1702: '运费收入',
      1801: '撤销运单支付',
      1802: '撤销运单支付',
    };
    return types[type];
  }
  _getRecordListMessage() {//获取交易记录
    Map<String, dynamic> params = {};
    params['page'] = page;
    params['size'] = 10;
    postAjax('tradeLog', params, context).then((res){
      if(res['code'] == 200 && res['content'] != null && res['content']['dataList'].length > 0) {
        page++;
        List list = res['content']['dataList'];
        list.forEach((item){
          item['lastNum'] = item['oppositeAccount'].substring(item['oppositeAccount'].length-4);
          item['transferAmount'] = item['transferAmount'].toStringAsFixed(2);
          item['details'] = _getDetailType(item['detailType']) != null? _getDetailType(item['detailType']) : '';
        });
        setState(() {
          recordList.addAll(list);
        });
       
      }else if(res['code'] == 200 && page == 1){
        setState(() {
          recordList = []; 
        });
      }
    });
  }
  @override
  void dispose() { 
    recordList = [];
    page = 1;
    super.dispose();
  }
}