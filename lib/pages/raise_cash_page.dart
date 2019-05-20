import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import 'package:flutter/services.dart';
import '../components/toast.dart';
import '../pages/change_password_page.dart';

class RaiseCashPage extends StatefulWidget {
  final num cash;
  RaiseCashPage({Key key,this.cash});
  @override
  _RaiseCashPageState createState() => _RaiseCashPageState();
}

class _RaiseCashPageState extends State<RaiseCashPage> {
  List bankCardList = [];
  String bankName = '';
  String accountNum = '';
  String inputMoney = '';
  num fee = 0.00;
  String moneys;
  String preMoneys;
  bool showMsg = false;
  RegExp regM = RegExp(r'(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)');//校验金钱格式
  @override
  void initState() { 
    super.initState();
    _getBankCartList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('提现'),),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF2F2F2),
          child: Column(
            children: <Widget>[
              defaultBankModel(),
              raiseCashModel(),
              Padding(child: null,padding: EdgeInsets.only(top: 60),),
              commonButton()
            ],
          ),
        ),
      )
    );
  }
  Widget defaultBankModel() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFF2F2F2),
            padding: EdgeInsets.only(left: 10,top: 16,bottom: 16),
            child: Text('到账银行卡'),
          ),
          InkWell(
            child: Container(
              height: ScreenUtil().setHeight(120),
              padding: EdgeInsets.only(left: 10,right:10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),
                  bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)),
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$bankName(${accountNum.length>0? accountNum.substring(accountNum.length-4) : ''})',style: TextStyle(fontSize: ScreenUtil().setSp(34)),),
                  Image.asset('assets/images/arrow.png',width: ScreenUtil().setWidth(22),)
                ],
              ),
            ),
            onTap: (){
              showBottomSheet(context,bankCardList,(val){
                print(val);
                setState(() {
                 bankName = val['bankName'];
                 accountNum = val['accountNum']; 
                });
              });
            },
          )
        ],
      ),
    );
  }
  Widget raiseCashModel() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1,color: Color(0xFFCCCCCC),),bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('提现金额',style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold),),
          itemInputWidget('¥',inputMoney.toString(), '', false, true, 'number',(res){
            // if(res != ''){
             setState(() {
              inputMoney = res; 
             });
            //  _caculateCharge();
            // }
          }),
          Padding(child: null,padding: EdgeInsets.only(top: 16),),
          showResult()
        ],
      ),
    );
  }
  Widget itemInputWidget(String title, String inputText, String hintText,bool obscureText,bool enabled, String inputType, Function change) {
    return Container(
      padding: EdgeInsets.only(left: 10, right:10),
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC))),
        color: Color(0xFFFFFFFF)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(36),fontWeight: FontWeight.bold)),
          Expanded(
            child:  _inputWidget(inputText, hintText, obscureText,enabled, inputType, change),
          )
         
        ],
      ),
    );
  }
  Widget _inputWidget( inputText, String hintText, bool obscureText, bool enabled, String inputType, Function change){
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0,),
      padding: EdgeInsets.only(left: 5.0),
      child: TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
          // 设置内容
          text: changeMoneyValue(inputText),
          // 保持光标在最后
          selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: changeOffset(inputText)))
          )
        ),
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: BorderSide(color: Colors.transparent)
          ),
          disabledBorder: InputBorder.none,
          enabledBorder:InputBorder.none,
          focusedBorder:InputBorder.none
        ),
        enabled: enabled,
        cursorColor: Colors.black,
        obscureText: obscureText,
        keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
        onChanged: (text){
          return change(text);
        },
      ),
    );
    
  }
  showResult() {
    if(moneys == null) {
      return Row(
        children: <Widget>[
          Text('当前账户余额${widget.cash.toStringAsFixed(2)}元，',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xFF888888)),),
          InkWell(
            child: Text('全部提现',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Theme.of(context).primaryColor),),
            onTap: (){
              _bindRaiseAllMoney();
            },
          )
          
        ],
      );
    }else {
      if(regM.hasMatch(moneys) && num.parse(moneys) - widget.cash <= 0 ){
        return Text('额外扣除¥${fee !=null? fee : ''}手续费',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xFF888888)),);
      }else {
        if(!regM.hasMatch(moneys) ){
          return Text('金钱格式输入有误',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Theme.of(context).primaryColor),);
        }else{
          return Text('输入金额超过账户余额',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Theme.of(context).primaryColor),);
        }
        
      }
    }
  }
  changeMoneyValue(String value) {
    if(value != '') {
      if(value.indexOf('.') == -1){
        setState(() {
        moneys = value; 
        });
        _caculateCharge();
        return value;
      }else{
        if(value.split('.')[1].length > 2){
          setState(() {
            moneys = value.replaceRange(value.split('.')[0].length + 3,value.length, ''); 
          });
          return value.replaceRange(value.split('.')[0].length + 3,value.length, '');
        }else{
          setState(() {
            moneys = value; 
          });
          _caculateCharge();
          return value;
        }
      }
    }else{
      setState(() {
        moneys = null; 
      });
      preMoneys = null;
      return '';
    }
    
    
    
  }
  changeOffset(String value) {
    if(value != '') {
      if(value.indexOf('.') == -1){
        return value.length;
      }else{
        if(value.split('.')[1].length > 2){
          return value.replaceRange(value.split('.')[0].length + 3,value.length, '').length;
        }else{
          return value.length;
        }
      }
    }else{

      return 0;
    }
  }
  Widget commonButton() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10,right:10),
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:Theme.of(context).primaryColor
        ),
        child: Center(
          child: Text('提现',style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Colors.white),),
        ),
      ),
      onTap: (){
        if(regM.hasMatch(moneys)){
          if(((num.parse(moneys) + fee)*100 - widget.cash*100)/100 <= 0){
            _checkPassword();
          }else{
            return Toast.toast(context, '余额不足以提现');
          }
          
        }else{
          return Toast.toast(context, '金钱格式有误');
        }
        
      },
    );
  }
  _getBankCartList() {//获取银行卡列表
    postAjax('mobileBankCardList', {}, context).then((res){
      if(res['code'] == 200 && res['content'] is List) {
        List list = res['content'];
        list.forEach((item){
          if(item['isDefault'] != null && item['isDefault'] == 1){
            setState(() {
              bankName = item['bankName'];
              accountNum = item['realAccount'];
            });
           
          }
        });
        setState(() {
         bankCardList = list; 
        });
      }
    });
  }
  _caculateCharge() {
    Map<String, dynamic> params = {};
    if(moneys != null && regM.hasMatch(moneys) && preMoneys !=moneys){
      params['amount'] = moneys;
      params['bankAccountNo'] = accountNum;
      postAjax('caculateCharge', params, context).then((res){
        if(res['code'] == 200) {
          print('提现手续费');
          print(res['content']);
          preMoneys = moneys;
          setState(() {
           fee = res['content']['serviceCharge'];
          });
        }
      });
    }
  }
  _bindRaiseAllMoney() {//全部提现
    Map<String, dynamic> params = {};
    params['amount'] = widget.cash;
    params['bankAccountNo'] = accountNum;
    postAjax('caculateCharge', params, context).then((res){
      if(res['code'] == 200){
        setState(() {
         fee = res['content']['serviceCharge'];
         inputMoney = res['content']['amount'].toString();
        });
      }
    });
  }
  _checkPassword() {//检查提现密码是否存在
    postAjax('checkPassword', {}, context).then((res){
      if(res['code'] == 200 && res['content']['result']){
        showRaiseCash(context,moneys,fee,(res){
          _doWithdraw(res['password']);
        });
      }else{
        Toast.toast(context, '请设置提现密码');
        Future.delayed(Duration(milliseconds: 1500),(){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ChangePasswordPage(type: 0,);
          }));
        });
      }
    });
  }
  _doWithdraw(password) {
    Map<String, dynamic> params = {};
    params['amount'] = moneys;
    params['accountNo'] = accountNum;
    params['payPassword'] = password;
    postAjax('doWithdraw', params, context).then((res){
      if(res['code'] == 200) {
        Toast.toast(context, '提现成功');
        Future.delayed(Duration(milliseconds: 1000),(){
          Navigator.popUntil(context, ModalRoute.withName('/account'));
        });

      }else{
        Navigator.of(context).pop();
        return Toast.toast(context, res['content']);
      }
    });
  }
  @override
  void dispose() { 
    bankCardList = [];
    bankName = '';
    accountNum = ''; 
    inputMoney = '';
    moneys = null;
    showMsg = false;
    super.dispose();
  }
}

showRaiseCash(BuildContext context,  money, fee,success){
  TextEditingController passwordController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController password3Controller = TextEditingController();
  TextEditingController password4Controller = TextEditingController();
  TextEditingController password5Controller = TextEditingController();
  TextEditingController password6Controller = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  showDialog(
    context: context,
   builder: (context){
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(icon: Icon(Icons.close),alignment: Alignment.topLeft,padding: EdgeInsets.all(1),onPressed: (){
            Navigator.of(context).pop('cancel');
          },)
        ],
      ),
      titlePadding: EdgeInsets.all(5),
    contentPadding: EdgeInsets.all(10),
      children: <Widget>[
        Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text('提现金额'),
                Padding(child: null,padding: EdgeInsets.only(top: 10),),
                Text('¥${money != null? money : ''}',style: TextStyle(fontSize: ScreenUtil().setSp(44),color: Theme.of(context).primaryColor),),
                Padding(child: null,padding: EdgeInsets.only(top: 10),),
                Text('额外扣除¥${fee != null? fee : ''}手续费',style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color(0xFF888888)
                ),)
              ],
            ),
          ),
        ),
        Divider(color: Color(0xFFF2F2F2),),
        Text('请输入交易密码'),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: _inputWidget(password1Controller,'', true, false, 'number', (res){},(){
                    passwordFocusNode.unfocus();
                    Future.delayed(Duration(milliseconds: 100),(){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    });
                    
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _inputWidget(password2Controller,'', true, false, 'number', (res){},(){
                    passwordFocusNode.unfocus();
                    Future.delayed(Duration(milliseconds: 100),(){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    });
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _inputWidget(password3Controller,'', true, false, 'number', (res){},(){
                    passwordFocusNode.unfocus();
                    Future.delayed(Duration(milliseconds: 100),(){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    });
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _inputWidget(password4Controller,'', true, false, 'number', (res){},(){
                    passwordFocusNode.unfocus();
                    Future.delayed(Duration(milliseconds: 100),(){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    });
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _inputWidget(password5Controller,'', true, false, 'number', (res){},(){
                   passwordFocusNode.unfocus();
                    Future.delayed(Duration(milliseconds: 100),(){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    });
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1, color: Color(0xFFCCCCCC)))
                  ),
                  child: _inputWidget(password6Controller,'', true, false, 'number', (res){},(){
                    passwordFocusNode.unfocus();
                    Future.delayed(Duration(milliseconds: 100),(){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    });
                  }),
                ),
              ),
              
            ],
          ),
        ),
        Container(
          height: 0,
          decoration: BoxDecoration(
            color: Colors.transparent
          ),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide(color: Colors.transparent)
              ),
              disabledBorder: InputBorder.none,
              enabledBorder:InputBorder.none,
              focusedBorder:InputBorder.none
            ),
            focusNode: passwordFocusNode,
            cursorColor: Colors.black,
            autofocus: true,
            keyboardType:TextInputType.number,
            maxLength: 6,
            onChanged: (value){
              value.length >= 1? password1Controller.text = value[0] : password1Controller.text ='';
              value.length >= 2? password2Controller.text = value[1] : password2Controller.text ='';
              value.length >= 3? password3Controller.text = value[2] : password3Controller.text ='';
              value.length >= 4? password4Controller.text = value[3] : password4Controller.text ='';
              value.length >= 5? password5Controller.text = value[4] : password5Controller.text ='';
              value.length >= 6? password6Controller.text = value[5] : password6Controller.text ='';
              if(value.length == 6){
                Map result = {};
                result['password'] = value;
                Navigator.of(context).pop('sure');
                success(result);

              }
            },
          ),
        )
      ],
    );
   }
  );
}
Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, bool enabled, String inputType, Function change, Function onTap){
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1,color: Color(0xFFCCCCCC)),
          left: BorderSide(width: 1,color: Color(0xFFCCCCCC)),
          bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)),
        )
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: BorderSide(color: Colors.transparent)
          ),
          disabledBorder: InputBorder.none,
          enabledBorder:InputBorder.none,
          focusedBorder:InputBorder.none
        ),
        enabled: enabled,
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        obscureText: obscureText,
        keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
        onChanged: (text){
          return change(text);
        },
      ),
    ),
    onTap: (){
      onTap();
    },
  );
  
}

showBottomSheet(BuildContext context, List list, Function success) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context){
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: list.length > 0
          ? list.map((item){
            return ListTile(
              leading: Image.asset('assets/images/bankcard.png',width:ScreenUtil().setWidth(50)),
              title: new Text(item['bankName'] != null? item['bankName'] : ''),
              contentPadding: EdgeInsets.only(left: 10),
              onTap: () {
                Navigator.pop(context);
                Map val = {};
                val['bankName'] = item['bankName'];
                val['accountNum'] = item['realAccount'];
                success(val);
              },
            );
          }).toList()
          : []
        ),
      );
    }
  );
}