import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../pages/raise_cash_page.dart';
import '../pages/bank_card_list_page.dart';
import '../pages/trade_record_page.dart';
import '../pages/security_setting_page.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Map accountObj = {};
  @override
  void initState() { 
    super.initState();
    _getAccountMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的交易账户'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Column(
          children: <Widget>[
            accountBalanceModel(),
            commonItem('assets/images/bankcard.png', '我的银行卡', '${accountObj['bankCardList'] != null && accountObj['bankCardList'].length>0?   accountObj['bankCardList'].length.toString() + '张' : '未绑定'}',(){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BankCardListPage();
              })).then((res){
                accountObj = {};
                _getAccountMessage();
              });
            }),
            commonItem('assets/images/transaction.png', '交易记录', '',(){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return TradeRecodePage();
              })).then((res){
                accountObj = {};
                _getAccountMessage();
              });
            }),
            commonItem('assets/images/safety.png', '安全设置', '',(){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SecuritySettingPage();
              })).then((res){
                accountObj = {};
                _getAccountMessage();
              });
            })
          ],
        )
      ),
    );
  }
  Widget accountBalanceModel() {
    return Container(
      color: Colors.orangeAccent,
      height: ScreenUtil().setHeight(350),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(child: null,padding: EdgeInsets.only(top: 30),),
            Text('账户余额',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(34)),),
            Padding(child: null,padding: EdgeInsets.only(top: 16),),
            Text('¥ ${accountObj['userInfo'] !=null && accountObj['userInfo']['cash'] != null? accountObj['userInfo']['cash'].toStringAsFixed(2) : '' }',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(42),fontWeight:FontWeight.bold),),
            Padding(child: null,padding: EdgeInsets.only(top: 16),),
            InkWell(
              child: Container(
                height: ScreenUtil().setHeight(60),
                width: ScreenUtil().setWidth(260),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Text('提现',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(34)),),
                ),
              ),
              onTap: (){
                _bindRaiseCash();
              },
            )
          ],
        ),
      )
    );
  }
  Widget commonItem(String imageUrl, String title, String tips, Function onTap) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10,right:10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(imageUrl,width: ScreenUtil().setWidth(52),),
                Padding(child: null,padding: EdgeInsets.only(left: 10)),
                Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(32)),)
              ],
            ),
            Row(
              children: <Widget>[
                Text(tips != ''? tips : '',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF666666)),),
                Padding(child: null,padding: EdgeInsets.only(left: 5)),
                Image.asset('assets/images/arrow.png',width:ScreenUtil().setWidth(22))
              ],
            )
          ],
        )
      ),
      onTap: onTap,
    );
  }
  _getAccountMessage() {//获取交易账户信息
    postAjax('mobileUserMoney', {}, context).then((res){
      if(res['code'] == 200) {
        setState(() {
          accountObj = res['content'];
        });
       

      }
    });
  }
  _bindRaiseCash() {//去提现
    if(accountObj['bankCardList'].length > 0){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return RaiseCashPage();
      })).then((res){
        accountObj = {};
        _getAccountMessage();
      });
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return BankCardListPage();
      })).then((res){
        accountObj = {};
        _getAccountMessage();
      });
    }
  }
}