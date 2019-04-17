import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/service_method.dart';
import '../mode/join_company_list_mode.dart';
import '../components/show_modal.dart';
import '../config/service_url.dart';
import '../mode/search_join_company_list.dart';
import '../components/toast.dart';

class JoinCompanyPage extends StatefulWidget {
  @override
  _JoinCompanyPageState createState() => _JoinCompanyPageState();
}

class _JoinCompanyPageState extends State<JoinCompanyPage> {
  TextEditingController companyController =TextEditingController();
  List companyList = [];
  String orgCode = '';
  List<SearchListContent> searchResultList = [];
  @override
  void initState() { 
    super.initState();
    _getJoinCompanyList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('挂靠公司'),),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF2F2F2),
          child: Column(
            children: <Widget>[
              companyListWidget(),
              addCompanyWidget(companyController, '请输入公司名称', false, 'text', (res){
                _getPartnerList(res);
              })
            ],
          ),
        ),
      )
    );
  }
  Widget companyListWidget() {
    return LimitedBox(
      maxHeight: ScreenUtil().setHeight(500),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: companyList.length > 0
            ? companyList.map((item){
                return conpanyItem(item);
              }).toList()
            : []
          )
        )
      ),
    );
  }
  Widget conpanyItem(item) {
    return Container( 
      padding: EdgeInsets.only(left: 10, right:10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Color(0xFFCCCCCC)),bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC)))
      ),
      height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(item?.orgFullName != null? item.orgFullName : ''),
          Switch(value: true,onChanged: (value){
            _bindCancel(item?.code);
          },)
        ],
      ),
    );
  }
  Widget addCompanyWidget(TextEditingController controller, String hintText, bool obscureText, String inputType, Function change) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _inputWidget(controller, hintText, obscureText, inputType, change),
          Padding(child: null,padding: EdgeInsets.only(top: 20)),
          searchList(),
          
          commonButton('添加', (){
            _addCompany();
          }),
          Padding(
            child: Text('司机和车辆将会一起挂靠到该公司, 并且可收到该公司的直接派车'),
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          )
        ],
      ),
    );
  }
  Widget _inputWidget(TextEditingController controller, String hintText, bool obscureText, String inputType, Function change){
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      padding: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black54),
        borderRadius: BorderRadius.circular(5.0)
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
        cursorColor: Colors.black,
        obscureText: obscureText,
        keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
        onChanged: (text){
          return change(text);
        },
      ),
    );
  }
  Widget commonButton(String title, Function success) {
    return InkWell(
      child: Container(
         margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(90),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(32),color: Colors.white),),
        ),
      ),
      onTap: success,
    );
  }
  Widget searchList() {
    return LimitedBox(
      maxHeight: ScreenUtil().setHeight(400),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: ScreenUtil().setHeight(400),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Color(0xFFf2f2f2)))
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: searchResultList.length > 0
            ? searchResultList.map((_item){
              return searchItem(_item);
            }).toList()
            : []
          
          ),
        ),
      )
    );
  }
  Widget searchItem(item) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
        ),
        child: Row(
          children: <Widget>[
            Radio(value: item.isChoice, groupValue: true,onChanged: (value){
              searchResultList.forEach((_item){
                if(_item.code == item.code) {
                  setState(() {
                    _item.isChoice = true;
                  });
                }else{
                  _item.isChoice = false;
                }
              });
            },),
            Text(item?.orgFullName != null? item.orgFullName : '')
          ],
        )
      ),
      onTap: (){
        searchResultList.forEach((_item){
          if(_item.code == item.code) {
            setState(() {
              _item.isChoice = true;
              orgCode = _item.code;
            });
          }else{
            _item.isChoice = false;
          }
        });
      },
    );
  }
  _getJoinCompanyList() {//获取已挂靠组织列表
    getAjax('getPertainOrg', '', context).then((res){
      JoinCompanyListMode data = JoinCompanyListMode.fromJson(res);
      if(data.code == 200 && data.content.length > 0) {
        setState(() {
         companyList = data.content; 
        });
      }
    });
  }
  _bindCancel(orgCode){
    showMyCupertinoDialog(context, '提示', '确认要解除挂靠?', (res){
      if(res == 'confirm'){
        
        _cancleCompany(orgCode);
      }
      
    });
  }
  _cancleCompany(orgCode) {//取消已挂靠的组织
    postAjaxStr('$serviceUrl/transport/transport/pertain/org/$orgCode/remove', {}, context).then((res){
      if(res['code'] == 200) {

        _getJoinCompanyList();
      }
    });
  }
  _addCompany() {//添加挂靠公司 
    if(orgCode == '' ){
      return Toast.toast(context, '请选择要挂靠的公司');
    }
    Map<String, dynamic> params = {'orgCode': orgCode};
    postAjax('addCompany', params, context).then((res){
      if(res['code'] == 200) {
        setState(() {
          searchResultList = [];
          companyController.text = '';
        });
        _getJoinCompanyList();

      }
    });
  }
  _getPartnerList( String orgFullName) {//查询伙伴列表
    String stringParams = '?orgFullName=$orgFullName&size=100';
    getAjax('manageList', stringParams, context).then((res){
      SearchJoinCampanyList data = SearchJoinCampanyList.fromJson(res);
      if(data.code == 200 && data.content.length > 0) {
        setState(() {
         searchResultList = data.content; 
         orgCode = '';
        });
      }
    });
  }
  @override
  void dispose() { 
    companyList = [];
    searchResultList = [];
    orgCode = '';
    super.dispose();
  }
}