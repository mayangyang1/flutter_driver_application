import 'package:flutter/material.dart';

class RaiseCashPage extends StatefulWidget {
  @override
  _RaiseCashPageState createState() => _RaiseCashPageState();
}

class _RaiseCashPageState extends State<RaiseCashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('提现'),),
      body: Text('提现'),
    );
  }
}