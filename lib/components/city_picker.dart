import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/service_method.dart';

class CityPicker extends StatefulWidget {
  final BuildContext context;
  final Function change;
  final bool showArea;
  CityPicker({Key key,this.context, this.change, this.showArea}) : super(key : key);

  _CityPickerState createState() => _CityPickerState();
}
class _CityPickerState extends State<CityPicker> {

 List data = List();
  List province = List();
  List city = List();
  List area = List();
  FixedExtentScrollController provinceController = FixedExtentScrollController();
  FixedExtentScrollController cityController = FixedExtentScrollController();
  FixedExtentScrollController areaController =FixedExtentScrollController();
  String provinceCode = '';
  String cityCode = '';
  String areaCode = '';
  String textValue = '';
  int provinceIndex = 0;
  int cityIndex = 0;
  int areaIndex = 0;
  void getProvinceList (){
    getAjax('provinceList', '', widget.context).then((res){
      Map data = res;
      if(data['code'] == 200) {
        setState(() {
          this.province = data['content'];
          this.provinceCode = this.province[0]['code'];
          this.provinceIndex = 0;
          this.city = [];
          this.area = [];
          this.cityCode = '';
          this.areaCode = '';
          getCityList(this.provinceCode);
        });
      }
    });
  }
  void getCityList(String provinceCode) {
    getAjax('cityList', '?provinceCode=$provinceCode', context).then((res){
      Map data = res;
      if(data['code'] == 200 && data['content'].length > 0){
        setState(() {
          this.city = data['content'];
          this.cityCode = this.city[0]["code"];
          this.cityIndex = 0;
          this.area =[];
          if(widget.showArea == true) {
            getAreaList(this.cityCode);
          }
          
        });
      }
    });
  }
  void getAreaList(cityCode) {
    getAjax('countyList', '?cityCode=$cityCode', context).then((res){
      Map data = res;
      if(data['code'] == 200 && data['content'].length > 0) {
        setState(() {
         this.area = data['content'];
         this.areaCode = this.area[0]["code"];
         this.areaIndex = 0;
        });
         
      }
    });
  }
  void _loadData() {
    getProvinceList();
  }
  @override
  void initState() { 
    _loadData();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton (
                      child: Text('取消',style: TextStyle(fontSize: 18.0),),
                      onPressed: (){
                        Navigator.of(context).pop('取消');
                      },
                    ),
                    FlatButton (
                      child: Text('确认',style: TextStyle(fontSize: 18.0)),
                      onPressed: (){
                        Navigator.of(context).pop('确认');
                        if(city.length == 0 && area.length == 0) {
                           textValue = '${province[provinceIndex]['chineseShortName']}';
                        }
                        if(city.length > 0 && area.length == 0) {
                          textValue = '${province[provinceIndex]['chineseShortName']} - ${city[cityIndex]['chineseShortName']}';
                        }
                        if(city.length > 0 && area.length > 0) {
                          textValue = '${province[provinceIndex]['chineseShortName']} - ${city[cityIndex]['chineseShortName']} - ${area[areaIndex]['chineseShortName']}';
                        }
                        

                        widget.change({'provinceCode':provinceCode, 'cityCode': cityCode, 'areaCode': areaCode, 'textValue': textValue });
                      },
                    )
                  ],
                ),
              )
            ),
            Expanded(
              flex:5,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CommonPicker(
                      controller: provinceController,
                      key: Key('province'),
                      createWidgetList: (){
                        return province.map((v){
                          return Padding(child: Text(v['chineseShortName']),padding: EdgeInsets.only(top: 6),);
                        }).toList();
                      },
                      change: (index) {
                        print(index);
                        setState(() {
                          cityController.jumpToItem(0);
                          areaController.jumpToItem(0);
                          provinceCode = this.province[index]['code'];
                          this.city = [];
                          this.area = [];
                          this.cityCode = '';
                          this.areaCode = '';
                          this.provinceIndex = index;
                          getCityList(provinceCode);
                        });
                        
                      },

                    ),
                  ),
                  Expanded(
                    child: CommonPicker(
                      controller: cityController,
                      key: Key('city'),
                      createWidgetList: (){
                        return city.map((v){
                          return Padding(child: Text(v['chineseShortName']),padding: EdgeInsets.only(top: 6),);
                        }).toList();
                      },
                      change: (index) {
                        setState(() {
                          areaController.jumpToItem(0);
                          cityCode = this.city[index]['code'];
                          this.cityIndex = index;
                        });
                        if(widget.showArea == true) {
                          this.area = [];
                          this.areaCode = '';
                          getAreaList(cityCode);
                        }
                        
                      },
                    ),
                  ),
                  widget.showArea == true
                  ? Expanded(
                      child: CommonPicker(
                        controller: areaController,
                        key: Key('area'),
                        createWidgetList: (){
                          return area.map((v){
                            return Padding(child: Text(v['chineseShortName']),padding: EdgeInsets.only(top: 6),);
                          }).toList();
                        },
                        change: (index) {
                          setState(() {
                          areaCode = this.area[index]['code']; 
                          this.areaIndex = index;
                          });
                        },
                      ),
                    )
                  : Padding(child: null,padding: EdgeInsets.only(top: 0),)
                ],
              )
            )
            
          ],
        )
      )
    
    );
  }
}

showPicker(BuildContext context, Function change, bool showArea) {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CityPicker(context:context, change: change, showArea:showArea);
    }
  );
}
class CommonPicker extends StatefulWidget {
  final  createWidgetList;
  final change;
  final Key key;
  final controller;

  CommonPicker({this.createWidgetList, this.change, this.key, this.controller});

  _CommonPickerState createState() => _CommonPickerState();
}

class _CommonPickerState extends State<CommonPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoPicker(
        key: widget.key,
        scrollController: widget.controller,
        itemExtent: 40.0,
        backgroundColor: Colors.white,
        onSelectedItemChanged: (index){
          if(widget.change != null) {
            widget.change(index);
          }
        },
        children: widget.createWidgetList().length > 0
        ? widget.createWidgetList()
        : [Padding(child: Text('请选择'),padding: EdgeInsets.only(top: 6),)]
      )
    );
  }
}