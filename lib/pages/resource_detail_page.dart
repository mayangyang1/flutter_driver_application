import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ResourceDetialPage extends StatefulWidget {
  final code;
  ResourceDetialPage({key:Key, this.code});
  @override
  _ResourceDetialPageState createState() => _ResourceDetialPageState();
}

class _ResourceDetialPageState extends State<ResourceDetialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('货源详情'),),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(240)),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    consignorCompany(),
                    companyMessage(),
                    commonContent(),
                    recordList()
                  ],
                )
              ),
            )
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              child: Column(
                children: <Widget>[
                  commonButton('抢单','mainColor'),
                  commonButton('收藏货源','default'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget consignorCompany(){
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(child: Text('货源托运方: ',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Color(0xFF666666)),),),
          Text('融链物流',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Color(0xFF666666)),)
        ],
      )
    );
  }
  Widget companyMessage(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            left: 25,
            child: Container(
              height: ScreenUtil().setHeight(190),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
              ),
              child: Text(''),
            ),
          ),
          Column(
            children: <Widget>[
              commonItem('assets/images/f.png', '上海市 浦东新区 世纪大道', '桃林路777号', '万达国际有限公司'),
              Padding(child: Divider(),padding: EdgeInsets.only(left: 40),),
              commonItem('assets/images/z.png','北京市 海淀区 人民路', '人民路9999', '北京国际有限公司'),
            ],
          ),
          Positioned(
            top: 10,
            right: 0,
            child: Image.asset('assets/images/r.png',width: ScreenUtil().setWidth(180),),
          ),
          
        ],
      ),
    );
  }
  Widget commonItem(String imageUrl, String cityName, String adress, String name){
    return LimitedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(200),
        margin: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: Image.asset(imageUrl,width: ScreenUtil().setWidth(60),),
              padding: EdgeInsets.only(right: 5,top: 10)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cityName,style: TextStyle(height: 1.7,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(30)),),
                Text(adress,style: TextStyle(height: 1.5),),
                Text(name,style: TextStyle(height: 1.5),)
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget commonContent(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          headerTitle('联系人'),
          Container(
            padding: EdgeInsets.only(left: 10,right:20),
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
               color: Colors.white,
               border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('张磊'),
                    Padding(child: null,padding: EdgeInsets.only(left: 10),),
                    Text('15655444566'),
                  ],
                ),
                Image.asset('assets/images/phone.png',width: ScreenUtil().setWidth(60),)

              ],
            ),
          ),
          headerTitle('基本信息'),
          contentList(),
          headerTitle('接货记录'),
          Container(
            padding: EdgeInsets.only(left: 10,right:20),
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
               color: Colors.white,
               border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
            ),
            child: Row(
              children: <Widget>[
                Text('当前使用车辆'),
                Padding(child: null,padding: EdgeInsets.only(left: 10),),
                Text('沪A25867'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget headerTitle(String title) {
    return Container(
      color: Color(0xFFF2F2F2),
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.only(left: 10),
      child: Text(title,style: TextStyle(height: 2),),
    );
  }
  Widget contentList() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC))),

      ),
      child: Column(
        children: <Widget>[
          contentLi('货源号','20190423Y000120'),
          contentLi('货物','电子设备'),
          contentLi('线路','珊瑚海专线'),
          contentLi('司机运价','200元/吨'),
          contentLi('原始客户','融链物流'),
          contentLi('需求车次','3'),
          contentLi('已接车次','1'),
          contentLi('货源总货量','121吨'),
          contentLi('备注','这是一条备注'),
        ],
      ),
    );
  }
  Widget contentLi(String title, String value){
    return Container(
      height: ScreenUtil().setHeight(50),
      child: Row(
        children: <Widget>[
          Container(child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFF888888)),),width: ScreenUtil().setWidth(200)),
          Text(value,style: TextStyle(fontSize: ScreenUtil().setSp(30)),)
        ],
      ),
    );
  }
  Widget commonButton(String title,String color) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          color: color == 'mainColor'? Theme.of(context).primaryColor : Colors.white,
          border: color == 'mainColor'? Border.all(width: 0) :  Border.all(width: 1,color: Color(0xFFCCCCCC)),
          borderRadius: BorderRadius.circular(5)
        ),
        width: MediaQuery.of(context).size.width-20,
        margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
        child: Center(
          child: Text(title,style: TextStyle(color: color == 'mainColor'? Colors.white : Color(0xFF454545),),
          ),
        ),
      ),
      onTap: (){

      },
    );
  }
  Widget recordList(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          recordItem('沪A25867', '111元/件', '2019-14-24 16:30:09'),
          recordItem('沪A25867', '111元/件', '2019-14-24 16:30:09'),
          recordItem('沪A25867', '111元/件', '2019-14-24 16:30:09'),
          recordItem('沪A25867', '111元/件', '2019-14-24 16:30:09'),
        ],
      ),
    );
  }
  Widget recordItem(String carNumber, String price, String time) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFcccccc)))
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row( children: <Widget>[
                  Text('接货车辆',style: TextStyle(height: 1.6,color: Color(0xFF888888)),),
                  Padding(child: null,padding: EdgeInsets.only(left: 10),),
                  Text(carNumber,style: TextStyle(height: 1.6),),
                ],),
                Row(children: <Widget>[
                  Text('司机运价',style: TextStyle(height: 1.6,color: Color(0xFF888888)),),
                  Padding(child: null,padding: EdgeInsets.only(left: 10),),
                  Text(price,style: TextStyle(height: 1.6),),
                ],),
                Row(children: <Widget>[
                  Text('接货时间',style: TextStyle(height: 1.6,color: Color(0xFF888888)),),
                  Padding(child: null,padding: EdgeInsets.only(left: 10),),
                  Text(time,style: TextStyle(height: 1.6),),
                ],),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text('等待派车',style: TextStyle(height: 1.6),),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFFCCCCCC))
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Text('取消接货'),
                    ),
                  ),
                  onTap: (){

                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
