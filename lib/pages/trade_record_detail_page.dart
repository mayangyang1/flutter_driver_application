import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeRecordDetailPage extends StatefulWidget {
  final Map tradeItem;
  TradeRecordDetailPage({Key key, this.tradeItem});
  @override
  _TradeRecordDetailPageState createState() => _TradeRecordDetailPageState();
}

class _TradeRecordDetailPageState extends State<TradeRecordDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情'),),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
          color: Color(0xFFF2F2F2),
        ),
        child: Column(
          children: <Widget>[
            recordItem('金额', '${widget.tradeItem['balanceOfPaymentsType'] == 1? '+' : '-'}${widget.tradeItem['transferAmount']}', true),
            recordItem('收款人', '${widget.tradeItem['oppositeAccountName']}', true),
            recordItem('收款账户', '${widget.tradeItem['oppositeAccount'].substring(0, 4)} *** *** *** ${widget.tradeItem['oppositeAccount'].substring(widget.tradeItem['oppositeAccount'].length-4)}', true),
            recordItem('类型', '${_getDetailType(widget.tradeItem['detailType']) != null? _getDetailType(widget.tradeItem['detailType']) : ''}', true),
            recordItem('交易单号', '${widget.tradeItem['transactionCode']}', false),
            recordItem('交易日期', '${widget.tradeItem['transferTime']}', false),
          ],
        ),
      ),
    );
  }
  Widget recordItem(String title, content, bool mainColor) {
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 10,right:10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width:1,color: Color(0xFFCCCCCC))),
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Color(0xFF666666)),),
          Text(content,style: TextStyle(fontSize: ScreenUtil().setSp(32),color: mainColor? Theme.of(context).primaryColor :Color(0xFF454545)),)
        ],
      ),
    );
     
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
}