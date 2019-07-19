import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../pages/add_bank_card_page.dart';
import '../pages/manage_bank_card_page.dart';

class BankCardListPage extends StatefulWidget {
  @override
  _BankCardListPageState createState() => _BankCardListPageState();
}

class _BankCardListPageState extends State<BankCardListPage> {
  List cardList  = [];
  @override
  void initState() { 
    super.initState();
    _getBankCardList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的银行卡'),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left:10,right:10,top:10,bottom: 20),
          child: Column(
            children: <Widget>[
              bankCardList(),
              addBankCard(),
              Padding(child: null,padding: EdgeInsets.only(top: 20),),
              manageBankCard(),
            ],
          ),
        ),
      )
    );
  }
  Widget bankCardList() {
    return Container(
      child: Column(
        children: cardList.length > 0
        ? cardList.map((item){
            return  bankCardItem(item);
          }).toList()
        : []
      ),
    );
  }
  Widget bankCardItem(Map item) {
    return Padding(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/bank_bg.png'),
          Positioned(
            left: 20,
            top: 26,
            child: Text('${item['realAccountName'] != null? item['realAccountName'].replaceRange(0,1,'*') : ''}',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.white),),
          ),
          Positioned(
            left: 20,
            top: 60,
            child: Text('${item['bankName'] != null? item['bankName'] : ''}',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.white)),
          ),
          Positioned(
            left: 20,
            top: 90,
            child: Row(
              children: <Widget>[
                Padding(
                  child: Text('**** **** **** ',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.white)),
                  padding: EdgeInsets.only(top:4),
                ),
                Text('${item['realAccount'] != null? item['realAccount'].substring(item['realAccount'].length-4) : ''}',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.white)),

              ],
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(bottom: 10),
    );
  }
  Widget addBankCard() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: ScreenUtil().setHeight(240),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Color(0xFFCCCCCC),style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('+ ',style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Color(0xFF888888)),),
              Text('添加银行卡',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Color(0xFF888888)))
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddBankCardPage();
        })).then((res){
          if(res == 'add'){
            cardList = [];
            _getBankCardList();
          }
        });
      },
    );
  }
  Widget manageBankCard() {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFCCCCCC)),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text('管理银行卡',style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Color(0xFF888888))),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ManageBankCardPage();
        })).then((res){
          cardList = [];
          _getBankCardList();
        });
      },
    );
  }
  _getBankCardList() {//获取绑定的银行卡列表
    postAjax('mobileBankCardList', {}, context).then((res){
      if(res['code'] == 200 && res['content'] != null && res['content'].length > 0) {
        setState(() {
         cardList = res['content']; 
        });
      }else{
        setState(() {
         cardList = []; 
        });
      }
    }); 
  }
  @override
  void dispose() { 
    cardList = [];
    super.dispose();
  }
}