import 'package:flutter/material.dart';
import '../components/city_picker.dart';
class SearchMessage extends StatefulWidget {
 final Function success;

  SearchMessage({Key key, this.success}) : super(key: key);

  _SearchMessageState createState() => _SearchMessageState();
}

class _SearchMessageState extends State<SearchMessage> {
  TextEditingController startAdressController = TextEditingController();
  TextEditingController endAdressController = TextEditingController();
  TextEditingController goodsNameController = TextEditingController();
  String startAdress;
  String endAdress;
  String goodsName = '';
  Map<String, String> startCodeMap;
  Map<String, String> endCodeMap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('搜索'),),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: input(startAdressController, '请输入出发地', false,(val){
               
              }),
              onTap: (){
                showPicker(context, (res){
                  setState(() {
                    startAdress = res['textValue'];
                    startAdressController.text = startAdress; 
                    startCodeMap = res;

                  });
                  print(startCodeMap);
                },true);
              },
            ),
            InkWell(
              child: input(endAdressController, '请输入目的地', false,(val){
               
              }),
              onTap: (){
                showPicker(context, (res){
                  setState(() {
                    endAdress = res['textValue'];
                    endAdressController.text = endAdress; 
                    endCodeMap = res;
                  
                  });
                }, true);
              },
            ),
            input(goodsNameController, '请输入货品名称', true,(val){
              setState(() {
               goodsName = val; 
              });
            }),
            InkWell(
              child: Container(
                width: 200.0,
                height: 50.0,
                margin: EdgeInsets.only(top: 20.0),
               decoration: BoxDecoration(
                 color: Theme.of(context).primaryColor,
                 borderRadius: BorderRadius.circular(5.0)
               ),
                child: Center(
                  child: Text('搜索',style: TextStyle(color: Colors.white,fontSize: 16.0),),
                )
              ),
              onTap: (){
                Navigator.of(context).pop();
                Map result = {'startCodeMap': startCodeMap, 'endCodeMap': endCodeMap, 'goodsName':goodsName};
                widget.success(result);
              },
            )
          ],
        )
      ),
    );
  }
}

Widget input(TextEditingController controller, String hintText, bool enabled, Function change){
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
        focusedBorder:InputBorder.none,
      ),
      cursorColor: Colors.black,
      enabled: enabled,
      onChanged: (text){
        return change(text);
      },
    ),
  );
}