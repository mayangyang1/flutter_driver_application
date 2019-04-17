import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showMyCupertinoDialog(BuildContext context, String title, String content, Function success) {
  showCupertinoDialog(
  context: context,
  builder: (context) {
    return new CupertinoAlertDialog(
      title: new Text(title),
      content: Padding(child: Text(content),padding: EdgeInsets.only(top: 10),),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop("点击了取消");
            success('cancel'); 
          },
          child: new Text("取消"),
        ),
          new FlatButton(
          onPressed: () {
            Navigator.of(context).pop("点击了确定");
            success('confirm'); 
          },
          child: new Text("确认"),
        ),
      ],
    );
  });
}