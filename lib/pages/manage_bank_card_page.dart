import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../components/toast.dart';
import '../components/show_modal.dart';
import '../pages/add_bank_card_page.dart';

class ManageBankCardPage extends StatefulWidget {
  @override
  _ManageBankCardPageState createState() => _ManageBankCardPageState();
}

class _ManageBankCardPageState extends State<ManageBankCardPage> {
  List bankCardList = [];
  @override
  void initState() { 
    super.initState();
    _getBankCardList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('管理银行卡'),),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height-80
                ),
                child: Container(
                padding: EdgeInsets.only(top: 10),
                color: Color(0xFFF2F2F2),
                child: bankCardListModel(),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            child: commonButton(),
          )
        ],
      )
    );
  }
  Widget bankCardListModel() {
    return Container(
      child: Column(
        children: bankCardList.length > 0
        ? bankCardList.map((item){
           return bankCardItem(item);
          }).toList()
        : [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height-80
            ),
            child: Container(
              child: Center(
                child: Text('暂无银行卡',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Color(0xFF888888)),),
              ),
            ),
          )
        ]
      ),
    );
  }
  Widget bankCardItem(Map item) {
    return Container(
      padding: EdgeInsets.only(left: 10,right:10,bottom: 8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
        color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LimitedBox(child: Text(item['bankName'] != null? item['bankName'] : '',style: TextStyle(fontSize: ScreenUtil().setSp(32)),overflow: TextOverflow.ellipsis,),maxWidth: 300,),
                Text('尾号: ${item['realAccount'].substring(item['realAccount'].length - 4)}',style: TextStyle(fontSize: ScreenUtil().setSp(32),color:Color(0xFF888888)),)
              ],
            ),
          ),
          Divider(color: Color(0xFFCCCCCC),height:14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Radio(
                      groupValue: true,
                      value: item['isChoice'],
                      onChanged: (res){
                        if(item['isChoice'] == false){
                          _setDefaultBankCard(item['realAccount']);
                        }
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text('设置为默认银行卡')
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setHeight(70),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xFFCCCCCC)),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text('删除'),
                  ),
                ),
                onTap: (){
                  showMyCupertinoDialog(context, '提示', '确认删除该银行卡?', (res){
                    if(res == 'confirm') {
                      _deleteBankCard(item['realAccount']);
                    }
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
  Widget commonButton() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 10,right:10),
        width: MediaQuery.of(context).size.width-20,
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text('添加银行卡',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(32)),),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddBankCardPage();
        }));
      },
    );
  }
  _getBankCardList() {//获取银行卡列表
    postAjax('mobileBankCardList', {}, context).then((res){
      if(res['code'] == 200 && res['content'] is List){
        List list = res['content'];
        list.forEach((item){
          if(item['isDefault'] != null && item['isDefault'] == 1) {
            item['isChoice'] = true;
          }else{
            item['isChoice'] = false;
          }
        });
        setState(() {
         bankCardList = list; 
        });
      }
    });
  }
  _deleteBankCard(accountCode) {
    Map<String, dynamic> params = {};
    params['accountCode'] = accountCode;
    postAjax('deleteBankCard', params, context).then((res){
      if(res['code'] == 200){
        Toast.toast(context, '删除成功');
        bankCardList = [];
        _getBankCardList();
      }
    });
  }
  _setDefaultBankCard(accountCode) {//设置默认银行卡
    Map<String, dynamic> params = {};
    params['accountCode'] = accountCode;
    postAjax('setDefaultBankCard', params, context).then((res){
      if(res['code'] == 200) {
        bankCardList.forEach((item){
          if(item['realAccount'] == accountCode) {
            setState(() {
             item['isChoice'] = true; 
            });
            Toast.toast(context, '设置成功');
          }else{
            setState(() {
              item['isChoice'] = false;
            });
            
          }
        });
      }else{
        Toast.toast(context,res['content']);
      }
    });
  }
  @override
  void dispose() { 
    bankCardList = [];
    super.dispose();
  }
}