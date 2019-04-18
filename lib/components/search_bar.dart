import 'package:flutter/material.dart';
import './single_picker.dart';
import '../pages/search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchBar(BuildContext context, List singlePickerList, int index, Function searchChange, Function change) {
  return Container(
    height: ScreenUtil().setHeight(120),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 1.0,color: Colors.black26)),
      color: Colors.black12,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: InkWell(
            child: Container(
              height: ScreenUtil().setHeight(75),
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search),
                  Text('搜索',style: TextStyle(fontSize: ScreenUtil().setSp(28)),)
                ],
              ),
              
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return SearchMessage(success: (val){
                  searchChange(val);
                },);
              }));
            },
          )
        ),
        Container(
          margin:EdgeInsets.only(left: 10.0),
          width: ScreenUtil().setWidth(180),
          height: ScreenUtil().setHeight(75),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(singlePickerList[index]['key'], style: TextStyle(fontSize: ScreenUtil().setSp(26)),),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            onTap: (){
              singlePicker(context, singlePickerList, index,(res){
                if(res['key'] == 'confirm') {
                  change(res);
                }else if(res['key'] == 'cancel') {
                  change(res);
                }
              });
            },
          )
        )
        
      ],
    ),
  );
}
