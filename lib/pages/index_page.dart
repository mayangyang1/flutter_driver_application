import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './resource_page.dart';
import './waybill_page.dart';
import './mine_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      title: Text('货源')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.library_books),
      title: Text('运单')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我')
    ),
  ];

  final List<Widget> tabBodies = [
    ResourcePage(),
    WaybillPage(),
    MinePage(),
  ];
  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
           currentIndex = index;
           currentPage = tabBodies[currentIndex]; 
          });
        },
      ),
      body: currentPage,
    );
  }
}