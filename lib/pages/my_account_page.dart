import 'package:flutter/material.dart';


class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的交易账户'),),
      body: Container(
        child: Text('我的交易账户'),
      ),
    );
  }
}