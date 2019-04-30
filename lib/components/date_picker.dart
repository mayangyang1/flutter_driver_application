import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dataPicker(BuildContext context, times) {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return DatePicker(times: times,);
    },
  );
}

class DatePicker extends StatefulWidget {
  final String  times;
  DatePicker({Key key, this.times}) :super(key:key);
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  FixedExtentScrollController yearController = FixedExtentScrollController();
  FixedExtentScrollController monthController = FixedExtentScrollController();
  FixedExtentScrollController dayController = FixedExtentScrollController();
  FixedExtentScrollController hourController = FixedExtentScrollController();
  FixedExtentScrollController minuteController = FixedExtentScrollController();

  List<String> yearlist = ['${new DateTime.now().year.toString()}年'];
  List<String> dayList = ['01日', '02日', '03日', '04日', '05日', '06日', '07日', '08日', '09日', '10日', '11日', '12日', '13日', '14日', '15日', '16日', '17日', '18日', '19日', '20日', '21日', '22日', '23日', '24日', '25日', '26日', '27日', '28日', '29日', '30日', '31日'];
  List<String>dayList31 = ['01日', '02日', '03日', '04日', '05日', '06日', '07日', '08日', '09日', '10日', '11日', '12日', '13日', '14日', '15日', '16日', '17日', '18日', '19日', '20日', '21日', '22日', '23日', '24日', '25日', '26日', '27日', '28日', '29日', '30日', '31日'];
  List<String>dayList30 = ['01日', '02日', '03日', '04日', '05日', '06日', '07日', '08日', '09日', '10日', '11日', '12日', '13日', '14日', '15日', '16日', '17日', '18日', '19日', '20日', '21日', '22日', '23日', '24日', '25日', '26日', '27日', '28日', '29日', '30日'];
  List<String>dayList29 = ['01日', '02日', '03日', '04日', '05日', '06日', '07日', '08日', '09日', '10日', '11日', '12日', '13日', '14日', '15日', '16日', '17日', '18日', '19日', '20日', '21日', '22日', '23日', '24日', '25日', '26日', '27日', '28日', '29日'];
  List<String>dayList28 = ['01日', '02日', '03日', '04日', '05日', '06日', '07日', '08日', '09日', '10日', '11日', '12日', '13日', '14日', '15日', '16日', '17日', '18日', '19日', '20日', '21日', '22日', '23日', '24日', '25日', '26日', '27日', '28日'];
  List<String>monthList = ['01月', '02月', '03月', '04月', '05月', '06月', '07月', '08月', '09月', '10月', '11月', '12月'];
  List<String>hourList = ['00时', '01时', '02时', '03时', '04时', '05时', '06时', '07时', '08时', '09时', '10时', '11时', '12时', '13时', '14时', '15时', '16时', '17时', '18时', '19时', '20时', '21时', '22时', '23时'];
  List<String>minuteList = ['00分', '01分', '0分', '02分', '03分', '04分', '05分', '06分', '07分', '08分', '09分', '10分', '11分', '12分', '13分', '14分', '15分', '16分', '17分', '18分', '19分', '20分', '21分', '22分', '23分', '24分', '25分', '26分', '27分', '28分', '29分', '30分', '31分', '32分', '33分', '34分', '35分', '36分', '37分', '38分', '39分', '40分', '41分', '42分', '43分', '44分', '45分', '46分', '47分', '48分', '49分', '50分', '51分', '52分', '53分', '54分', '55分', '56分', '57分', '58分', '59分'];
  int yearIndex = 0;
  int monthIndex = 0;
  int dayIndex = 0;
  int hourIndex = 0;
  int minuteIndex = 0;
  String selectTimes;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () => _getCurrentTime(widget.times));
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
                        _timeComplete();
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
                    child: datePicker(yearlist, 'year', yearController),
                  ),
                  Expanded(
                    child: datePicker(monthList, 'month', monthController),
                  ),
                  Expanded(
                    child: datePicker(dayList, 'day', dayController),
                  ),
                  Expanded(
                    child: datePicker( hourList, 'hour', hourController),
                  ),
                  Expanded(
                    child: datePicker(minuteList, 'minute', minuteController),
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }

  Widget datePicker(List times, String type, controller) {
    return CupertinoPicker(
      children: times.length > 0
      ? times.map((v){
        return Padding(child: Text(v),padding: EdgeInsets.only(top: 6));
      }).toList()
      : [Text('')],
      itemExtent: 40.0,
      backgroundColor: Colors.white,
      diameterRatio: 60.0,
      offAxisFraction: 1.0,
      scrollController: controller,
      onSelectedItemChanged: (index){
        switch (type) {
          case 'month':
            _changeMonth(index);
            break;
          case 'day':
            _changeDay(index);
            break;
          case 'hour':
            _changeHour(index);
            break;
          case 'minute':
            _changeMinute(index);
            break;
          default:
        }
      },
    );
  }
  _getCurrentTime(String time){//初始化时间
    print(time);
    String month = time.split('-')[1] + '月';
    print(month);
    String day = time.split(' ')[0].split('-')[2] + '日';
    String hour = time.split(' ')[1].split(':')[0] + '时';
    String minute = time.split(' ')[1].split(':')[1] + '分';
    for(var x =0; x< monthList.length; x++){
      if(monthList[x] == month){
        setState(() {
          monthIndex = x;
        });
        monthController.jumpToItem(monthIndex);
        
      }
    }
    for(var x =0; x< dayList.length; x++){
      if(dayList[x] == day){
        setState(() {
          dayIndex = x; 
        });
        dayController.jumpToItem(dayIndex);
      }
    }
    for(var x =0; x< hourList.length; x++){
      if(hourList[x] == hour){
        setState(() {
          hourIndex = x; 
        });
        hourController.jumpToItem(hourIndex);
      }
    }
    for(var x =0; x< minuteList.length; x++){
      if(minuteList[x] == minute){
        setState(() {
          minuteIndex = x; 
        });
        minuteController.jumpToItem(minuteIndex);
      }
    }
  }
  _timeComplete() {//确认选择的时间
    String year = yearlist[0].substring(0,4);
    String month = monthList[monthIndex].substring(0, 2);
    String day = dayList[dayIndex].substring(0, 2);
    String hour = hourList[hourIndex].substring(0, 2);
    String minute = minuteList[minuteIndex].substring(0, 2); 
    selectTimes = '$year-$month-$day $hour:$minute:00';
    print(selectTimes);
  }
  _changeMonth(index){
    setState(() {
      monthIndex = index;
    });
    _getDayNumber();
    dayController.jumpToItem((dayIndex));
  }
  _changeDay(index,) {
    setState(() {
     dayIndex = index; 
    });
  }
  _changeHour(index) {
    setState(() {
     hourIndex = index; 
    });
  }
  _changeMinute(index) {
    setState(() {
     minuteIndex = index; 
    });
  }

  _isLeapYear(int year){//判读是否为闰年
    if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0){
      return true;
    }else{
      return false;
    }
  }
  isDayNumber(String month){//判断月份确定每月天数
    int dayNumber;
    if(month == '01月' || month == '03月' || month == '05月' || month == '07月' || month == '08月' || month == '10月' || month == '12月'){
      dayNumber = 31;
    }else if(month == '04月' || month == '06月' || month == '09月' || month == '11月') {
      dayNumber = 30;
    }else if(month == '02月'){
      dayNumber = 28;
    }
    return dayNumber;
    
  }
  void _getDayNumber() {//切换月份获取当月天数
    var year = int.parse(new DateTime.now().year.toString());
    if(_isLeapYear(year)){//为闰年
      if(isDayNumber(monthList[monthIndex]) == 31){
        setState(() {
          dayList = dayList31; 
        });
      }else if(isDayNumber(monthList[monthIndex]) == 30){
        setState(() {
          dayList = dayList30; 
        });
      }else if(isDayNumber(monthList[monthIndex]) == 28){
        setState(() {
          dayList = dayList29; 
        });
      }
    }else{//为平年
      print(isDayNumber(monthList[monthIndex]));
      if(isDayNumber(monthList[monthIndex]) == 31){
        setState(() {
          dayList = dayList31; 
        });
      }else if(isDayNumber(monthList[monthIndex]) == 30){
        setState(() {
          dayList = dayList30; 
        });
      }else if(isDayNumber(monthList[monthIndex]) == 28){
        print(28);

        setState(() {
          dayList = dayList28; 
        });
      }
    }
  }
  
}

