import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../components/show_modal.dart';
import '../pages/business_card.dart';
import '../pages/bank_card_page.dart';
import '../pages/join_company.dart';
import '../pages/my_oil_card_page.dart';
import '../pages/my_collect_recode_page.dart';
import '../pages/subscribe_line_route_page.dart';
import '../pages/change_phone_page.dart';
import '../pages/my_account_page.dart';

class MinePage extends StatefulWidget {
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心'),),
      body: Container(
        color: Color(0xFFF2F2F2),
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            itemContent('assets/images/carte.png', '司机，车辆信息', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BusinessCardPage();
              }));
            }),
            itemContent('assets/images/bankcard.png', '我的银行卡', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BankCardPage();
              }));
            }),
            itemContent('assets/images/trading_account.png', '我的交易账户', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MyAccountPage();
              }));
            }),
            itemContent('assets/images/join.png', '挂靠公司', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return JoinCompanyPage();
              }));
            }),
            itemContent('assets/images/oil_card.png', '我的油卡信息', (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return MyOilCardPage();
                }));
            }),
            itemContent('assets/images/mobile.png', '修改手机号', (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChangePhonePage();
                }));
            }),
            itemContent('assets/images/collection.png', '我的收藏', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MyCollectRecodePage();
              }));
            }),
            itemContent('assets/images/routeLine.png', '订阅线路', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SubscribeLineRoutePage();
              }));
            }),

            Center(
              child: InkWell(
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(80),
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(width: 1,color: Color(0xFFFDDDDDD)),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Center(
                    child: Text('退出登录'),
                  ),
                ),
                onTap: (){
                  showMyCupertinoDialog(context, '提示', '确认退出登录?', (res){
                    if(res == 'confirm') {
                      _loginOut();
                    }
                  });
                },
              ),
            )
          ],
        ),
      )
    );
  }
  Widget itemContent(String imageUrl, String title, Function onTap) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(90),
        padding: EdgeInsets.only(left: 10,right:10),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(imageUrl ,width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(50),),
                Padding(child: Text(title , style: TextStyle(fontSize: ScreenUtil().setSp(30)),),padding: EdgeInsets.only(left: 10)),
              ],
            ),
            Image.asset('assets/images/arrow.png',width: ScreenUtil().setWidth(30),height: ScreenUtil().setHeight(30),)

          ],
        ),
      ),
      onTap: onTap,
    );
  }
  void _loginOut() {
    getAjax('loginOut', '', context).then((res){
      if(res['code'] == 200) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=> false);
      }
    });
  }
}